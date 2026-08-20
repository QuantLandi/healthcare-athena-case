#import "/lib.typ": *

#show: doc.with(
  title: [Pricing a Healthcare Athena],
  subtitle: [Fair Value, PRIIPs, and the Launch Decision],
  date: [Banque Meridian · 1 December 2026],
)

#block(
  fill: luma(248),
  inset: 0.8em,
  radius: 3pt,
  width: 100%,
)[
  #text(size: 9pt)[
    *Teaching case.* Banque Meridian, its personnel, and the proposed note terms are fictional.
    The product type and market setting are drawn from standard EU retail structured-product practice.
  ]
]

#v(1em)

= 1. Setting

You are a *junior structurer* on the Retail Structured Products desk at *Banque Meridian*, a
pan-European bank with a growing franchise in thematic notes for advised retail and
private-banking clients. You joined the desk two years ago after a quantitative finance
master's degree and a six-month rotation on the rates exotics floor. Until now you have
supported senior colleagues on autocallables and reverse convertibles — building payoff
grids, checking KID numbers, and sitting in on distributor calls — but you have never
*owned* a retail launch from term-sheet draft through pricing-committee sign-off. That
changes today.

The desk sits in *Paris*, a short walk from the wealth-management floors that feed
French and cross-border distribution. Final *pricing committee* approval for retail
issuance, however, is convened in *Luxembourg*, where the bank's structured-products
platform books most EU retail notes. On issue days you work both locations remotely until
the committee meets: Paris for distributor dialogue, Luxembourg for governance and sign-off.

Banque Meridian distributes through branch networks and external platforms in *France*,
*Italy*, and *Luxembourg*. Retail structured products remain a meaningful fee pool for the
bank, but the regulatory environment has tightened. *MiFID II* product-governance rules
require a documented target market, and every retail note must ship with a *PRIIPs Key
Information Document* (KID) whose prescribed scenarios can read very differently from the
headline coupon on a term sheet. Compliance sits one floor above you; they are helpful,
but they will not sign a KID that your fair-value work cannot support.

== The desk and the pipeline

Your team of eight structurers covers equity-linked and credit-linked retail notes,
typically *Athena* autocallables and soft-barrier income products on single indices or
thematic baskets. Distributors want *simple stories*: a sector recovery, a familiar index,
a conditional coupon that sounds generous next to deposit rates. They want *fast*
turnaround when a theme is in the press. The head of Structured Products (Retail) sets a
*minimum gross structuring margin* of *1.5%* of nominal on new issues — enough to cover
distribution rebates, hedging slippage, and the occasional gap between internal model and
street quote. Issues are almost always quoted to clients at *100%* of the €1,000 minimum
denomination; economics live in the spread between fair value and that issue price.

Since late summer, *healthcare* has moved to the front of the thematic pipeline. Two
August articles — an English-language adviser piece and a French retail-investor study —
argued that pharmaceutical and healthcare equities had lagged fundamentals and were
beginning to re-rate (see Exhibits B1 and B2). French private bankers forwarded the
Les Echos excerpt to your desk within days. Italian distributors were less focused on
French press coverage and more anxious about *competition*: rival banks were already
marketing healthcare-linked certificates into their networks.
Your head of desk treated the theme as a year-end priority — a product that could close
before calendars shut and keep Meridian visible with key distributors.

== Your role today

Over the past week you have assembled the working pack for a five-year *healthcare Athena*
on the *Euro iSTOXX 50 Future Healthcare Tilted NR Decrement 5%* index: proposed terms
(Exhibit A), market data as of the *27 November* trade date (Exhibit D), draft KID
excerpts, and a competitor scan still being finalised (Exhibit E). The trade was fixed
on Wednesday; issue and settlement are *today*, 1 December 2026. The Luxembourg pricing
committee meets at 10:00.

You are expected to confirm that the proposed *6%* conditional coupon and *60%* barrier
structure can be issued at *100%* with at least the desk's *1.5%* margin — or to explain
why the terms must change before Banque Meridian commits its balance sheet and reputation
to the distributors waiting in Paris and Milan. The formal request arrived on *Friday
28 November*, the evening after initial fixing.

= 2. The ask

