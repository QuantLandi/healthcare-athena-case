#!/usr/bin/env python3
"""
Monte Carlo fair-value pricer — Healthcare Phoenix Autocallable (Banque Meridian case).

Self-contained reference implementation aligned with:
  - Exhibit A: payoff terms and observation schedule
  - Exhibit D: locked market snapshot (27 November 2026)

Product (Phoenix autocallable, non-memory coupons), as proposed in Exhibit A:
  - Quarterly conditional coupon 1.50% (6.00% p.a.) if index >= 60% of S0
  - Annual autocall if index >= 100% of S0 -> 100% notional + coupon on that date
  - At maturity (if not autocalled): 100% if index >= 60%; else 100% x (S_T / S0)
  - No memory on missed coupons

Terms are parameters, not constants, so the committee's "revise" options
(different coupon, barrier, or issue price) can be priced without editing code.

Model:
  - Risk-neutral GBM on the published decrement index:
        dS = (r - q) S dt + sigma S dW,   q = 5% continuous
  - Flat Black volatility sigma (default sweep 16/17/18%; desk band 16-18%)
  - Forward rates between observation dates inferred from locked OIS discount factors
  - Discount each cashflow with those OIS discount factors (Exhibit D)

Implementation notes:
  - Paths are built with one cumulative sum over the observation grid, so there
    is no Python-level loop over dates or paths.
  - The Brownian grid is volatility-independent, so a single simulated block is
    reused for every sigma in the sweep (common random numbers => smooth,
    comparable vol sensitivities).
  - Work is processed in blocks with streaming mean/variance, so peak memory is
    set by --block-size rather than by total path count.

Usage:
    uv run phoenix_mc_pricer.py --paths 50000
    uv run phoenix_mc_pricer.py --until-converged --sigma 0.17 --verbose
    uv run phoenix_mc_pricer.py --coupon-pa 0.05 --coupon-barrier 0.55
    uv run phoenix_mc_pricer.py --solve-margin          # coupon that clears 1.5%
    uv run phoenix_mc_pricer.py --flat-rate 0.0303      # Exhibit D first-pass shortcut

Dependencies: numpy only.
"""

from __future__ import annotations

import argparse
import math
from collections.abc import Sequence
from dataclasses import dataclass, replace
from typing import Literal

import numpy as np

# ---------------------------------------------------------------------------
# Market snapshot — locked for the assignment (Exhibit D)
# ---------------------------------------------------------------------------

S0 = 2318.47
NOTIONAL = 100.0  # price everything as % of denomination
Q_DECREMENT = 0.05  # index already embeds 5% decrement; omitting q overstates FV

MARGIN_FLOOR = 1.5  # desk minimum gross structuring margin (% of nominal)
DEFAULT_SIGMAS = (0.16, 0.17, 0.18)
COUPONS_PER_YEAR = 4


@dataclass(frozen=True)
class Observation:
    label: str
    t_years: float
    df_ois: float
    event: Literal["coupon", "coupon_autocall", "final"]


OBSERVATIONS: tuple[Observation, ...] = (
    Observation("2027-03-01", 0.2574, 0.99393, "coupon"),
    Observation("2027-06-01", 0.5092, 0.98717, "coupon"),
    Observation("2027-09-01", 0.7611, 0.97961, "coupon"),
    Observation("2027-12-01", 1.0103, 0.97143, "coupon_autocall"),
    Observation("2028-03-01", 1.2594, 0.96424, "coupon"),
    Observation("2028-06-01", 1.5113, 0.95692, "coupon"),
    Observation("2028-09-01", 1.7632, 0.94955, "coupon"),
    Observation("2028-12-01", 2.0123, 0.94222, "coupon_autocall"),
    Observation("2029-03-01", 2.2587, 0.93523, "coupon"),
    Observation("2029-06-01", 2.5106, 0.92809, "coupon"),
    Observation("2029-09-01", 2.7625, 0.92098, "coupon"),
    Observation("2029-12-01", 3.0116, 0.91397, "coupon_autocall"),
    Observation("2030-03-01", 3.2580, 0.90712, "coupon"),
    Observation("2030-06-01", 3.5099, 0.90015, "coupon"),
    Observation("2030-09-01", 3.7618, 0.89322, "coupon"),
    Observation("2030-12-01", 4.0110, 0.88638, "coupon_autocall"),
    Observation("2031-03-01", 4.2574, 0.87965, "coupon"),
    Observation("2031-06-01", 4.5092, 0.87281, "coupon"),
    Observation("2031-09-01", 4.7611, 0.86599, "coupon"),
    Observation("2031-12-01", 5.0103, 0.85929, "final"),
)

