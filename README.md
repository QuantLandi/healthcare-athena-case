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
| **Complete pack (WIP)** | Typst → PDF | [`athena_healthcare_case_pack.pdf`](athena_healthcare_case_pack.pdf) — narrative §1–7 + exhibits A–E, watermarked |
| Exhibits A–E (sources) | Typst fragments | In `content/` (bundled into the pack) |
| MC pricer spreadsheet | Excel | Planned |
| Teaching note (instructor guide) | Typst → PDF | Planned |
| Shared Typst template | `lib.typ` | Ready |

### Exhibits in the pack

| Exhibit | Description | Source |
|---------|-------------|--------|
| **A** | Anonymized Athena term sheet | [`content/exhibit_a.typ`](content/exhibit_a.typ) |
| **B1** | FT Adviser summary (EN) | [`content/exhibit_b1.typ`](content/exhibit_b1.typ) |
| **B2** | Les Echos Investir summary (FR) | [`content/exhibit_b2.typ`](content/exhibit_b2.typ) |
| **C** | PRIIPs KID excerpt | [`content/exhibit_c.typ`](content/exhibit_c.typ) |
| **D** | Market data (27 Nov 2026) | [`content/exhibit_d.typ`](content/exhibit_d.typ) |
| **E** | Competitor scan (Italy) | [`content/exhibit_e.typ`](content/exhibit_e.typ) |

---

## Repository layout

```
healthcare-athena-case/
├── README.md
├── LICENSE                          ← CC BY-NC 4.0 (Alexandre Landi)
├── PLAN.md                          ← master plan & Case Centre checklist
├── lib.typ                          ← shared Typst template
├── athena_healthcare_case_pack.typ  ← full pack + watermarked PDF (main deliverable)
├── content/                         ← case body + exhibit fragments
├── teaching_note/                   ← instructor guide (planned)
└── spreadsheet/                     ← MC pricer (planned)
```

---

## Build PDFs

Requires [Typst](https://typst.app/) ≥ 0.14. From the repo root:

```sh
typst compile --root . athena_healthcare_case_pack.typ
```

The pack PDF combines the narrative and Exhibits A–E, with a diagonal watermark and matching footer (*date · Work in progress · Alexandre Landi*).

---

## Audience

- **Students** — the watermarked pack PDF (and spreadsheet assignment when complete).
- **Instructors** — full kit including teaching note and model answers; clone this repo to adapt the Typst sources under `content/`.

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