On Friday evening, your head of desk sent the email below and attached an internal launch
memo. You spent the weekend finalising fair-value work and chasing the competitor scan.
The email is reproduced as received; the memo follows.

#v(0.6em)

#block(
  fill: luma(252),
  inset: 1em,
  radius: 3pt,
  width: 100%,
  stroke: 0.5pt + luma(210),
)[
  #text(size: 9pt)[
    *From:* Marie-Cécile Fontaine, Head of Structured Products (Retail) \
    *To:* Retail Structuring — Junior Desk \
    *Date:* Friday, 28 November 2026, 18:42 \
    *Subject:* RE: Healthcare Athena — *need pricing pack for Monday committee*
  ]

  #v(0.6em)

  Team,

  Initial fixing went through at 2318.47 on the iSTOXX healthcare decrement index — Dana
  posted the market-data pack. Good.

  *France:* Réseau Patrimoine (our main private-banking feed) wants a healthcare income
  note *before year-end*. They are still forwarding the Les Echos piece from August and
  asking for a 6%-style coupon story for advised clients. We promised a draft term sheet
  this week.

  *Italy:* Banca Lombarda's structured-products desk is less interested in the sector
  pitch and more interested in *why Intesa already has something out*. I need the
  *competitor one-pager* on my desk Monday AM — even a single slide. If we cannot match
  or beat the headline, they will route flow elsewhere in Q1.

  Attached is the launch memo for the Luxembourg pricing committee on *Monday 1 December,
  10:00*. You own the pack — this is your first full retail sign-off, so I will review
  your numbers Sunday night, but *you* present fair value and the launch recommendation.

  Target remains *100% issue* and *≥ 1.5%* gross margin. If you cannot get there, come
  with revised terms — do not ask the committee to approve a loss leader.

  — MCF
]

#v(0.8em)

#align(center)[
  #text(size: 10pt, weight: "bold")[Internal launch memo]
  #v(0.2em)
  #text(size: 9pt, fill: luma(100))[Banque Meridian · Structured Products (Retail) · CONFIDENTIAL]
]

#v(0.5em)

#table(
  columns: (auto, 1fr),
  inset: 7pt,
  stroke: 0.5pt + luma(200),
  [*Reference*], [BM-SP/2026/HC-ATH-047],
  [*Date*], [28 November 2026],
  [*Issue date*], [1 December 2026 (trade fixed 27 November 2026)],
  [*Owner*], [Junior structurer, Retail SP desk (Paris)],
  [*Committee*], [Luxembourg pricing committee — 1 Dec 2026, 10:00 CET],
)

== Background

Banque Meridian has marketed thematic equity-linked notes to retail and private-banking
networks in France, Italy, and Luxembourg throughout 2026. Healthcare equities recovered
materially in the second half of the year following policy clarity in the US and renewed
M&A activity in European pharmaceuticals. Press coverage in August — the *FT Adviser*
recovery piece and the *Les Echos Investir* sector study, bundled as the desk's press
dossier — revived distributor demand for a *healthcare income* product linked to a
recognised EU index.

French distributors require a printable product profile before their December client
events. Italian distributors have indicated that a competitor certificate on the same
broad index family is already in their pipeline (the competitor scan is still in draft).

== Proposed transaction

#table(
  columns: (auto, 1fr),
  inset: 7pt,
  stroke: 0.5pt + luma(200),
  [*Product*], [Healthcare Athena Autocallable Notes due 1 December 2031],
  [*Underlying*], [Euro iSTOXX 50 Future Healthcare Tilted NR Decrement 5% (EUR)],
  [*Structure*], [6% p.a. conditional coupon · 60% coupon/capital barrier · annual autocall at 100%],
  [*Issue price*], [100% of €1,000 denomination],
  [*Target notional*], [EUR 50 million],
  [*Distribution*], [France (lead), Italy, Luxembourg],
  [*Terms*], [Attached summary term sheet — HC-ATH-047-TS],
)

Issuer: *European Investment Bank SA* (Luxembourg) — existing programme issuer for Meridian
retail notes. KID draft attached (pending your fair-value run).

== Commercial objectives

+ Secure *Réseau Patrimoine* pipeline for Q4 and early Q1 thematic slots.
+ Retain *Banca Lombarda* as a healthcare flow partner against Intesa-led competition.
+ Maintain Meridian's visible presence in EU retail structured products before the holiday
  slowdown.

