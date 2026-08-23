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
| **Complete pack (WIP)** | Typst → PDF | [`athena_healthcare_case_pack.pdf`](athena_healthcare_case_pack.pdf) — instructor review edition (synopsis + §1–7 + exhibits A–E), watermarked |
| Exhibits A–E (sources) | Typst fragments | In `content/` (bundled into the pack) |
| MC pricer | Python (`phoenix_mc_pricer.py`) | Ready |
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
├── phoenix_mc_pricer.py             ← Monte Carlo fair-value pricer
├── pyproject.toml                   ← uv project (numpy)
├── teaching_note/                   ← instructor guide (planned)
```

---

## Monte Carlo pricer

Self-contained reference pricer for the Phoenix autocallable (Exhibits A and D). Requires [uv](https://docs.astral.sh/uv/):

```sh
uv run phoenix_mc_pricer.py --paths 50000
uv run phoenix_mc_pricer.py --until-converged --sigma 0.17 --verbose
uv run phoenix_mc_pricer.py --coupon-pa 0.05 --coupon-barrier 0.55
uv run phoenix_mc_pricer.py --solve-margin
```

### Pipeline

```mermaid
flowchart TD
    main[main] --> pg[price_grid]
    solver[solve_coupon_for_margin] --> pg

    subgraph block["One block inside price_grid"]
        direction LR
        crd[cumulative_rate_drift] --> lfb[levels_from_brownian]
        bg[brownian_grid] --> lfb
        lfb --> pv[discounted_pv] --> stats[RunningStats]
    end

    pg --> block
    pg --> result[PriceResult]

    main --> report[print_report / print_solver_report]
    result --> report
```

One block inside `price_grid` draws shocks once, builds a volatility-independent Brownian grid, then prices every sigma in the sweep on the same paths (common random numbers).

### Functions

| Function | Role | In → Out |
|----------|------|----------|
| `cumulative_rate_drift` | Rate drift from OIS DFs (or flat rate) | rate mode → `(N_OBS,)` drift |
| `brownian_grid` | Random shocks → Brownian paths | shocks → `(N_OBS, n_paths)` |
| `levels_from_brownian` | GBM index levels at one σ | Brownian + σ → levels |
| `discounted_pv` | Exhibit A payoff, path-by-path PV | levels + terms → PV vector |
| `RunningStats` | Streaming mean / SE across blocks | batches of PVs → stats |
| `price_grid` | Orchestrator: blocks, CRN, vol sweep | σ list + terms → `list[PriceResult]` |
| `solve_coupon_for_margin` | Bisect coupon to hit margin target | σ + target → revised terms |
| `main` | CLI wiring only | argv → printed report |

---

## Build PDFs

Requires [Typst](https://typst.app/) ≥ 0.14. From the repo root:

```sh
typst compile --root . athena_healthcare_case_pack.typ
```

The pack PDF is the **instructor review edition**: a one-page synopsis and pack map, then the case narrative and Exhibits A–E, with a diagonal watermark and matching footer (*date · Work in progress · Alexandre Landi*). A separate student PDF (without the instructor page) is planned for classroom release.

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
