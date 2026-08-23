#!/usr/bin/env python3
"""
Monte Carlo fair-value pricer — Healthcare Phoenix Autocallable (Banque Meridian case).

Self-contained reference implementation aligned with:
  - Exhibit A: payoff terms and observation schedule
  - Exhibit D: locked market snapshot (27 November 2026)

Product (Phoenix autocallable, non-memory coupons):
  - Quarterly conditional coupon 1.50% if index >= 60% of S0
  - Annual autocall if index >= 100% of S0 -> 100% notional + coupon on that date
  - At maturity (if not autocalled): 100% if index >= 60%; else 100% x (S_T / S0)
  - No memory on missed coupons

Model:
  - Risk-neutral GBM on the published decrement index:
        dS = (r - q) S dt + sigma S dW,   q = 5% continuous
  - Flat Black volatility sigma (default 17%; desk band 16-18%)
  - Forward rates between observation dates inferred from locked OIS discount factors
  - Discount each cashflow with those OIS discount factors (Exhibit D)

Usage:
    uv run spreadsheet/phoenix_mc_pricer.py --paths 50000
    uv run spreadsheet/phoenix_mc_pricer.py --until-converged --sigma 0.17
    uv run spreadsheet/phoenix_mc_pricer.py --until-converged --se-tol 0.005 --verbose
    uv run spreadsheet/phoenix_mc_pricer.py --flat-rate 0.0303   # Exhibit D first-pass shortcut

Dependencies: numpy only.
"""

from __future__ import annotations

import argparse
from dataclasses import dataclass
from typing import Literal

import numpy as np

# ---------------------------------------------------------------------------
# Locked case inputs (Exhibit D / Exhibit A)
# ---------------------------------------------------------------------------

S0 = 2318.47
COUPON_BARRIER = 0.60 * S0
AUTOCALL_BARRIER = S0
COUPON_RATE = 0.015  # 1.50% of notional per quarter
NOTIONAL = 100.0
Q_DECREMENT = 0.05

MARGIN_FLOOR = 1.5
FLAT_RATE_FIRST_PASS = 0.0303  # 5Y continuous zero in Exhibit D


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
AUTOCALL_OBS_IDX = np.array(
    [j for j, o in enumerate(OBSERVATIONS) if o.event == "coupon_autocall"],
    dtype=int,
)
DFS = np.array([o.df_ois for o in OBSERVATIONS], dtype=np.float64)


def simulate_index_levels(
    sigma: float,
    shocks: np.ndarray,
    flat_rate: float | None = None,
) -> np.ndarray:
    """
    Simulate index levels on the observation grid under GBM.

    Drift uses DF-implied forward rates by default. Pass flat_rate=0.0303 to
    match Exhibit D's acceptable first-pass constant-rate shortcut.
    """
    n_paths = shocks.shape[1]
    levels = np.empty((N_OBS, n_paths), dtype=np.float64)
    s = np.full(n_paths, S0, dtype=np.float64)
    df_prev = 1.0
    t_prev = 0.0

    for j, obs in enumerate(OBSERVATIONS):
        dt = obs.t_years - t_prev
        if flat_rate is not None:
            r_fwd = flat_rate
        else:
            r_fwd = -np.log(obs.df_ois / df_prev) / dt
        drift = (r_fwd - Q_DECREMENT - 0.5 * sigma**2) * dt
        diffusion = sigma * np.sqrt(dt) * shocks[j, :]
        s = s * np.exp(drift + diffusion)
        levels[j, :] = s
        df_prev = obs.df_ois
        t_prev = obs.t_years

    return levels


def discounted_pv_fully_vectorised(levels: np.ndarray) -> np.ndarray:
    """Present value per path (% of notional), OIS-discounted."""
    n_paths = levels.shape[1]
    coupon_pay = np.where(levels >= COUPON_BARRIER, COUPON_RATE * NOTIONAL, 0.0)
    cum_coupon_pv = np.cumsum(coupon_pay * DFS[:, None], axis=0)

    autocall_levels = levels[AUTOCALL_OBS_IDX, :]
    hit = autocall_levels >= AUTOCALL_BARRIER
    any_hit = hit.any(axis=0)
    first_hit = np.argmax(hit, axis=0)
    exit_obs = np.where(any_hit, AUTOCALL_OBS_IDX[first_hit], N_OBS - 1)

    pv = cum_coupon_pv[exit_obs, np.arange(n_paths)]
    autocall_notionals = np.where(any_hit, NOTIONAL * DFS[exit_obs], 0.0)

    s_final = levels[N_OBS - 1, :]
    maturity_notional = np.where(
        ~any_hit,
        np.where(
            s_final >= COUPON_BARRIER,
            NOTIONAL * DFS[N_OBS - 1],
            NOTIONAL * (s_final / S0) * DFS[N_OBS - 1],
        ),
        0.0,
    )

    return pv + autocall_notionals + maturity_notional