N_OBS = len(OBSERVATIONS)
DFS = np.array([o.df_ois for o in OBSERVATIONS], dtype=np.float64)
TIMES = np.array([o.t_years for o in OBSERVATIONS], dtype=np.float64)
DT = np.diff(TIMES, prepend=0.0)  # trade date is t = 0
SQRT_DT = np.sqrt(DT)
AUTOCALL_OBS_IDX = np.array(
    [j for j, o in enumerate(OBSERVATIONS) if o.event == "coupon_autocall"],
    dtype=int,
)
FINAL_OBS = N_OBS - 1


# ---------------------------------------------------------------------------
# Product terms — defaults are the Exhibit A proposal
# ---------------------------------------------------------------------------


@dataclass(frozen=True)
class ProductTerms:
    """
    Economic levers the pricing committee can move.

    Barriers are fractions of the initial level so a revised term sheet reads
    the same way the desk discusses it ("drop the barrier to 55%").
    """

    coupon_pa: float = 0.06
    coupon_barrier: float = 0.60
    autocall_barrier: float = 1.00
    issue_price_pct: float = 100.0

    @property
    def coupon_amount_pct(self) -> float:
        """Cash paid on a single coupon date, in % of notional."""
        return self.coupon_pa / COUPONS_PER_YEAR * NOTIONAL

    @property
    def coupon_barrier_level(self) -> float:
        return self.coupon_barrier * S0

    @property
    def autocall_barrier_level(self) -> float:
        return self.autocall_barrier * S0

    def describe(self) -> str:
        return (
            f"coupon {self.coupon_pa:.2%} p.a. "
            f"({self.coupon_amount_pct:.2f}% quarterly) | "
            f"coupon barrier {self.coupon_barrier:.0%} | "
            f"autocall {self.autocall_barrier:.0%} | "
            f"issue {self.issue_price_pct:.2f}%"
        )


PROPOSED_TERMS = ProductTerms()


# ---------------------------------------------------------------------------
# Path generation
# ---------------------------------------------------------------------------


def cumulative_rate_drift(flat_rate: float | None = None) -> np.ndarray:
    """
    Cumulative (r - q) * t along the observation grid.

    Segment forwards come from the locked discount factors so that simulated
    paths and discounted payoffs share one curve. Exhibit D also allows a flat
    3.03% first pass; that shortcut moves fair value by well under a basis point.

    Volatility does not appear here, which is what lets one simulated Brownian
    grid serve the whole vol sweep.
    """
    if flat_rate is None:
        df_prev = np.concatenate(([1.0], DFS[:-1]))
        r_fwd = -np.log(DFS / df_prev) / DT
    else:
        r_fwd = np.full(N_OBS, flat_rate, dtype=np.float64)
    return np.cumsum((r_fwd - Q_DECREMENT) * DT)


def brownian_grid(shocks: np.ndarray) -> np.ndarray:
    """
    Brownian motion W(t_j) on the observation grid, shape (N_OBS, n_paths).

    One cumulative sum replaces a date-by-date loop; the result is independent
    of sigma so it can be priced at several volatilities without redrawing.
    """
    return np.cumsum(SQRT_DT[:, None] * shocks, axis=0)


def levels_from_brownian(
    brownian: np.ndarray,
    sigma: float,
    cum_drift: np.ndarray,
) -> np.ndarray:
    """
    Index levels implied by a Brownian grid at one volatility.

    Closed-form GBM solution, so no stepwise recursion is needed:
        S(t) = S0 * exp[(r - q) t - 0.5 sigma^2 t + sigma W(t)]
    """
    log_levels = np.log(S0) + (cum_drift - 0.5 * sigma**2 * TIMES)[:, None] + sigma * brownian
    return np.exp(log_levels)


