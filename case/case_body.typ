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
platform books most EU retail notes. On issue days you work with both locations remotely until
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
typically *Phoenix* and *Athena* autocallables and soft-barrier income products on single indices or
thematic baskets. Distributors want *simple stories*: a sector recovery, a familiar index,
a conditional coupon that sounds generous next to deposit rates. They want *fast*
turnaround when a theme is in the press. The head of Structured Products (Retail) sets a
*minimum gross structuring margin* of *1.5%* of nominal on new issues — enough to cover
distribution rebates, hedging slippage, and the occasional gap between internal model and
street quote. Issues are almost always quoted to clients at *100%* of the €1,000 minimum
denomination; economics live in the spread between *fair value* — the desk's model
present value of the note's expected cash-flows under the locked market snapshot and
documented assumptions (volatility, discounting) — and that 100% issue price. Fair value
here is an issuer/structuring measure used to test the gross margin floor; it is not a
client valuation or a distributor all-in price after rebates.

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

Over the past week you have assembled the working pack for a five-year *healthcare Phoenix*
on the *Euro iSTOXX 50 Future Healthcare Tilted NR Decrement 5%* index: proposed terms
(Exhibit A), market data as of the *27 November* trade date (Exhibit D), draft KID
excerpts, and a competitor scan still being finalised (Exhibit E). Initial fixing on the
index was set on *Wednesday 27 November*. The Luxembourg pricing committee meets *today*,
1 December 2026, at 10:00. If validated, issue and settlement are expected around *two
weeks* later — #sym.bracket.l 15 December 2026 #sym.bracket.r.

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
    *Subject:* RE: Healthcare Phoenix — *need pricing pack for Monday committee*
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
  your numbers Monday at *08:00*, but *you* present fair value and the launch recommendation.

  Target remains *100% issue* and *≥ 1.5%* gross margin. If you cannot get there, come
  with revised terms — do not ask the committee to approve a loss leader.

  — MCF
]

In desk usage, the *pricing pack* is the committee file you own: Monte Carlo (or
equivalent) fair value and sensitivities at the locked 27 November snapshot, the
proposed or revised terms, margin versus the 1.5% floor, and a one-page
launch / revise / reject recommendation coherent with the KID draft.

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
  [*Reference*], [BM-SP/2026/HC-PHX-047],
  [*Date*], [28 November 2026],
  [*Expected issue date*], [#sym.bracket.l 15 December 2026 #sym.bracket.r (initial fixing 27 November 2026; committee 1 December 2026)],
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
  [*Product*], [Healthcare Phoenix Autocallable Notes due 1 December 2031],
  [*Underlying*], [Euro iSTOXX 50 Future Healthcare Tilted NR Decrement 5% (EUR)],
  [*Structure*], [6% p.a. conditional coupon · 60% coupon/capital barrier · annual autocall at 100%],
  [*Issue price*], [100% of €1,000 denomination],
  [*Target notional*], [EUR 50 million],
  [*Distribution*], [France (lead), Italy, Luxembourg],
  [*Terms*], [Attached summary term sheet — HC-PHX-047-TS],
)

Issuer: *Banque Meridian* (Luxembourg) — own-name retail issuance; the desk both structures
and books the note. KID draft attached (pending your fair-value run).

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
  [Term sheet], [Healthcare Phoenix — final terms (HC-PHX-047-TS)], [Final draft],
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
  [Head of SP (Retail)], [M.-C. Fontaine], [Review Monday 08:00],
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
healthcare exposure at year-end, but they do not determine whether the proposed Phoenix
terms are economically sound at 100% issue with a 1.5% margin target.

This distinction matters for the committee: the same press narrative that strengthens the
sales pitch can coexist with a product configuration that is too expensive for the issuer
once market data, barriers, and coupon mechanics are priced consistently.

#v(0.8em)
#text(size: 9pt, fill: luma(100))[
  _Exhibits B1 and B2 are included as abridged source extracts. Product mechanics and
  market inputs follow in Section 4 and Exhibit D._
]

