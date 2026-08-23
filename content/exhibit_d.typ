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
    *Case fiction.* Spot, curve, and discount factors below are *locked* for the assignment
    (27 November 2026 snapshot). Volatility is a *desk range* — students choose and justify
    a flat $sigma$ within it. Terms in Exhibit A are the *proposed* issue; fair value
    at 100% is expected to fall short of the 1.5% margin target.
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
  [*Implied volatility $sigma$*], [*Student choice:* flat *16.00–18.00%* (Black / GBM); justify from context below],
  [*Dividend / decrement $q$*], [5.00% p.a. continuous — *locked*; do *not* add a further dividend yield],
  [*Discounting*], [EUR OIS zeros in the observation-date table — *locked*],
  [*Funding (optional)*], [+25 bp to OIS zero — extra credit only; DF funded column],
  [*Process*], [GBM under the risk-neutral measure; ~50,000 paths],
)

Risk-neutral SDE for the *published decrement index*:

$ d S_t = (r_t - q) S_t d t + sigma S_t d W_t^Q, quad q = 5%, quad sigma in [16%, 18%]. $

Discount expected payoffs with the OIS discount factors below.

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

== Discount factors on observation dates

Time is measured from *27 November 2026* on an ACT/365.25 basis. *DF (OIS)* is the locked discount factor
for expected Index-linked payoffs. *DF (funded)* applies the +25 bp overlay.

#figure(
  table(
    columns: (auto, auto, auto, auto, auto, auto),
    inset: 5pt,
    stroke: 0.5pt + luma(200),
    table.header(
      [*Observation*],
      [*Type*],
      [$T$ *(y)*],
      [$r$ *(cc)*],
      [*DF (OIS)*],
      [*DF (funded)*],
    ),
    [1 Mar 2027], [Coupon], [0.2574], [2.36%], [0.99393], [0.99330],
    [1 Jun 2027], [Coupon], [0.5092], [2.54%], [0.98717], [0.98592],
    [1 Sep 2027], [Coupon], [0.7611], [2.71%], [0.97961], [0.97775],
    [1 Dec 2027], [Coupon + autocall], [1.0103], [2.87%], [0.97143], [0.96898],
    [1 Mar 2028], [Coupon], [1.2594], [2.89%], [0.96424], [0.96121],
    [1 Jun 2028], [Coupon], [1.5113], [2.91%], [0.95692], [0.95331],
    [1 Sep 2028], [Coupon], [1.7632], [2.94%], [0.94955], [0.94537],
    [1 Dec 2028], [Coupon + autocall], [2.0123], [2.96%], [0.94222], [0.93749],
    [1 Mar 2029], [Coupon], [2.2587], [2.97%], [0.93523], [0.92996],
    [1 Jun 2029], [Coupon], [2.5106], [2.97%], [0.92809], [0.92229],
    [1 Sep 2029], [Coupon], [2.7625], [2.98%], [0.92098], [0.91464],
    [1 Dec 2029], [Coupon + autocall], [3.0116], [2.99%], [0.91397], [0.90711],
    [1 Mar 2030], [Coupon], [3.2580], [2.99%], [0.90712], [0.89976],
    [1 Jun 2030], [Coupon], [3.5099], [3.00%], [0.90015], [0.89229],
    [1 Sep 2030], [Coupon], [3.7618], [3.00%], [0.89322], [0.88486],
    [1 Dec 2030], [Coupon + autocall], [4.0110], [3.01%], [0.88638], [0.87754],
    [1 Mar 2031], [Coupon], [4.2574], [3.01%], [0.87965], [0.87034],
    [1 Jun 2031], [Coupon], [4.5092], [3.02%], [0.87281], [0.86302],
    [1 Sep 2031], [Coupon], [4.7611], [3.02%], [0.86599], [0.85574],
    [*1 Dec 2031*], [*Final / maturity*], [*5.0103*], [*3.03%*], [*0.85929*], [*0.84859*],
  ),
  caption: [Locked discount factors for every coupon, autocall, and final-valuation date in Exhibit A.],
)

A constant 3.03% continuous rate (the 5Y zero) is acceptable for a *first pass*; the table above is the
reference for a reproducible Monte Carlo.

== Volatility

No listed options exist on ISX5HCTD. The desk works in a *16–18%* flat Black vol band, consistent with:

- ~17% one-year realised vol on European healthcare indices in 2026;
- VSTOXX (EURO STOXX 50, 30-day implied) in the mid-teens in August 2026.

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

*Student task:* pick one flat ATM vol (5Y column as anchor), state your source, and run ±2 vol-point sensitivities.
The smile is *optional* extra credit; do not mix ATM and 60% vols in the same base-case path set.
*Instructor reference:* $sigma = 17.00%$ → proposed 6% coupon terms are *too rich* for a 1.5% margin at 100% issue.

== Other desk assumptions

#table(
  columns: (auto, 1fr),
  inset: 7pt,
  stroke: 0.5pt + luma(200),
  [*Repo / borrow*], [0 bp (cash equity index; no stock-loan)],
  [*Correlation*], [Not required (single underlying)],
  [*Issuer funding*], [+25 bp vs OIS (optional overlay; DF funded column)],
  [*Credit of hypothetical issuer*], [Unsecured notes; no CSA. Hedge is assumed OIS-discounted],
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
