#import "/lib.typ": *

#let pack-date = "20 August 2026"

#show: doc.with(
  title: [Healthcare Phoenix Autocallable],
  subtitle: [Instructor review pack — narrative and exhibits A–E],
  date: [#pack-date · Work in progress · #case-author],
  watermark: (
    author: case-author,
    date: pack-date,
    label: "Work in progress",
  ),
)

#include "/case/instructor_front.typ"
#include "/case/case_body.typ"

#pagebreak()
#align(center)[
  #text(size: 16pt, weight: "bold")[Exhibits]
  #v(0.3em)
  #text(size: 10pt, fill: luma(100))[Term sheet · press · KID · market data · competitor scan]
]

#pagebreak()
#align(center)[
  #text(size: 14pt, weight: "bold")[Exhibit A — Final Terms (Summary)]
  #v(0.2em)
  #text(size: 9.5pt, fill: luma(100))[Healthcare Phoenix Autocallable Notes due 1 December 2031]
]
#v(0.8em)
#include "/case/exhibit_a.typ"

#pagebreak()
#align(center)[
  #text(size: 14pt, weight: "bold")[Exhibit B1 — Press Excerpt (English)]
  #v(0.2em)
  #text(size: 9.5pt, fill: luma(100))[Healthcare shows strong signs of recovery · FT Adviser · 11 August 2026]
]
#v(0.8em)
#include "/case/exhibit_b1.typ"

#pagebreak()
#align(center)[
  #text(size: 14pt, weight: "bold")[Exhibit B2 — Extrait presse (français)]
  #v(0.2em)
  #text(size: 9.5pt, fill: luma(100))[Les Echos Investir · 13 août 2026]
]
#v(0.8em)
#set text(lang: "fr")
#include "/case/exhibit_b2.typ"
#set text(lang: "en")

#pagebreak()
#align(center)[
  #text(size: 14pt, weight: "bold")[Exhibit C — PRIIPs KID (Excerpt)]
  #v(0.2em)
  #text(size: 9.5pt, fill: luma(100))[Draft · ISIN XS2EIB0HC2026]
]
#v(0.8em)
#include "/case/exhibit_c.typ"

#pagebreak()
#align(center)[
  #text(size: 14pt, weight: "bold")[Exhibit D — Market Data Snapshot]
  #v(0.2em)
  #text(size: 9.5pt, fill: luma(100))[Trade date / initial fixing · 27 November 2026]
]
#v(0.8em)
#include "/case/exhibit_d.typ"

#pagebreak()
#align(center)[
  #text(size: 14pt, weight: "bold")[Exhibit E — Competitor Scan (Desk Note)]
  #v(0.2em)
  #text(size: 9.5pt, fill: luma(100))[Italian retail · November 2026]
]
#v(0.8em)
#include "/case/exhibit_e.typ"