= 4. Product brief

The proposed instrument is a five-year *Phoenix autocallable* on the Euro iSTOXX 50 Future
Healthcare Tilted NR Decrement 5% index (EUR). In client language, it offers conditional
quarterly income with potential early redemption if the index is at or above its initial
level on annual autocall dates. In desk language, it is a path-dependent structure whose
economics are driven by three linked features: the quarterly coupon condition, annual
autocall condition, and soft capital barrier at maturity.

Desk terminology distinguishes *Phoenix* from classic *Athena*: a Phoenix has *separate*
coupon and autocall barriers, and pays a conditional coupon whenever the coupon condition
is met — even if the note is not autocalled. A classic *Athena* aligns those barriers;
coupons are typically accumulated and paid together with redemption when the autocall
trigger fires. Do *not* treat retail *Athena* wording as a different payoff: distributors
sometimes misuse *Athena* as a catch-all label for autocallable income notes. This note
is a *Phoenix* (separate coupon and autocall barriers). Exhibit A follows that desk
naming.

For this transaction, headline terms are:

- issue at 100% of €1,000 denomination;
- 1.50% quarterly coupon (6.00% p.a.) if index >= 60% of initial level on each coupon date;
- annual autocall if index >= 100% of initial level (2027 to 2030 dates);
- at final valuation (1 Dec 2031), return 100% if index >= 60%; otherwise redeem pro rata
  to final index performance.

Full legal wording and date schedule are in *Exhibit A*.

== How the payoff works

The table below is the desk's simplified decision map for committee discussion (not legal
terms). It focuses on *what decision is taken at each observation date*.

#table(
  columns: (auto, 1fr, 1fr),
  inset: 7pt,
  stroke: 0.5pt + luma(200),
  table.header([*Date type*], [*Condition on index*], [*Cash-flow consequence*]),
  [Quarterly coupon date], [Index >= 60% of initial], [Pay 1.50% coupon for that quarter],
  [Quarterly coupon date], [Index < 60% of initial], [No coupon (non-memory; not recovered later)],
  [Annual autocall date], [Index >= 100% of initial], [Redeem at 100% + coupon due; note terminates],
  [Annual autocall date], [Index < 100% of initial], [No autocall; continue to next observation date],
  [Final valuation (if not autocalled)], [Index >= 60% of initial], [Redeem 100% (+ final coupon if coupon condition met)],
  [Final valuation (if not autocalled)], [Index < 60% of initial], [Redeem 100% × (Final / Initial)],
)

== Why this structure is commercially attractive

For distributors, the package is easy to present: a thematic healthcare story, a visible
coupon number, and partial downside protection versus direct equity exposure. It also
matches a familiar retail template in France and Italy where annual autocall mechanics are
well understood by adviser networks.

For the issuer, attractiveness depends on *priceability*, not marketing language alone.
The same terms that improve client appeal (high coupon, low coupon barrier) can compress
margin when priced against the 27 November market snapshot. That tension is the center of
your committee decision.

== Risks and suitability points flagged before committee

- *Complexity risk:* multiple observation dates and conditional cash flows can be
  misunderstood by end clients.
- *Barrier risk:* below 60% at final valuation, capital loss is linear with index decline.
- *Autocall / reinvestment risk:* early redemption occurs in stronger markets, forcing
  clients to reinvest when comparable yields may be lower.
- *Issuer credit risk:* notes are unsecured obligations of the issuer.
- *Scenario communication risk:* PRIIPs moderate scenario may not align with the sales
  headline unless assumptions are explained clearly.

#v(0.8em)
#text(size: 9pt, fill: luma(100))[
  _A full payoff diagram is intentionally not provided here. Construct one from Exhibit A
  as required in Section 8 (Deliverables); an optional instructor diagram can
  be added later as Exhibit F._
]