def simulate_batch_pvs(
    sigma: float,
    n_paths: int,
    rng: np.random.Generator,
    *,
    antithetic: bool,
    flat_rate: float | None,
) -> np.ndarray:
    """Draw one batch of paths and return discounted PVs (% of notional)."""
    n_half = n_paths // 2 if antithetic else n_paths
    z = rng.standard_normal((N_OBS, n_half))
    shocks = np.concatenate([z, -z], axis=1) if antithetic else z
    levels = simulate_index_levels(sigma, shocks, flat_rate=flat_rate)
    return discounted_pv_fully_vectorised(levels)


def _result_from_pvs(pvs: np.ndarray, *, converged: bool | None = None) -> dict[str, float | bool | int]:
    fv = float(np.mean(pvs))
    se = float(np.std(pvs, ddof=1) / np.sqrt(len(pvs)))
    out: dict[str, float | bool | int] = {
        "fair_value_pct": fv,
        "std_error_pct": se,
        "margin_at_100_issue_pct": 100.0 - fv,
        "n_paths": int(len(pvs)),
    }
    if converged is not None:
        out["converged"] = converged
    return out


def price_phoenix_fixed(
    sigma: float,
    n_paths: int,
    seed: int | None = 42,
    antithetic: bool = True,
    flat_rate: float | None = None,
) -> dict[str, float | bool | int]:
    """Run a single Monte Carlo with a fixed path count."""
    rng = np.random.default_rng(seed)
    pvs = simulate_batch_pvs(
        sigma,
        n_paths,
        rng,
        antithetic=antithetic,
        flat_rate=flat_rate,
    )
    return _result_from_pvs(pvs)


def price_phoenix_until_converged(
    sigma: float,
    *,
    se_tol: float = 0.01,
    batch_size: int = 10_000,
    min_paths: int = 50_000,
    max_paths: int = 2_000_000,
    seed: int | None = 42,
    antithetic: bool = True,
    flat_rate: float | None = None,
    verbose: bool = False,
) -> dict[str, float | bool | int]:
    """
    Run Monte Carlo in batches until the standard error falls below se_tol.

    Convergence criterion (all must hold):
      - n_paths >= min_paths
      - std_error <= se_tol   (se_tol is in %-of-notional units; 0.01 = 1 bp)

    Stops at max_paths with converged=False if the SE target is not met.
    """
    rng = np.random.default_rng(seed)
    chunks: list[np.ndarray] = []
    n_total = 0
    batch_no = 0

    while n_total < max_paths:
        batch_no += 1
        n_draw = min(batch_size, max_paths - n_total)
        if n_draw <= 0:
            break
        pvs = simulate_batch_pvs(
            sigma,
            n_draw,
            rng,
            antithetic=antithetic,
            flat_rate=flat_rate,
        )
        chunks.append(pvs)
        n_total += len(pvs)
        all_pvs = np.concatenate(chunks)
        fv = float(np.mean(all_pvs))
        se = float(np.std(all_pvs, ddof=1) / np.sqrt(len(all_pvs)))

        if verbose:
            print(
                f"  sigma={sigma:.1%}  batch={batch_no:3d}  "
                f"paths={n_total:>8,}  FV={fv:.4f}%  SE={se:.4f}%"
            )

        if n_total >= min_paths and se <= se_tol:
            res = _result_from_pvs(all_pvs, converged=True)
            res["batches"] = batch_no
            return res

    all_pvs = np.concatenate(chunks)
    res = _result_from_pvs(all_pvs, converged=False)
    res["batches"] = batch_no
    return res


def price_phoenix(
    sigma: float,
    n_paths: int = 50_000,
    seed: int | None = 42,
    antithetic: bool = True,
    flat_rate: float | None = None,
) -> dict[str, float | bool | int]:
    """Backward-compatible alias for fixed-path pricing."""
    return price_phoenix_fixed(
        sigma,
        n_paths,
        seed=seed,
        antithetic=antithetic,
        flat_rate=flat_rate,
    )


