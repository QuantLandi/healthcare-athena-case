#import "/lib.typ": *

#let initial-level = 2318.47
#let coupon-barrier = calc.round(initial-level * 0.60, digits: 2)

#exhibit-label("D")

#v(0.4em)

#block(
  fill: luma(248),
  inset: 0.8em,
  radius: 3pt,
  width: 100%,
)[
  #text(size: 9pt)[
    *Case fiction.* Spot, OIS curve, OIS discount factors, and desk-mid volatility below
    are *locked* for this case (27 November 2026 snapshot). *Credit spread* is a choice
    from the ALM grid — choose and justify. Vol ±1 pt is *repricing-risk* sensitivity only.
    Terms in Exhibit A are the *proposed* issue to be priced at this snapshot.
  ]
]

#v(0.8em)

== Base-case inputs

#table(
  columns: (auto, 1fr),
  inset: 7pt,
  stroke: 0.5pt + luma(200),
  [*Initial Level $S_0$*], [EUR #initial-level (closing level, 27 November 2026) — *locked*],
  [*Coupon / capital barrier*], [60% × $S_0$ = EUR #coupon-barrier — *proposed* (Exhibit A)],
  [*Autocall barrier*], [100% × $S_0$ = EUR #initial-level — *proposed* (Exhibit A)],
  [*Implied volatility $sigma$*], [Desk mid *17.00%* flat Black / GBM — *locked* for base case; ±1 vol-point sensitivity as issue-repricing risk],
  [*Dividend / decrement $q$*], [5.00% p.a. continuous — *locked*; do *not* add a further dividend yield],
  [*Discounting (hedge / index)*], [EUR OIS zeros in the observation-date table — *locked*],
  [*Credit spread (note CFs)*], [*Student choice* from the ALM grid below; apply only to coupons and redemption],
  [*Process*], [GBM under the risk-neutral measure; ~50,000 paths],
)

Risk-neutral SDE for the *published decrement index*:

$ d S_t = (r_t - q) S_t d t + sigma S_t d W_t^Q, quad q = 5%, quad sigma = 17% "(base)". $

Build index paths with the OIS forwards implied by the table below. Discount *note*
coupons and redemption with $ "DF"_"note" (T) = "DF"_"OIS" (T) e^(-s T) $, where $s$ is
your chosen credit spread from the ALM grid (not OIS-only).

== Underlying identifiers

#table(
  columns: (auto, 1fr),
  inset: 7pt,
  stroke: 0.5pt + luma(200),
  [*Index*], [EURO iSTOXX 50 Future Healthcare Tilted NR Decrement 5%],
  [*STOXX symbol / Bloomberg*], [ISX5HCTD / ISX5HCTD Index],
  [*ISIN*], [CH1123123734],
  [*Currency / type*], [EUR · Price return (decrement already applied)],
  [*Index sponsor*], [STOXX Ltd.],
  [*Desk Bloomberg (Exhibit A)*], [EIIXHC5E / .EIIXHC5E],
)

The Index replicates the *net-return* parent with a *constant 5% performance deduction* accruing daily.
That drag is already in the published level $S_t$. Modelling $q = 5%$ and simulating $S$ is the correct
treatment; modelling $q = 0$ would omit the decrement and overstate fair value.

== Spot and context

#table(
  columns: (auto, 1fr),
  inset: 7pt,
  stroke: 0.5pt + luma(200),
  [*Trade-date close $S_0$*], [2,318.47],
  [*Calibration reference*], [Published index ≈ 2,341 in mid-August 2026; 52-week high 2,351.63 (13 Aug 2026)],
  [*Case path to trade date*], [Modest pullback from August highs into the 27 November fixing],
  [*52-week range (context)*], [1,947.04 (2 Sep 2025) — 2,351.63 (13 Aug 2026)],
)

== EUR rates

Par EURIBOR swap rates (annual, 30/360 teaching convention) as of the trade-date close,
calibrated to mid-August 2026 market levels (~2.91% 1Y / ~3.07% 5Y). Overnight: €STR 2.189%.

#table(
  columns: (auto, auto, auto, auto),
  inset: 7pt,
  stroke: 0.5pt + luma(200),
  table.header([*Tenor*], [*Par swap*], [*Discount factor*], [*Zero (cont.)*]),
  [€STR (overnight)], [2.189%], [1.00000], [2.19%],
  [1Y], [2.91%], [0.97172], [2.87%],
  [2Y], [3.00%], [0.94257], [2.96%],
  [3Y], [3.03%], [0.91429], [2.99%],
  [4Y], [3.05%], [0.88668], [3.01%],
  [5Y], [3.07%], [0.85955], [3.03%],
)

Zeros are bootstrapped from the par swaps (annual fixed vs annual, teaching bootstrap — not an official ICE close).
Linear interpolation of the continuously compounded zero is used between pillars.

== ALM credit grid (note cash-flows)

Treasury (*Banque Meridian* ALM) publishes the following *credit spreads vs OIS* for unsecured
retail-note funding. Pick *one* tenor from *expected life* of the note (see §5). Apply that spread
as a *flat* continuous bump $s$ to every note cash-flow; do *not* interpolate a new
curve and do *not* apply $s$ to index drift.

#table(
  columns: (auto, auto, 1fr),
  inset: 7pt,
  stroke: 0.5pt + luma(200),
  table.header([*Expected life*], [*Spread $s$ vs OIS*], [*Typical argument*]),
  [1Y], [+10 bp], [First autocall is likely; note exits at 15 Dec 2027],
  [2Y], [+15 bp], [Expected exit around year 2, *or* clients rolled into a new theme],
  [3Y], [+20 bp], [Note more likely to survive early calls],
  [5Y], [+30 bp], [Conservative: fund as if held to scheduled maturity],
)