= 5. Data and constraints

You arrive at committee with a deliberately *mixed* pack: some inputs are frozen, others
remain judgement calls. The desk rule is that pricing must be reproducible from the
documents on the table — not from live market feeds or post-fixing index prints.

== Locked inputs

The following are fixed for this decision:

#table(
  columns: (auto, 1fr),
  inset: 7pt,
  stroke: 0.5pt + luma(200),
  [*Item*], [*Source / value*],
  [Trade date / initial fixing], [27 November 2026 · $S_0$ = 2,318.47 — Exhibit D],
  [Committee date], [1 December 2026 (today)],
  [Expected issue date], [#sym.bracket.l 15 December 2026 #sym.bracket.r (if committee validates)],
  [Proposed structure], [6% p.a. conditional · 60% barrier · annual autocall at 100% — Exhibit A],
  [Issue price], [100% of €1,000 denomination],
  [EUR discount curve], [Observation-date OIS zeros — Exhibit D (locked; hedge / index)],
  [ALM credit grid], [Spreads vs OIS by expected life — Exhibit D; student chooses tenor],
  [Index decrement], [5% p.a. continuous ($q$); already embedded in published index level],
  [Margin floor], [1.5% gross structuring margin to bank],
)

Repricing on "today's" spot or swap levels is out of scope. The committee is judging whether
*these* terms are economic at *this* snapshot.

== Judgement calls (documented)

Two areas require explicit assumptions in your presentation:

+ *Volatility.* No listed options exist on the decrement index. Exhibit D gives a desk
  working range of *16–18%* flat Black vol and sector context; you must choose one level,
  justify it, and show sensitivity (at minimum ±2 vol points).
+ *Credit spread (frais de crédit).* The OIS curve in Exhibit D is locked and is used for
  the *index / hedge*. Coupons and redemption are unsecured liabilities of *Banque Meridian*:
  they do *not* discount at OIS. Exhibit D gives Meridian ALM / treasury's short grid of
  credit spreads versus OIS by *expected life*. You must (i) state an expected life — *1Y*
  if you argue the note is likely to autocall at the first opportunity; longer if you expect
  it to remain outstanding, or if redeemed clients will be rolled into a new theme —
  (ii) take the matching spread $s$ from the grid, and (iii) discount note cash-flows
  with $ "DF"_"note" (T) = "DF"_"OIS" (T) e^(-s T) $ (Exhibit D). A wider spread lowers
  fair value and improves modelled margin. Do not invent a spread outside the grid;
  do not apply the spread to index drift.

Everything else needed for a first-pass Monte Carlo fair value should flow from Exhibits A
and D alone.

== Regulatory and commercial constraints

Beyond fair value, approval depends on consistency across three lenses:

#enum(
  [*Internal economics* — fair value at 100% issue and gross margin vs the 1.5% floor.],
  [*PRIIPs KID* — prescribed moderate / unfavourable / favourable scenarios and risk
  indicator must not contradict defensible marketing (Exhibit C, draft).],
  [*MiFID II target market* — product governance: advised retail, buy-and-hold compatible
  horizon, clients who can bear barrier and issuer risk (Exhibit A, target-market summary).],
)

Sales has already circulated a *"6% healthcare income"* headline. Compliance will not
object to thematic language if the KID and internal model support it; they *will* object if
the moderate scenario implies a return profile that advisers cannot square with the pitch.

== Materials still in flux

Not every attachment is final as you walk into the room:

#table(
  columns: (auto, 1fr, auto),
  inset: 6pt,
  stroke: 0.5pt + luma(200),
  table.header([*Document*], [*Role*], [*Status*]),
  [Term sheet (Exhibit A)], [Legal mechanics and schedule], [Final draft],
  [Market-data pack (Exhibit D)], [Spot, curve, vol context, observation DFs], [Final],
  [KID excerpt (Exhibit C)], [Retail scenario disclosure], [Draft — tied to your FV run],
  [Competitor scan (Exhibit E)], [Italian headline comparison vs Intesa-style product], [Finalising this morning],
  [Press dossier (B1–B2)], [Commercial narrative only], [Final],
)