def discounted_pv(levels: np.ndarray, terms: ProductTerms) -> np.ndarray:
    """
    Present value per path (% of notional), OIS-discounted.

    Vectorised implementation of Exhibit A payoff logic. We work in PV space
    (coupon x DF) because every cashflow is discounted at its observation
    date — there is no single constant rate to apply at the end.

    Autocall timing: Phoenix notes terminate on the *first* annual observation
    where the index clears the autocall barrier. argmax on the hit mask returns
    that index; paths with no hit fall through to maturity logic.
    """
    n_paths = levels.shape[1]
    coupon_pay = np.where(levels >= terms.coupon_barrier_level, terms.coupon_amount_pct, 0.0)
    # Prefix sum lets us pay only coupons earned *before* early exit without
    # looping path-by-path (coupons after autocall must not be counted).
    cum_coupon_pv = np.cumsum(coupon_pay * DFS[:, None], axis=0)

    hit = levels[AUTOCALL_OBS_IDX, :] >= terms.autocall_barrier_level
    any_hit = hit.any(axis=0)
    # argmax returns 0 when no hit, but any_hit gates that — otherwise we'd
    # treat "never autocalled" as "autocalled on the first date".
    first_hit = np.argmax(hit, axis=0)
    exit_obs = np.where(any_hit, AUTOCALL_OBS_IDX[first_hit], FINAL_OBS)

    pv = cum_coupon_pv[exit_obs, np.arange(n_paths)]
    autocall_notionals = np.where(any_hit, NOTIONAL * DFS[exit_obs], 0.0)

    s_final = levels[FINAL_OBS, :]
    # Maturity: at or above the barrier pays par; below it the investor takes
    # linear index loss. Coupon at maturity is handled by the prefix sum above.
    maturity_notional = np.where(
        ~any_hit,
        np.where(
            s_final >= terms.coupon_barrier_level,
            NOTIONAL * DFS[FINAL_OBS],
            NOTIONAL * (s_final / S0) * DFS[FINAL_OBS],
        ),
        0.0,
    )

    return pv + autocall_notionals + maturity_notional


# ---------------------------------------------------------------------------
# Accumulation and results
# ---------------------------------------------------------------------------


@dataclass
class RunningStats:
    """
    Streaming mean and variance (Chan/Welford batch update).

    Keeping only three scalars per volatility means convergence runs never hold
    the full sample in memory and avoid repeatedly reallocating a growing array.
    """

    n: int = 0
    mean: float = 0.0
    m2: float = 0.0

    def update(self, sample: np.ndarray) -> None:
        n_b = int(sample.size)
        mean_b = float(sample.mean())
        m2_b = float(((sample - mean_b) ** 2).sum())

        if self.n == 0:
            self.n, self.mean, self.m2 = n_b, mean_b, m2_b
            return

        n_total = self.n + n_b
        delta = mean_b - self.mean
        self.mean += delta * n_b / n_total
        self.m2 += m2_b + delta**2 * self.n * n_b / n_total
        self.n = n_total

    @property
    def std_error(self) -> float:
        if self.n < 2:
            return math.inf
        return math.sqrt(self.m2 / (self.n - 1) / self.n)


@dataclass(frozen=True)
class PriceResult:
    """One volatility's fair value. Margin is derived, never stored twice."""

    sigma: float
    fair_value_pct: float
    std_error_pct: float
    n_paths: int
    issue_price_pct: float
    converged: bool | None = None

    @property
    def margin_pct(self) -> float:
        return self.issue_price_pct - self.fair_value_pct

    def clears(self, margin_floor: float = MARGIN_FLOOR) -> bool:
        return self.margin_pct >= margin_floor


