// Shared styles — case study deliverables

#let case-title = "Healthcare Athena Autocallable"
#let case-author = "Alexandre Landi"

#let wip-line(
  author: case-author,
  date: none,
  label: "Work in progress",
) = {
  if date != none {
    [#date · #label · #author]
  } else {
    [#label · #author]
  }
}

#let wip-watermark(
  author: case-author,
  date: none,
  label: "Work in progress",
) = {
  place(
    center + horizon,
    rotate(
      -35deg,
      text(36pt, fill: rgb(180, 180, 180, 35%), weight: "medium")[
        #wip-line(author: author, date: date, label: label)
      ],
    ),
  )
}

#let doc(
  title: none,
  subtitle: none,
  date: none,
  author: case-author,
  lang: "en",
  watermark: none,
  body,
) = {
  set text(size: 10.5pt, lang: lang)
  set par(justify: true, leading: 0.65em)
  set heading(numbering: none)

  show link: set text(fill: rgb("#1a5276"))
  show quote: block.with(
    inset: (left: 1.2em, y: 0.4em),
    stroke: (left: 2pt + luma(180)),
  )

  set page(
    paper: "a4",
    margin: (x: 2.2cm, y: 2.4cm),
    background: if watermark != none {
      wip-watermark(
        author: watermark.at("author", default: author),
        date: watermark.at("date", default: none),
        label: watermark.at("label", default: "Work in progress"),
      )
    },
    header: context {
      if counter(page).get().first() > 1 [
        #set text(size: 8.5pt, fill: luma(120))
        #case-title
        #h(1fr)
        #if title != none [#title]
      ]
    },
    footer: context [
      #set text(size: 8.5pt, fill: luma(120))
      #if watermark != none [
        #wip-line(
          author: watermark.at("author", default: author),
          date: watermark.at("date", default: none),
          label: watermark.at("label", default: "Work in progress"),
        )
      ] else [
        #author
      ]
      #h(1fr)
      #counter(page).display("1 / 1", both: true)
    ],
  )

  if title != none {
    align(center)[
      #text(size: 18pt, weight: "bold")[#title]
      #if subtitle != none [
        #v(0.35em)
        #text(size: 11pt, fill: luma(80))[#subtitle]
      ]
      #if date != none [
        #v(0.5em)
        #text(size: 9.5pt, fill: luma(100))[#date]
      ]
      #if author != none and watermark == none [
        #v(0.4em)
        #text(size: 9.5pt, fill: luma(100))[#author]
      ]
    ]
    v(1.2em)
  }

  body
}

#let status-badge(content) = {
  box(
    fill: luma(240),
    inset: (x: 0.5em, y: 0.25em),
    radius: 2pt,
  )[#text(size: 9pt)[#content]]
}

#let exhibit-label(id, lang: "en") = {
  text(weight: "bold", fill: rgb("#1a5276"))[Exhibit #id]
}

#let abridged-note(lang: "en") = {
  let msg = if lang == "fr" {
    "Résumé abrégé pour cette étude de cas — ne pas confondre avec l'article intégral."
  } else {
    "Abridged excerpt for this case study — not a full reproduction of the source article."
  }
  block(
    fill: luma(245),
    inset: 0.8em,
    radius: 3pt,
    width: 100%,
  )[
    #text(size: 9pt, style: "italic")[#msg]
  ]
}
