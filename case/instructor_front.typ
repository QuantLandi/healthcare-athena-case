#block(
  fill: luma(248),
  inset: 0.8em,
  radius: 3pt,
  width: 100%,
)[
  #text(size: 9pt)[
    *Instructor review edition.* This watermarked pack is for adoption review and pilot planning.
    It is *not* the final student handout: rubric and model answers will live in a
    separate teaching note; the student case will not include this page. Student
    deliverables are listed in Section 8.
  ]
]

#v(0.8em)

== Synopsis

Decision case: a junior structurer at Banque Meridian must recommend whether to
*launch*, *revise*, or *reject* a five-year healthcare *Phoenix* autocallable for EU retail,
fixed at the *27 November 2026* market snapshot. Proposed terms (6% conditional coupon,
60% barrier, 100% issue) are expected to fall short of the desk's *1.5%* gross margin once
priced by Monte Carlo. Students reconcile fair value, PRIIPs KID language, distributor
pressure, and MiFID II governance.

== Intended use

#table(
  columns: (auto, 1fr),
  inset: 6pt,
  stroke: 0.5pt + luma(200),
  [*Format*], [Individual assignment · ~6–8 h student work],
  [*Level*], [MSc Finance / advanced undergrad derivatives course],
  [*Prerequisites*], [GBM and discounting; barrier/path-dependent intuition; Monte Carlo (Excel or Python)],
  [*Deliverables*], [§8: pricing workbook · payoff diagram · ≤1-page recommendation · short compliance note],
  [*Model answer (draft)*], [*Revise* at proposed terms; σ ≈ 17%; fair value below 100% at 100% issue],
)

== Learning objectives

+ Decompose a *Phoenix* autocallable into elementary payoffs.
+ Price a path-dependent note by Monte Carlo using locked Exhibit D inputs.
+ Link commercial narrative (Exhibits B1–B2) to product terms and spot mismatches.
+ Interpret PRIIPs KID scenarios (Exhibit C) vs internal fair value.
+ Form a governance judgment: launch, revise, or reject.

== Pack structure

#table(
  columns: (auto, 1fr),
  inset: 6pt,
  stroke: 0.5pt + luma(200),
  table.header([*Section*], [*Content*]),
  [Case §1–2], [Setting · head-of-desk memo and launch ask (28 Nov 2026)],
  [Case §3], [Market context · pointer to press exhibits],
  [Case §4], [Product brief · Phoenix mechanics (vs Athena)],
  [Case §5], [Data and constraints · locked vs judgement inputs],
  [Case §6], [The decision · committee presentation (1 Dec 2026)],
  [Case §7], [Governance · press vs KID · suitability],
  [Case §8], [Deliverables · student hand-in checklist],
  [Exhibit A], [Term sheet],
  [Exhibit B1], [FT Adviser excerpt (EN)],
  [Exhibit B2], [Les Echos Investir excerpt (FR)],
  [Exhibit C], [PRIIPs KID excerpt (draft)],
  [Exhibit D], [Market data · 27 Nov 2026 snapshot],
  [Exhibit E], [Competitor scan (Italy)],
)

#v(0.6em)
#text(size: 9pt, fill: luma(100))[
  _Still to build for classroom release: full teaching note (rubric + model answers) and a
  student-facing PDF without this instructor page. Student deliverables are already in
  Section 8. Reference MC pricer: `phoenix_mc_pricer.py` in the repo root._
]

#v(0.8em)
== Acknowledgements

#text(size: 9.5pt)[
  Thanks to *Massimo Passamonti* for expert feedback on product mechanics and terminology.
]

#pagebreak()