def price_grid(
    sigmas: float | Sequence[float],
    *,
    max_paths: int,
    terms: ProductTerms = PROPOSED_TERMS,
    se_tol: float | None = None,
    block_size: int = 50_000,
    min_paths: int = 50_000,
    seed: int | None = 42,
    antithetic: bool = True,
    flat_rate: float | None = None,
    verbose: bool = False,
) -> list[PriceResult]:
    """
    Price one or more volatilities from a shared set of simulated paths.

    Sole pricing entry point, so defaults cannot drift between the CLI and
    imported use. A bare float is accepted for the common single-vol call.

    Passing se_tol switches on early stopping: blocks keep coming until every
    volatility reaches that standard error (subject to min_paths and max_paths).
    With se_tol=None the run is a plain fixed-size Monte Carlo of max_paths.

    Results are returned in the order requested. Reproducibility depends on
    seed, block size and the antithetic setting, since those determine how
    shocks are drawn.
    """
    if isinstance(sigmas, (int, float)):
        sigmas = [float(sigmas)]

    rng = np.random.default_rng(seed)
    cum_drift = cumulative_rate_drift(flat_rate)
    stats = {sigma: RunningStats() for sigma in sigmas}
    n_done = 0
    block_no = 0

    while n_done < max_paths:
        block_no += 1
        n_draw = min(block_size, max_paths - n_done)
        n_half = max(1, n_draw // 2) if antithetic else n_draw
        z = rng.standard_normal((N_OBS, n_half))
        # Antithetic pairs (Z, -Z) reduce variance for symmetric payoffs without
        # doubling runtime as much as independent paths would.
        shocks = np.concatenate([z, -z], axis=1) if antithetic else z

        brownian = brownian_grid(shocks)
        for sigma in sigmas:
            levels = levels_from_brownian(brownian, sigma, cum_drift)
            stats[sigma].update(discounted_pv(levels, terms))
        n_done += shocks.shape[1]

        if verbose:
            summary = "  ".join(
                f"s={sigma:.1%}: FV={stats[sigma].mean:.4f}% SE={stats[sigma].std_error:.4f}%"
                for sigma in sigmas
            )
            print(f"  block={block_no:3d}  paths={n_done:>9,}  {summary}")

        if (
            se_tol is not None
            and n_done >= min_paths
            and all(st.std_error <= se_tol for st in stats.values())
        ):
            break

    converged = None if se_tol is None else all(st.std_error <= se_tol for st in stats.values())
    return [
        PriceResult(
            sigma=sigma,
            fair_value_pct=stats[sigma].mean,
            std_error_pct=stats[sigma].std_error,
            n_paths=stats[sigma].n,
            issue_price_pct=terms.issue_price_pct,
            converged=converged,
        )
        for sigma in sigmas
    ]


def solve_coupon_for_margin(
    sigma: float,
    *,
    target_margin: float = MARGIN_FLOOR,
    terms: ProductTerms = PROPOSED_TERMS,
    n_paths: int = 50_000,
    seed: int | None = 42,
    antithetic: bool = True,
    flat_rate: float | None = None,
    coupon_cap: float = 0.20,
    tol: float = 0.002,
    max_iter: int = 40,
) -> tuple[ProductTerms, PriceResult] | None:
    """
    Find the annual coupon whose fair value leaves exactly `target_margin`.

    Fair value rises monotonically with the coupon, so bisection is enough.
    Every trial reuses the same seed, which makes the objective deterministic
    (common random numbers) and stops Monte Carlo noise from stalling the search.

    Returns the revised terms and their pricing, or None when even a zero
    coupon cannot reach the target margin.
    """

    def margin_at(coupon_pa: float) -> tuple[float, PriceResult]:
        trial = replace(terms, coupon_pa=coupon_pa)
        result = price_grid(
            sigma,
            max_paths=n_paths,
            terms=trial,
            seed=seed,
            antithetic=antithetic,
            flat_rate=flat_rate,
        )[0]
        return result.margin_pct, result

    lo_margin, lo_result = margin_at(0.0)
    if lo_margin < target_margin:
        return None  # product is uneconomic even with no coupon

    hi = coupon_cap
    hi_margin, _ = margin_at(hi)
    if hi_margin > target_margin:
        # Cap is still too cheap; report the cap rather than searching forever.
        return replace(terms, coupon_pa=hi), margin_at(hi)[1]

    lo = 0.0
    best_terms, best_result = replace(terms, coupon_pa=lo), lo_result
    for _ in range(max_iter):
        mid = 0.5 * (lo + hi)
        mid_margin, mid_result = margin_at(mid)
        best_terms, best_result = replace(terms, coupon_pa=mid), mid_result
        if abs(mid_margin - target_margin) <= tol:
            break
        # Higher coupon => richer note => thinner margin.
        if mid_margin > target_margin:
            lo = mid
        else:
            hi = mid

    return best_terms, best_result


# ---------------------------------------------------------------------------
# Reporting
# ---------------------------------------------------------------------------


def print_report(
    results: Sequence[PriceResult],
    *,
    terms: ProductTerms,
    rate_mode: str,
    run_mode: str,
) -> None:
    print("=" * 76)
    print("Healthcare Phoenix Autocallable - Monte Carlo fair value")
    print(f"Snapshot: 27 Nov 2026  |  S0 = {S0:.2f}  |  q = {Q_DECREMENT:.0%}")
    print(f"Terms:     {terms.describe()}")
    print(f"Rate mode: {rate_mode}")
    print(f"Run mode:  {run_mode}")
    print("=" * 76)
    print(f"{'sigma':>8}  {'FV (%)':>10}  {'SE':>8}  {'Margin':>10}  {'Paths':>10}")
    print("-" * 76)
    for res in results:
        tag = "" if res.converged is None else (" ok" if res.converged else " !")
        print(
            f"{res.sigma:7.1%}  {res.fair_value_pct:10.4f}  {res.std_error_pct:8.4f}  "
            f"{res.margin_pct:10.4f}  {res.n_paths:>9,}{tag}"
        )
    print("-" * 76)
    if results and results[0].converged is not None:
        print("  (ok = SE target met; ! = stopped at max-paths cap)")

    # Base case is the middle of the sweep, so a single-vol run reports on itself.
    base = results[len(results) // 2]
    print(f"\nBase case (sigma={base.sigma:.1%}): FV = {base.fair_value_pct:.2f}%")
    print(f"  Gross margin at {base.issue_price_pct:.0f}% issue:   {base.margin_pct:.2f}%")
    print(f"  Desk margin floor:             {MARGIN_FLOOR:.2f}%")
    if not base.clears():
        print("  -> Proposed terms are too rich for the 1.5% margin target.")
    print()


def print_solver_report(
    solutions: Sequence[tuple[float, tuple[ProductTerms, PriceResult] | None]],
    *,
    target_margin: float,
    n_paths: int,
) -> None:
    print("=" * 76)
    print(f"Revised terms that clear a {target_margin:.2f}% margin (coupon solved per vol)")
    print(f"Fixed {n_paths:,} paths per trial, common random numbers")
    print("=" * 76)
    print(f"{'sigma':>8}  {'coupon p.a.':>12}  {'quarterly':>10}  {'FV (%)':>10}  {'Margin':>10}")
    print("-" * 76)
    for sigma, solution in solutions:
        if solution is None:
            print(f"{sigma:7.1%}  {'no solution':>12}")
            continue
        revised, result = solution
        print(
            f"{sigma:7.1%}  {revised.coupon_pa:11.2%}  "
            f"{revised.coupon_amount_pct:9.2f}%  "
            f"{result.fair_value_pct:10.4f}  {result.margin_pct:10.4f}"
        )
    print("-" * 76)
    print()


def main() -> None:
    parser = argparse.ArgumentParser(
        description="Monte Carlo pricer for the Healthcare Phoenix Autocallable case study.",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog=(
            "Examples:\n"
            "  uv run phoenix_mc_pricer.py --paths 50000\n"
            "  uv run phoenix_mc_pricer.py --until-converged --sigma 0.17 --verbose\n"
            "  uv run phoenix_mc_pricer.py --coupon-pa 0.05 --coupon-barrier 0.55\n"
            "  uv run phoenix_mc_pricer.py --solve-margin\n"
        ),
    )
    mode = parser.add_mutually_exclusive_group()
    mode.add_argument(
        "--paths",
        type=int,
        metavar="N",
        help="Fixed number of Monte Carlo paths (default: 50000).",
    )
    mode.add_argument(
        "--until-converged",
        action="store_true",
        help="Run blocks until std error <= --se-tol (see --min-paths, --max-paths).",
    )

    terms_group = parser.add_argument_group("product terms (defaults = Exhibit A proposal)")
    terms_group.add_argument(
        "--coupon-pa",
        type=float,
        default=PROPOSED_TERMS.coupon_pa,
        metavar="R",
        help="Annual conditional coupon, e.g. 0.06 for 6%% p.a.",
    )
    terms_group.add_argument(
        "--coupon-barrier",
        type=float,
        default=PROPOSED_TERMS.coupon_barrier,
        metavar="F",
        help="Coupon and capital barrier as a fraction of S0 (default 0.60).",
    )
    terms_group.add_argument(
        "--autocall-barrier",
        type=float,
        default=PROPOSED_TERMS.autocall_barrier,
        metavar="F",
        help="Autocall trigger as a fraction of S0 (default 1.00).",
    )
    terms_group.add_argument(
        "--issue-price",
        type=float,
        default=PROPOSED_TERMS.issue_price_pct,
        metavar="P",
        help="Issue price in %% of denomination (default 100.0).",
    )
    terms_group.add_argument(
        "--solve-margin",
        type=float,
        nargs="?",
        const=MARGIN_FLOOR,
        default=None,
        metavar="TARGET",
        help="Also solve for the coupon that leaves TARGET margin (default 1.5).",
    )

    parser.add_argument("--sigma", type=float, default=None, help="Flat vol (e.g. 0.17).")
    parser.add_argument("--seed", type=int, default=42, help="RNG seed.")
    parser.add_argument("--no-antithetic", action="store_true", help="Disable antithetic variates.")
    parser.add_argument(
        "--se-tol",
        type=float,
        default=0.05,
        help="Convergence target for std error, in %% of notional (default: 0.05 = 5 bp).",
    )
    parser.add_argument(
        "--block-size",
        type=int,
        default=50_000,
        help="Paths simulated per block; caps peak memory (default: 50000).",
    )
    parser.add_argument(
        "--min-paths",
        type=int,
        default=50_000,
        help="Minimum paths before checking convergence (default: 50000).",
    )
    parser.add_argument(
        "--max-paths",
        type=int,
        default=2_000_000,
        help="Hard cap on paths in --until-converged mode (default: 2000000).",
    )
    parser.add_argument(
        "--verbose",
        action="store_true",
        help="Print block-by-block progress.",
    )
    parser.add_argument(
        "--flat-rate",
        type=float,
        default=None,
        metavar="R",
        help=(
            "Use constant continuous rate R for GBM drift (e.g. 0.0303). "
            "Default: DF-implied forwards from Exhibit D."
        ),
    )
    args = parser.parse_args()

    terms = ProductTerms(
        coupon_pa=args.coupon_pa,
        coupon_barrier=args.coupon_barrier,
        autocall_barrier=args.autocall_barrier,
        issue_price_pct=args.issue_price,
    )
    sigmas = [args.sigma] if args.sigma is not None else list(DEFAULT_SIGMAS)
    n_paths = args.paths if args.paths is not None else 50_000
    rate_mode = (
        f"flat r={args.flat_rate:.2%} (Exhibit D first-pass)"
        if args.flat_rate is not None
        else "DF-implied forward rates (Exhibit D table)"
    )
    run_mode = (
        f"until converged (SE <= {args.se_tol:.4f}%, "
        f"block={args.block_size:,}, min={args.min_paths:,}, max={args.max_paths:,})"
        if args.until_converged
        else f"fixed paths ({n_paths:,}, block={min(args.block_size, n_paths):,})"
    )

    results = price_grid(
        sigmas,
        max_paths=args.max_paths if args.until_converged else n_paths,
        terms=terms,
        se_tol=args.se_tol if args.until_converged else None,
        block_size=args.block_size,
        min_paths=args.min_paths,
        seed=args.seed,
        antithetic=not args.no_antithetic,
        flat_rate=args.flat_rate,
        verbose=args.verbose,
    )
    print_report(results, terms=terms, rate_mode=rate_mode, run_mode=run_mode)

    if args.solve_margin is not None:
        solutions = [
            (
                sigma,
                solve_coupon_for_margin(
                    sigma,
                    target_margin=args.solve_margin,
                    terms=terms,
                    n_paths=n_paths,
                    seed=args.seed,
                    antithetic=not args.no_antithetic,
                    flat_rate=args.flat_rate,
                ),
            )
            for sigma in sigmas
        ]
        print_solver_report(solutions, target_margin=args.solve_margin, n_paths=n_paths)


if __name__ == "__main__":
    main()
