#import "/lib.typ": *

#let initial-level = 2318.47
#let coupon-barrier = calc.round(initial-level * 0.60, digits: 2)
#let half-level = calc.round(initial-level * 0.50, digits: 2)

#exhibit-label("A")

#v(0.4em)

#block(
  fill: luma(248),
  inset: 0.8em,
  radius: 3pt,
  width: 100%,
)[
  #text(size: 9pt)[
    *Case fiction.* European Investment Bank SA, ISIN, and terms are invented for this case study.
    Structure calibrated to standard EU retail *Phoenix* autocallables (cf. industry term sheets).
    Retail distributors sometimes label similar notes *Athena*; desk terminology reserves
    *Athena* for structures where coupon and autocall share a single barrier.
  ]
]

#v(0.8em)

== Cover information

#table(
  columns: (auto, 1fr),
  inset: 7pt,
  stroke: 0.5pt + luma(200),
  [*Product name*], [Healthcare Phoenix Autocallable Notes due 1 December 2031],
  [*ISIN*], [XS2EIB0HC2026],
  [*Common code*], [EIBHC2031],
  [*Issuer*], [European Investment Bank SA (Luxembourg)],
  [*Guarantor*], [European Investment Bank SA — unsecured, unsubordinated obligations],
  [*Currency*], [EUR],
  [*Specified denomination*], [EUR 1,000 per Note],
  [*Aggregate nominal amount*], [EUR 50,000,000],
  [*Issue price*], [100.00% of Specified Denomination],
  [*Issue date / Settlement date*], [1 December 2026],
  [*Maturity date*], [1 December 2031 (unless previously redeemed)],
  [*Distribution*], [France, Italy, Luxembourg — retail and private-banking networks],
  [*Form*], [Registered notes · cleared through Euroclear / Clearstream],
)

== Summary for investors

These Notes provide *conditional quarterly income* linked to the performance of the
*Euro iSTOXX 50 Future Healthcare Tilted NR Decrement 5% Index* (EUR, price return).
If the Index closes at or above *60%* of its Initial Level on a Coupon Observation Date,
Noteholders receive a *1.50%* quarterly coupon (*6.00% per annum* equivalent).

On each *Autocall Observation Date*, if the Index closes at or above *100%* of the Initial Level,
the Notes are *automatically redeemed early* at *100%* of the Specified Denomination,
together with the coupon payable on that date (if any).

If the Notes are not autocalled, at the Maturity Date:

- if the Index is at or above *60%* of the Initial Level → *100%* redemption;
- otherwise → redemption at #text(weight: "bold")[Notional × (Final Level ÷ Initial Level)] (full downside participation below the barrier).

Coupons are *not memory-linked*: a missed coupon is not paid later.

== Underlying

#table(
  columns: (auto, 1fr),
  inset: 7pt,
  stroke: 0.5pt + luma(200),
  [*Reference Index*], [Euro iSTOXX 50 Future Healthcare Tilted NR Decrement 5% (EUR — Price Return)],
  [*Bloomberg / Reuters*], [EIIXHC5E / .EIIXHC5E],
  [*Index sponsor*], [STOXX Ltd.],
  [*Initial Fixing Date*], [27 November 2026 (Trade Date)],
  [*Initial Level ($S_0$)*], [EUR #initial-level (Index closing level on Initial Fixing Date)],
  [*Coupon Barrier*], [60.00% × $S_0$ = EUR #coupon-barrier],
  [*Autocall Barrier*], [100.00% × $S_0$ = EUR #initial-level],
  [*Final Valuation Date*], [1 December 2031],
  [*Calculation Agent*], [European Investment Bank SA],
)

The Index reflects a tilted, decrement-adjusted segment of Euro STOXX healthcare-related constituents.
The Issuer does not hold the Index components. Returns on the Notes depend on the Index level on
observation dates only (not on dividends separately distributed by index constituents beyond the Index design).

== Key dates

#table(
  columns: (auto, 1fr),
  inset: 7pt,
  stroke: 0.5pt + luma(200),
  [*Trade Date / Initial Fixing*], [27 November 2026],
  [*Issue Date*], [1 December 2026],
  [*First Coupon Observation*], [1 March 2027],
  [*First Autocall Observation*], [1 December 2027],
  [*Scheduled Maturity*], [1 December 2031],
)

*Day-count:* ACT/360 for coupon accrual display purposes; coupons paid as flat percentages of denomination.

*Business days:* If an Observation Date is not a Index Calculation Day, the immediately following
Index Calculation Day applies (*Modified Following*). Coupon and redemption payments settle
*T + 3* Business Days after the relevant Observation Date.

== Conditional coupons

Unless previously redeemed, on each *Coupon Observation Date* the Issuer shall pay, in respect of
each Note:

$ "Coupon Amount" = 1.50% times "Specified Denomination" $

if and only if:

$ "Index Level" >= "Coupon Barrier" $

Otherwise the Coupon Amount for that date is *zero*. *No memory feature* applies — unpaid coupons
are not deferred or accumulated.

*Annual equivalent coupon (if all four quarterly conditions met):* 6.00% p.a.

== Autocall (early redemption)

On each *Autocall Observation Date* listed in Section 8, if:

$ "Index Level" >= "Autocall Barrier" $

then the Notes shall be *automatically called* in whole (not in part) and the Issuer shall redeem
each Note at:

$ "Early Redemption Amount" = "Specified Denomination" + "Coupon Amount due on that Autocall Observation Date" $

Following autocall, no further amounts are payable and the Notes are cancelled.

== Redemption at maturity

If not previously redeemed, each Note shall be redeemed on the Maturity Date at an amount
determined by the Calculation Agent as follows:

#table(
  columns: (auto, 1fr),
  inset: 7pt,
  stroke: 0.5pt + luma(200),
  table.header([*Scenario*], [*Final Redemption Amount per Note*]),
  [Index Level ≥ Coupon Barrier on Final Valuation Date], [
    Pay any *Coupon Amount* due on the Final Valuation Date (1.50% if condition met), plus:
  ],
  [Index Level ≥ 60% × $S_0$ at Final Valuation], [100.00% of Specified Denomination + final coupon (if any)],
  [Index Level < 60% × $S_0$ at Final Valuation], [
    $ "Specified Denomination" times "Index Level" / S_0 $
  ],
)

