#import "/lib.typ": *

#exhibit-label("E")

#v(0.4em)

#block(
  fill: luma(248),
  inset: 0.8em,
  radius: 3pt,
  width: 100%,
)[
  #text(size: 9pt)[
    *Desk compilation.* Summary of *public* retail terms observed in the Italian market.
    Issuer names are anonymised where required; underlying index and headline economics are
    taken from published retail sheets / KID extracts. Students *use* this exhibit for
    commercial comparison — they are not asked to reproduce the research from scratch.
  ]
]

#v(0.8em)

Banque Meridian · Structured Products (Retail) · *BM-SP/2026/HC-COMP-01* · 30 November 2026

== Purpose

Banca Lombarda requested a side-by-side view of Meridian's proposed healthcare Phoenix
(Exhibit A) against a competing Italian retail issue already in their Q4 pipeline. This
note is for *distribution positioning* only; competitor fair value is *not* provided.

== Headline comparison

#figure(
  table(
    columns: (1.1fr, 1fr, 1fr),
    inset: 6pt,
    stroke: 0.5pt + luma(200),
    table.header(
      [*Feature*],
      [*Meridian (proposed)*],
      [*Competitor A*],
    ),
    [Product type], [Phoenix autocallable], [Athena autocallable (retail label)],
    [Issuer (public)], [European Investment Bank SA], [Major Italian retail bank (programme issuer)],
    [Underlying], [Euro iSTOXX 50 Future Healthcare Tilted NR Decrement 5%], [Same index (ISX5HCTD)],
    [Issue / maturity], [#sym.bracket.l 15 Dec 2026 #sym.bracket.r / 1 Dec 2031 (5Y)], [15 Sep 2026 / 15 Sep 2030 (4Y)],
    [Issue price], [100%], [100%],
    [Conditional coupon], [6.00% p.a. (1.50% quarterly)], [6.25% p.a. (1.5625% quarterly)],
    [Coupon condition], [Index >= 60% of initial], [Index >= 62% of initial],
    [Autocall], [Annual if index >= 100% initial], [Annual if index >= 100% initial],
    [Capital at maturity], [100% if index >= 60%; else par × final/initial], [Same soft 60% style barrier],
    [Primary distribution], [France (lead), Italy, Luxembourg], [Italy (nationwide retail network)],
    [Adviser headline], ["6% healthcare income"], ["6.25% healthcare income · lower barrier"],
  ),
  caption: [Public-term comparison as seen by Italian distributors (rounded for desk use).],
)

== What distributors are saying

#table(
  columns: (auto, 1fr),
  inset: 7pt,
  stroke: 0.5pt + luma(200),
  [*Channel*], [*Reported objection / ask*],
  [Banca Lombarda (Italy)], [
    "Intesa-style flow already quoted at *6.25%* with a *62%* coupon trigger on the same
    index. Why should we push Meridian at *6.00%* unless you improve the coupon or barrier?"
  ],
  [Réseau Patrimoine (France)], [
    Less focused on Italian competitor; wants printable healthcare theme for December events
    and a credible KID. Asks whether *6%* can be maintained in final terms.
  ],
)

== Desk read (not for external distribution)

+ *Italy is a headline fight.* Competitor A wins the simple comparison on coupon (6.25% vs 6.00%)
  and slightly easier coupon condition (62% vs 60% is client-friendly at the margin).
+ *France is a story fight.* Press dossier (Exhibits B1–B2) matters more than competitor terms.
+ *Matching competitor economics is not free.* Raising coupon or lowering barriers would likely
  *widen* the gap versus Meridian's 1.5% gross margin floor — internal pricing must lead,
  competitor scan second.
+ *Maturity differs (4Y vs 5Y).* Direct comparison is imperfect; advisers may still treat
  headline coupon as like-for-like.

== Sources (public)

#enum(
  [Major Italian retail bank — retail factsheet, *Healthcare Athena Autocall* programme,
  September 2026 issuance (abridged terms supplied to distributors).],
  [STOXX Ltd. — ISX5HCTD index definition (underlying confirmation).],
  [Internal distributor call notes — Banca Lombarda, 25–29 November 2026 (paraphrased).],
)

#v(0.6em)
#text(size: 9pt, fill: luma(100))[
  _Meridian proposed terms: Exhibit A. Internal pricing inputs: Exhibit D._
]