Sales has pre-marketed a *"6% healthcare income"* headline to both networks. Any revision
must be explainable to advisers without undermining credibility.

== Pricing and governance requirements

The pricing committee will not approve issuance unless the desk confirms:

#enum(
  [Monte Carlo (or equivalent) *fair value* at the *27 November market snapshot* (attached market-data pack), with documented volatility assumptions.],
  [*Gross structuring margin* ≥ *1.5%* of nominal at the proposed *100%* issue price, *or* a revised term sheet that meets the margin floor.],
  [Consistency between internal fair value, proposed marketing language, and the *PRIIPs KID moderate scenario*.],
  [Target-market and suitability assessment under MiFID II product-governance rules.],
)

If proposed terms are uneconomic, the owner must present *revised* coupon, barrier,
autocall, or issue-price parameters and a clear *launch / revise / reject* recommendation.

== Materials for committee

#table(
  columns: (auto, 1fr, auto),
  inset: 6pt,
  stroke: 0.5pt + luma(200),
  table.header([*Document*], [*Description*], [*Status*]),
  [Term sheet], [Healthcare Athena — final terms (HC-ATH-047-TS)], [Final draft],
  [Press dossier], [FT Adviser + Les Echos excerpts (August)], [Final],
  [KID draft], [PRIIPs key information document], [Draft — pending your FV],
  [Market-data pack], [Index level, curve, vol inputs — 27 Nov fixing], [Final],
  [Competitor scan], [Intesa / Italian market comparison], [Due Monday AM],
  [Pricing workbook], [Monte Carlo fair value and sensitivities], [Owner to complete],
)

== Sign-off requested

#table(
  columns: (auto, 1fr, auto),
  inset: 6pt,
  stroke: 0.5pt + luma(200),
  table.header([*Role*], [*Name*], [*Action*]),
  [Head of SP (Retail)], [M.-C. Fontaine], [Review Sunday PM],
  [Junior structurer (owner)], [You], [Present FV + recommendation, 1 Dec],
  [Compliance], [PRIIPs / target market], [KID sign-off if launch],
  [Pricing committee], [Luxembourg], [Approve / reject / revise terms],
)

#v(0.8em)
#text(size: 9pt, fill: luma(100))[
  _End of memo. The documents listed above are reproduced in this case as Exhibits A–E.
  Market context and product mechanics follow in Sections 3–4._
]

= 3. Market context

The healthcare theme entering your committee pack is not a blank-sheet trade idea. It is
already circulating in distributor conversations, shaped by two August 2026 press
articles that advisers now treat as shorthand for the sector story (Exhibits B1 and B2).
Both pieces argue that healthcare valuations had become disconnected from fundamentals,
then began to recover as political pressure eased and acquisition activity resumed.

For your French network, the messaging is mostly valuation-driven: healthcare had lagged,
discounts widened, and a mean-reversion narrative became sellable again once policy risk
looked less acute. The *FT Adviser* article highlights that framing directly:

#quote[
  Pharmaceuticals trade at one of the largest discounts to the broader market on record
  ... a mean-reverting thing. These discounts don't last forever.
]

The French-facing conversation is reinforced by *Les Echos Investir*, which links improved
visibility to renewed M&A by large pharmaceutical groups:

#quote[
  Après ce regain de visibilité, les big pharmas se sont senties beaucoup plus à l'aise
  pour délier leur bourse ... On a assisté à un retour en force des fusions-acquisitions.
]

For Italian distributors, the trigger is different: competitor activity and headline
economics on comparable certificates, not French media coverage itself.

Internally, the desk reads both articles as *commercial support* rather than valuation
evidence for the note itself. They can justify why clients are willing to discuss
healthcare exposure at year-end, but they do not determine whether the proposed Athena
terms are economically sound at 100% issue with a 1.5% margin target.

This distinction matters for the committee: the same press narrative that strengthens the
sales pitch can coexist with a product configuration that is too expensive for the issuer
once market data, barriers, and coupon mechanics are priced consistently.

#v(0.8em)
#text(size: 9pt, fill: luma(100))[
  _Exhibits B1 and B2 are included as abridged source extracts. Product mechanics and
  market inputs follow in Section 4 and Exhibit D._
]