The competitor scan matters for *distribution* (can Meridian match Italian headline
economics?) but does not replace your own fair-value work. The KID draft cannot be signed
until your volatility choice and fair value are on record.

== What the committee expects from you

In practical terms, you must be ready to answer four questions without opening a live
pricing terminal:

#enum(
  [What is fair value of the proposed terms at 100% issue, and what gross margin does that imply?],
  [If margin is below 1.5%, what *one* revised lever (coupon, barrier, autocall trigger, or issue price) restores it?],
  [Does the PRIIPs moderate scenario support or undermine the sales story?],
  [Launch, revise, or reject — and can you defend that to French and Italian distributors?],
)

= 6. The decision

At 09:52, your video tile appears in the Luxembourg pricing committee queue. Your head of
desk joins from Paris. Compliance has dialed in with the latest KID draft open. Sales is
not in the room but is waiting for a go/no-go message before calling the French and Italian
distribution teams.

You have ten minutes to present:

#enum(
  [your fair value range under documented assumptions,],
  [gross margin at 100% issue under the proposed 6% / 60% structure,],
  [one revised parameter set if the 1.5% floor is not met,],
  [a launch recommendation that is coherent with KID language and target-market constraints.],
)

The chair reminds the room that this is not a marketing debate. If economics fail at the
locked market snapshot, terms must be revised before any launch message is sent. If terms
are revised, sales needs wording that can be explained quickly to advisers who were already
teased with a "6% healthcare income" headline.

== Committee pressure points

The discussion quickly narrows to five pressure points:

- *Economics:* whether the proposed package can clear the 1.5% margin floor at 100% issue.
- *Commercial credibility:* how far terms can move before French and Italian distributors
  perceive a bait-and-switch.
- *Fit and priorities:* product–target-market fit, sales wording, and ranking versus other
  offers on the desk — not only fair value and margin.
- *KID coherence:* whether moderate-scenario disclosures remain defensible under the chosen
  volatility and discounting assumptions.
- *Execution timing:* whether there is enough time to revise terms and still hit year-end
  distribution windows.

No one questions the healthcare story itself. The disagreement is about whether the story
supports this *specific* package at this *specific* price.

== Your recommendation

You are asked to close with a single recommendation for immediate action:

#table(
  columns: (auto, 1fr),
  inset: 7pt,
  stroke: 0.5pt + luma(200),
  [*Option A*], [Launch proposed terms unchanged (6% coupon, 60% barrier, 100% issue)],
  [*Option B*], [Revise terms before launch (adjust one lever and re-clear margin / KID checks)],
  [*Option C*], [Reject this launch window and re-open later with a redesigned structure],
)

You are expected to justify the option in one page, including:

- key pricing assumptions and sensitivity anchors,
- economics versus the 1.5% floor,
- expected distributor reaction in France and Italy,
- principal conduct and suitability risks if launched unchanged.

Your recommendation will determine whether Meridian sends a launch confirmation before noon
or reopens structuring with revised terms.

#v(0.8em)
#text(size: 9pt, fill: luma(100))[
  _Section 7 outlines the governance tensions that sit alongside the pricing decision.
  Formal deliverables are listed in Section 8._
]

= 7. Governance and open tensions

Even with a defensible fair-value range, this launch sits at the intersection of three
regimes that do not always speak the same language: *desk economics*, *retail disclosure*,
and *distributor sales practice*.

== Press narrative versus PRIIPs scenarios

The August press dossier supports a constructive healthcare story — recovery, re-rating,
M&A visibility. It is useful for opening adviser conversations. It is *not* a substitute
for product-level risk disclosure. PRIIPs requires prescribed performance scenarios over
defined horizons; the moderate scenario in particular can understate headline coupon
language if clients focus on the 6% annual equivalent rather than conditionality, barriers,
and early autocall mechanics. Compliance's concern is not whether healthcare is a good
sector, but whether advisers can explain what the *note* does when the index path is
unfavourable.