$ "DF"_"note" (T) = "DF"_"OIS" (T) e^(-s T) $

*Check:* at the first autocall date, $T = 1.0486$, $ "DF"_"OIS" = 0.97035$. With the 1Y
spread $s = 10$ bp, $ "DF"_"note" = 0.97035 times e^(-0.0010 times 1.0486) approx 0.96933$.

== Discount factors on observation dates

Time is measured from *27 November 2026* on an ACT/365.25 basis. *DF (OIS)* is locked and
is used for index drift / hedge. Convert to note discount factors with the formula above.

#figure(
  table(
    columns: (auto, auto, auto, auto, auto),
    inset: 5pt,
    stroke: 0.5pt + luma(200),
    table.header(
      [*Observation*],
      [*Type*],
      [$T$ *(y)*],
      [$r$ *(cc)*],
      [*DF (OIS)*],
    ),
    [15 Mar 2027], [Coupon], [0.2957], [2.36%], [0.99305],
    [15 Jun 2027], [Coupon], [0.5476], [2.54%], [0.98619],
    [15 Sep 2027], [Coupon], [0.7995], [2.71%], [0.97857],
    [15 Dec 2027], [Coupon + autocall], [1.0486], [2.87%], [0.97035],
    [15 Mar 2028], [Coupon], [1.2977], [2.89%], [0.96319],
    [15 Jun 2028], [Coupon], [1.5496], [2.91%], [0.95591],
    [15 Sep 2028], [Coupon], [1.8015], [2.94%], [0.94841],
    [15 Dec 2028], [Coupon + autocall], [2.0507], [2.96%], [0.94111],
    [15 Mar 2029], [Coupon], [2.2971], [2.97%], [0.93405],
    [15 Jun 2029], [Coupon], [2.5489], [2.97%], [0.92709],
    [15 Sep 2029], [Coupon], [2.8008], [2.98%], [0.91992],
    [15 Dec 2029], [Coupon + autocall], [3.0500], [2.99%], [0.91284],
    [15 Mar 2030], [Coupon], [3.2964], [2.99%], [0.90614],
    [15 Jun 2030], [Coupon], [3.5483], [3.00%], [0.89902],
    [15 Sep 2030], [Coupon], [3.8001], [3.00%], [0.89225],
    [15 Dec 2030], [Coupon + autocall], [4.0493], [3.01%], [0.88525],
    [15 Mar 2031], [Coupon], [4.2957], [3.01%], [0.87871],
    [15 Jun 2031], [Coupon], [4.5476], [3.02%], [0.87168],
    [15 Sep 2031], [Coupon], [4.7995], [3.02%], [0.86507],
    [*15 Dec 2031*], [*Final / maturity*], [*5.0486*], [*3.03%*], [*0.85815*],
  ),
  caption: [Locked OIS discount factors for every coupon, autocall, and final-valuation date in Exhibit A.],
)

A constant 3.03% continuous rate (the 5Y zero) is acceptable for a *first pass* on
index drift; still apply the chosen credit spread to note cash-flows. The table above is
the reference for a reproducible Monte Carlo.

== Volatility

No listed options exist on ISX5HCTD. Trading and the desk agree a *working mid* of *17%*
flat Black vol for this snapshot, consistent with:

- ~17% one-year realised vol on European healthcare indices in 2026;
- VSTOXX (EURO STOXX 50, 30-day implied) in the mid-teens in August 2026;
- the 5Y ATM column in the smile table below.

#table(
  columns: (auto, auto, auto, auto),
  inset: 7pt,
  stroke: 0.5pt + luma(200),
  table.header([*Expiry*], [*ATM*], [*80% strike*], [*60% strike*]),
  [3M], [15.5%], [18.0%], [22.0%],
  [1Y], [16.5%], [18.5%], [21.5%],
  [2Y], [16.8%], [18.5%], [21.0%],
  [3Y], [17.0%], [18.5%], [20.5%],
  [5Y], [17.0%], [18.5%], [20.5%],
)

*Task:* price the base case at *17%* ATM (5Y column as anchor). Then re-price at *16%* and
*18%* (±1 vol point) to show *issue-repricing risk* — how much margin would move if vol
has shifted by the time the note prints. Do *not* adopt 16% or 18% as the committee base
case to clear the floor; revise a product lever instead. The smile is *optional* extra
credit; do not mix ATM and 60% vols in the same base-case path set.

== Other desk assumptions

#table(
  columns: (auto, 1fr),
  inset: 7pt,
  stroke: 0.5pt + luma(200),
  [*Repo / borrow*], [0 bp (cash equity index; no stock-loan)],
  [*Correlation*], [Not required (single underlying)],
  [*Credit spread*], [Student choice from ALM grid (+10 / +15 / +20 / +30 bp vs OIS)],
  [*Credit of issuer*], [Banque Meridian — unsecured notes; no CSA. Hedge / index on OIS; note CFs on chosen Meridian ALM spread],
  [*Business days*], [As Exhibit A (Modified Following, Index Calculation Days)],
)

== What *not* to pull from a live feed

Do not replace $S_0$, the discount-factor table, or the decision date with a later market print.
The assignment is internally consistent only at this snapshot.

#v(0.8em)
#text(size: 9pt, fill: luma(100))[
  _Sources for calibration (not live inputs): STOXX ISX5HCTD factsheet; EURIBOR swap indications
  around 17 August 2026; VSTOXX and sector realised-vol context, August 2026._
]
