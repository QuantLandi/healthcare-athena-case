# Healthcare Athena Autocallable — Case Study

[![License: CC BY-NC 4.0](https://img.shields.io/badge/License-CC%20BY--NC%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc/4.0/)
[![Status: Work in progress](https://img.shields.io/badge/status-work%20in%20progress-orange)](PLAN.md)
[![Typst](https://img.shields.io/badge/built%20with-Typst-239dad)](https://typst.app/)

**Author:** Alexandre Landi

Take-home case study for advanced finance courses: price and launch an **Athena autocallable** on a **healthcare index** for EU retail, grounded in August 2026 financial press (FT Adviser + Les Echos Investir).

> **Draft repository.** This GitHub repo is the open, work-in-progress source (Typst sources, instructor materials). A polished, citable edition is planned for [The Case Centre](https://www.thecasecentre.org/).

---

## What's included

| Component | Format | Status |
|-----------|--------|--------|
| Case narrative (8–12 pp.) | Typst → PDF | **§1–2** draft |
| Exhibits A–E | Typst → PDF | **A, B1, B2, D** done · C, E pending |
| MC pricer spreadsheet | Excel | Planned |
| Teaching note (instructor guide) | Typst → PDF | Planned |
| Shared Typst template | `lib.typ` | Ready |

### Available now (PDF + source)

| Exhibit | Description | PDF | Source |
|---------|-------------|-----|--------|
| **A** | Anonymized Athena term sheet | [PDF](exhibits/A_term_sheet.pdf) | [Typst](exhibits/A_term_sheet.typ) |
| **B1** | FT Adviser summary (EN) | [PDF](exhibits/B1_ft_adviser_summary.pdf) | [Typst](exhibits/B1_ft_adviser_summary.typ) |
| **B2** | Les Echos Investir summary (FR) | [PDF](exhibits/B2_lesechos_summary.pdf) | [Typst](exhibits/B2_lesechos_summary.typ) |
| **D** | Market data (27 Nov 2026) | [PDF](exhibits/D_market_data.pdf) | [Typst](exhibits/D_market_data.typ) |

---

## Repository layout

```
healthcare-athena-case/
├── README.md                 ← you are here
├── LICENSE                   ← CC BY-NC 4.0 (Alexandre Landi)
├── PLAN.md                   ← master plan & Case Centre checklist
├── lib.typ                   ← shared Typst template
├── athena_healthcare_case.typ       ← case narrative + PDF (planned)
├── exhibits/
│   ├── *.typ
│   └── *.pdf                        ← same basename as each .typ
├── teaching_note/
│   └── instructor_guide.typ         ← + PDF (planned)
└── spreadsheet/
    └── athena_pricer.xlsx           ← planned
```

Empty folders are not tracked; create them when adding new deliverables.

---

## Build PDFs

Requires [Typst](https://typst.app/) ≥ 0.14. From the repo root:

```sh
typst compile --root . exhibits/A_term_sheet.typ
typst compile --root . exhibits/B1_ft_adviser_summary.typ
typst compile --root . exhibits/B2_lesechos_summary.typ
typst compile --root . exhibits/D_market_data.typ
typst compile --root . athena_healthcare_case.typ
```

PDFs are written next to each `.typ` source (e.g. `exhibits/A_term_sheet.pdf`).

---

## Audience

- **Students** — case narrative, exhibits, and spreadsheet assignment (when complete).
- **Instructors** — full kit including teaching note and model answers; clone this repo to adapt the Typst workflow or fork exhibits.

See [`PLAN.md`](PLAN.md) for learning objectives, exhibit catalogue, assignment prompts, and Case Centre submission roadmap.

---

## Source press articles

Exhibits B1 and B2 are **abridged summaries**, not full reproductions.

- [FT Adviser (EN), 11 Aug 2026](https://www.ftadviser.com/content/b5340a65-ad65-466e-b4bb-f8d30f76bc5a)
- [Les Echos Investir (FR), 13 Aug 2026](https://investir.lesechos.fr/actu-des-valeurs/etudes/le-secteur-pharmaceutique-est-moins-entoure-mais-les-operations-de-fusion-acquisition-accelerent-2247014)

---

## License

Copyright © 2026 Alexandre Landi. Licensed under [CC BY-NC 4.0](LICENSE).

Attribution required; non-commercial use only without separate permission. Commercial distribution (e.g. Case Centre listing) is handled separately from this draft repo.