== Target market and suitability

Exhibit A describes a target market of advised retail and private-banking clients with a
buy-and-hold compatible horizon and tolerance for barrier and issuer risk. That profile is
broad. Product governance asks whether the *same* structure should be sold to a French
private-banking client attracted by the Les Echos recovery narrative and an Italian retail
client comparing headline coupons against a competitor certificate — when the economic
terms may need revision to meet internal margin standards. Suitability is not only
"can the client bear loss?" but "is this the right product at this price for this client
channel?"

== Sales language under scrutiny

Several phrases already circulating in distributor channels would draw scrutiny if the
note launched unchanged at uneconomic terms:

- *"6% healthcare income"* — obscures that coupons are conditional and non-memory.
- *"Protected down to 40%"* — common shorthand for a 60% barrier; easy to misread as
  capital guarantee above the barrier on every date, not only at final valuation.
- *"Healthcare recovery play"* — conflates sector equity exposure with structured-note
  payoff mechanics and issuer credit.

The desk does not need to draft marketing copy in the committee room, but it cannot ignore
what sales is likely to say once a launch confirmation goes out.

== Competitor pressure versus issuer discipline

Italian distributors will compare Meridian's headline to Intesa-style alternatives (Exhibit E).
French distributors care more about thematic fit and adviser materials. Neither comparison
relieves the structurer of the 1.5% margin floor. A product launched to "match the street"
at sub-economic terms shifts loss to the issuer and creates conduct risk if the KID
moderate scenario contradicts the pitch. The governance question is where to draw the line
between commercial flexibility and product discipline.

== Where the narrative ends

You leave the committee with a single actionable outcome: confirm launch on revised terms,
delay and redesign, or reject. Section 8 states what to submit; Exhibits A–E then provide
the term sheet, press context, KID excerpt, market inputs, and competitor scan needed to
support that judgement.

= 8. Deliverables

Formal requirements for this case. Work from the locked *27 November 2026*
snapshot (Exhibit D) and the proposed terms in Exhibit A unless you revise a lever under
Option B.

== What to submit

#enum(
  [*Pricing workbook* (Excel or Python) — Monte Carlo (or equivalent) fair value of the
    proposed structure at 100% issue, with documented code or formulae.],
  [*Payoff diagram* — a tree or chart of the Phoenix payoffs constructed from Exhibit A
    (coupon, autocall, barrier, and maturity capital outcomes).],
  [*Recommendation memo* (≤ 1 page) — a single choice among Options A / B / C (Section 6),
    with the justification bullets listed there.],
  [*Short compliance note* (≤ ½ page) — coherence of internal fair value, sales language
    ("6% healthcare income"), and the PRIIPs KID moderate scenario (Exhibit C), plus the
    principal MiFID II target-market / suitability risks if launched unchanged.],
)

== Required analysis (must appear in the workbook and/or memo)

#enum(
  [Fair value and implied *gross structuring margin* at the proposed 6% / 60% / 100% issue
    package.],
  [An explicit *volatility* choice within the Exhibit D working range, with justification
    and sensitivity at least ±2 vol points.],
  [The *credit spread* taken from the Exhibit D ALM grid, the *expected life* used to
    choose it, and a one-line justification.],
  [If margin is below the *1.5%* floor: *one* revised lever (coupon, barrier, autocall
    trigger, or issue price), re-priced margin, and a brief note on expected French /
    Italian distributor reaction.],
  [A clear *launch / revise / reject* recommendation consistent with KID language and
    target-market constraints.],
)

== Scope notes

- Repricing on live or post-fixing market levels is out of scope.
- The competitor scan (Exhibit E) informs distribution judgement; it does not replace your
  own fair-value work.

