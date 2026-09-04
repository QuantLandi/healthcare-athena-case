#import "/lib.typ": *

#exhibit-label("C")

#v(0.4em)

#block(
  fill: luma(248),
  inset: 0.8em,
  radius: 3pt,
  width: 100%,
)[
  #text(size: 9pt)[
    *Case fiction.* This is an *abridged, invented* PRIIPs KID excerpt for teaching purposes.
    Scenario figures are calibrated to the proposed terms in Exhibit A and are *not* tied to
    the structurer's internal Monte Carlo fair value (Exhibit D). Layout follows common EU
    retail KID conventions; it is not a regulatory filing.
  ]
]

#v(0.8em)

#table(
  columns: (auto, 1fr),
  inset: 7pt,
  stroke: 0.5pt + luma(200),
  [*Product*], [Healthcare Phoenix Autocallable Notes due 1 December 2031],
  [*Manufacturer / Issuer*], [Banque Meridian (Luxembourg)],
  [*Producer*], [Banque Meridian — Structured Products (Retail)],
  [*ISIN*], [XS2BM0HC2026],
  [*Currency*], [EUR],
  [*Issue price*], [100% per Note (€1,000 minimum denomination)],
  [*Recommended holding period (RHP)*], [5 years (to 1 December 2031, unless autocalled earlier)],
)

== Summary risk indicator

#align(center)[
  #box(
    fill: rgb("#f4b942"),
    inset: (x: 1.2em, y: 0.6em),
    radius: 4pt,
  )[
    #text(size: 22pt, weight: "bold")[5 / 7]
  ]
  #v(0.3em)
  #text(size: 9.5pt)[Medium-high risk · Lower risk classes exist]
]

Capital is *at risk*. You may lose part or all of your investment if the Index falls below
the capital barrier at the final observation date, or if the Issuer defaults. Conditional
coupons are *not guaranteed*.

== What is this product?

You invest in a *structured note* linked to the Euro iSTOXX 50 Future Healthcare Tilted NR
Decrement 5% Index. You may receive *quarterly conditional coupons* (up to 6.00% p.a.
equivalent) and the Notes may be *redeemed early* if autocall conditions are met. You are
exposed to the Index level on observation dates and to *issuer credit risk*.

This KID describes outcomes under PRIIPs *prescribed scenarios*, not the bank's internal
pricing model.

== What could you get back?

Illustration for a *€10,000* investment held for the *recommended holding period* (5 years).
Figures include the impact of costs shown below. *Past performance and scenarios are not
reliable indicators of future results.*

#figure(
  table(
    columns: (auto, auto, auto),
    inset: 6pt,
    stroke: 0.5pt + luma(200),
    table.header(
      [*Scenario*],
      [*You could get back*],
      [*Average return each year*],
    ),
    [Stress], [€ 7,450], [-5.6% / year],
    [Unfavourable], [€ 8,650], [-2.9% / year],
    [Moderate], [€ 10,720], [+1.4% / year],
    [Favourable], [€ 12,650], [+4.8% / year],
  ),
  caption: [Performance scenarios at the 5-year recommended holding period (after costs).],
)

*Stress* and *unfavourable* scenarios reflect weak Index paths where coupons are partly or
fully missed and capital is reduced below the 60% barrier at final valuation. The *moderate*
scenario assumes a middling Index path with partial coupon receipt and no autocall. The
*favourable* scenario assumes several coupons paid and redemption at par (or early autocall
with coupons — methodology maps this to the RHP illustration).

If you exit before the recommended holding period, secondary-market prices may be
substantially below these illustrations. You may not be able to sell when you want to.

=== One-year holding period (if you exit early)

#table(
  columns: (auto, auto, auto),
  inset: 6pt,
  stroke: 0.5pt + luma(200),
  table.header(
    [*Scenario*],
    [*After 1 year*],
    [*Return*],
  ),
  [Unfavourable], [€ 9,180], [-8.2%],
  [Moderate], [€ 10,120], [+1.2%],
  [Favourable], [€ 10,580], [+5.8%],
)

Early exit returns are indicative only; bid/offer spreads on retail structured notes are
often wide.

== What are the costs?

#table(
  columns: (auto, auto),
  inset: 7pt,
  stroke: 0.5pt + luma(200),
  table.header([*Costs over 5 years*], [*Amount*]),
  [Entry costs], [0.00% — included in issue price],
  [Exit costs (secondary market)], [Not applicable / unknown if illiquid],
  [Ongoing costs], [0.00% — no separate management fee],
  [Incidental costs], [0.00%],
  [*Reduction in Yield (RIY)*], [*1.85% each year*],
)

*RIY* aggregates structuring, distribution, and hedging costs embedded in the product
economics. It reduces the return you could have received if costs were zero.

The RIY is *not* the same as the bank's internal *gross structuring margin* on issuance,
but both reflect issuer economics taken at subscription.

== Main risks (abridged)

- *Market risk* — Index may fall; below 60% of initial level at final valuation, capital
  is reduced in proportion to the Index decline.
- *Coupon risk* — Coupons depend on Index level on each quarterly date; missed coupons
  are not paid later (*no memory*).
- *Autocall risk* — Early redemption may occur in rising markets; reinvestment may be
  at lower yields.
- *Issuer risk* — If Banque Meridian fails, you may receive nothing.
- *Liquidity risk* — No assured secondary market.

== Desk note (not part of official KID)

#block(
  fill: luma(245),
  inset: 0.8em,
  radius: 3pt,
  width: 100%,
)[
  #text(size: 9pt)[
    Compliance flagged that the *moderate* scenario (+1.4% p.a. at RHP) is difficult to
    reconcile with distributor copy citing *"6% healthcare income"* unless advisers explain
    conditionality, barriers, and issuer credit explicitly. This draft is pending sign-off
    pending the structurer's fair-value run.
  ]
]

#v(0.6em)
#text(size: 9pt, fill: luma(100))[
  _Full terms: Exhibit A. Market inputs for internal pricing: Exhibit D._
]