*Example (Final Valuation):* if $S_0 = #initial-level " EUR" $ and the Index closes at #coupon-barrier (60.00% of Initial Level),
redemption is *EUR 1,000*. If the Index closes at #half-level (50.00% of Initial Level), redemption is *EUR 500* per Note
(before any final coupon).

== Issue price and expenses

Notes are issued at *100.00%* of Specified Denomination. The Issuer's internal pricing target assumes
a minimum *gross structuring margin* of *1.50%* of nominal to cover distribution and hedging costs.
No separate management fee is deducted from Noteholders after issuance.

== Observation schedule

#figure(
  table(
    columns: (auto, auto, auto, auto),
    inset: 5pt,
    stroke: 0.5pt + luma(200),
    table.header(
      [*Observation Date*],
      [*Coupon?*],
      [*Autocall?*],
      [*Barrier(s)*],
    ),
    [1 Mar 2027], [Yes], [—], [Coupon ≥ 60% Initial Level],
    [1 Jun 2027], [Yes], [—], [Coupon ≥ 60% Initial Level],
    [1 Sep 2027], [Yes], [—], [Coupon ≥ 60% Initial Level],
    [1 Dec 2027], [Yes], [Yes], [Coupon ≥ 60% · Autocall ≥ 100% Initial Level],
    [1 Mar 2028], [Yes], [—], [Coupon ≥ 60% Initial Level],
    [1 Jun 2028], [Yes], [—], [Coupon ≥ 60% Initial Level],
    [1 Sep 2028], [Yes], [—], [Coupon ≥ 60% Initial Level],
    [1 Dec 2028], [Yes], [Yes], [Coupon ≥ 60% · Autocall ≥ 100% Initial Level],
    [1 Mar 2029], [Yes], [—], [Coupon ≥ 60% Initial Level],
    [1 Jun 2029], [Yes], [—], [Coupon ≥ 60% Initial Level],
    [1 Sep 2029], [Yes], [—], [Coupon ≥ 60% Initial Level],
    [1 Dec 2029], [Yes], [Yes], [Coupon ≥ 60% · Autocall ≥ 100% Initial Level],
    [1 Mar 2030], [Yes], [—], [Coupon ≥ 60% Initial Level],
    [1 Jun 2030], [Yes], [—], [Coupon ≥ 60% Initial Level],
    [1 Sep 2030], [Yes], [—], [Coupon ≥ 60% Initial Level],
    [1 Dec 2030], [Yes], [Yes], [Coupon ≥ 60% · Autocall ≥ 100% Initial Level],
    [1 Mar 2031], [Yes], [—], [Coupon ≥ 60% Initial Level],
    [1 Jun 2031], [Yes], [—], [Coupon ≥ 60% Initial Level],
    [1 Sep 2031], [Yes], [—], [Coupon ≥ 60% Initial Level],
    [*1 Dec 2031*], [Yes], [—], [*Final valuation* · Maturity],
  ),
  caption: [Full observation schedule (20 coupon dates; 4 autocall dates; 1 final valuation).],
)

== Target market (MiFID II / PRIIPs summary)

#table(
  columns: (auto, 1fr),
  inset: 7pt,
  stroke: 0.5pt + luma(200),
  [*Investor type*], [Retail and advised private-banking clients],
  [*Investment horizon*], [Buy-and-hold compatible with 5-year term; early exit via autocall or illiquid secondary market],
  [*Knowledge & experience*], [Basic understanding of equity indices and barrier products required],
  [*Loss-bearing capacity*], [Must tolerate loss of capital below 60% Index barrier and issuer credit risk],
  [*Distribution channels*], [France, Italy, Luxembourg — bank branches and private bankers],
  [*KID*], [See Exhibit C — document to be provided to investors prior to subscription],
)

== Principal risk factors (abridged)

- *Issuer credit risk* — Notes are unsecured obligations of European Investment Bank SA. Holders bear full issuer default risk.
- *Market risk* — Below the 60% barrier at maturity, capital is reduced in proportion to the Index fall.
- *Autocall risk* — Early redemption may reinvestment proceeds in lower-yielding environments.
- *Liquidity risk* — No assured secondary market; bid/offer spreads may be wide.
- *Gap / discontinuity risk* — Index moves between observation dates are not observed for barriers.
- *Complexity* — Payoff depends on multiple dates and barriers; PRIIPs scenarios may differ from internal fair value.

#v(0.8em)
#text(size: 9pt, fill: luma(100))[
  _Market data for pricing: Exhibit D (Initial Fixing 27 November 2026)._
]