def print_report(
    results_by_sigma: list[tuple[float, dict[str, float | bool | int]]],
    *,
    rate_mode: str,
    run_mode: str,
) -> None:
    print("=" * 72)
    print("Healthcare Phoenix Autocallable - Monte Carlo fair value")
    print(f"Snapshot: 27 Nov 2026  |  S0 = {S0:.2f}  |  q = {Q_DECREMENT:.0%}")
    print(f"Rate mode: {rate_mode}")
    print(f"Run mode:  {run_mode}")
    print("=" * 72)
    print(f"{'sigma':>8}  {'FV (%)':>10}  {'SE':>8}  {'Margin':>10}  {'Paths':>10}")
    print("-" * 72)
    for sigma, res in results_by_sigma:
        fv = float(res["fair_value_pct"])
        n_paths = int(res["n_paths"])
        tag = ""
        if "converged" in res:
            tag = " ok" if res["converged"] else " !"
        print(
            f"{sigma:7.1%}  {fv:10.4f}  {float(res['std_error_pct']):8.4f}  "
            f"{float(res['margin_at_100_issue_pct']):10.4f}  {n_paths:>9,}{tag}"
        )
    print("-" * 72)
    if results_by_sigma and "converged" in results_by_sigma[0][1]:
        print("  (ok = SE target met; ! = stopped at max-paths cap)")

    if any(abs(s - 0.17) < 1e-9 for s, _ in results_by_sigma):
        base = next(r for s, r in results_by_sigma if abs(s - 0.17) < 1e-9)
        fv17 = float(base["fair_value_pct"])
        print(f"\nBase case (sigma=17%): FV = {fv17:.2f}%  |  paths = {int(base['n_paths']):,}")
        print(f"  Gross margin at 100% issue:    {float(base['margin_at_100_issue_pct']):.2f}%")
        print(f"  Desk margin floor:             {MARGIN_FLOOR:.2f}%")
        if float(base["margin_at_100_issue_pct"]) < MARGIN_FLOOR:
            print("  -> Proposed terms are too rich for the 1.5% margin target.")
    print()


def main() -> None:
    parser = argparse.ArgumentParser(
        description="Monte Carlo pricer for the Healthcare Phoenix Autocallable case study.",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog=(
            "Examples:\n"
            "  uv run spreadsheet/phoenix_mc_pricer.py --paths 50000\n"
            "  uv run spreadsheet/phoenix_mc_pricer.py --until-converged --sigma 0.17 --verbose\n"
            "  uv run spreadsheet/phoenix_mc_pricer.py --until-converged --se-tol 0.005\n"
        ),
    )
    mode = parser.add_mutually_exclusive_group()
    mode.add_argument(
        "--paths",
        type=int,
        metavar="N",
        help="Fixed number of Monte Carlo paths (default: 50000 if this mode is selected).",
    )
    mode.add_argument(
        "--until-converged",
        action="store_true",
        help="Run batches until std error <= --se-tol (see --batch-size, --min-paths, --max-paths).",
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
        "--batch-size",
        type=int,
        default=10_000,
        help="Paths per batch in --until-converged mode (default: 10000).",
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
        help="Print batch progress in --until-converged mode.",
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

    # Default: fixed 50k paths if neither mode flag is given
    use_convergence = args.until_converged
    n_paths = args.paths if args.paths is not None else 50_000

    sigmas = [args.sigma] if args.sigma is not None else [0.16, 0.17, 0.18]
    rate_mode = (
        f"flat r={args.flat_rate:.2%} (Exhibit D first-pass)"
        if args.flat_rate is not None
        else "DF-implied forward rates (Exhibit D table)"
    )
    run_mode = (
        f"until converged (SE <= {args.se_tol:.4f}%, "
        f"batch={args.batch_size:,}, min={args.min_paths:,}, max={args.max_paths:,})"
        if use_convergence
        else f"fixed paths ({n_paths:,})"
    )

    results: list[tuple[float, dict[str, float | bool | int]]] = []
    for s in sigmas:
        if use_convergence:
            if args.verbose:
                print(f"\nConverging sigma={s:.1%} ...")
            res = price_phoenix_until_converged(
                sigma=s,
                se_tol=args.se_tol,
                batch_size=args.batch_size,
                min_paths=args.min_paths,
                max_paths=args.max_paths,
                seed=args.seed,
                antithetic=not args.no_antithetic,
                flat_rate=args.flat_rate,
                verbose=args.verbose,
            )
        else:
            res = price_phoenix_fixed(
                sigma=s,
                n_paths=n_paths,
                seed=args.seed,
                antithetic=not args.no_antithetic,
                flat_rate=args.flat_rate,
            )
        results.append((s, res))

    print_report(results, rate_mode=rate_mode, run_mode=run_mode)


if __name__ == "__main__":
    main()
