# NBA Draft Analysis: Identifying Highest Potential Lottery Picks by Position

A data analysis project examining which positions offer the most reliable outcomes when selected with a lottery pick in the NBA
draft, using an Omega-style analysis built from Box Plus-Minus (BPM) data.

📊 **[View the full report]([report.html](https://thegreenlaser.github.io/nba-draft-evaluation/))**

## Key Finding

Point guards and centers show up as consistently safer picks — higher
expected upside relative to downside — across pick ranges, while
SF/SG/PF positions show greater bust risk. This held true under both an
initial Sortino-style formulation and the Omega-ratio approach that
replaced it.

## Methodology (short version)

- **Data source**: [Basketball Reference](https://www.basketball-reference.com)
  draft pages (2011–2021) and season-level advanced stats (2011–2026)
- **Outcome metric**: Box Plus-Minus (BPM), averaged over each player's
  3rd–5th NBA seasons
- **Missing seasons**: floored at -5 BPM (treated as replacement-level/unavailable)
- **Pick bins**: grouped in ranges of 2 picks (1–2, 3–4, etc.)
- **Position tagging**: assigned by each player's most common position
  listing during their rookie year
- **Safety Score**: an Omega ratio — total upside (sum of positive
  residuals vs. expected BPM for pick range) divided by total downside
  (sum of negative residuals) — computed per position

Full methodology, including the Sortino → Omega pivot and the reasoning
behind it, is documented in the report itself.

## Reproducing This Analysis

The report runs by scraping web data off of "basketballreference.com".

1. Clone the repo
2. Open `report.qmd` in RStudio
3. Click **Render** (or run `quarto::render("report.qmd")` in the console)

## Requirements

- R (4.x+) and RStudio
- Quarto (bundled with recent RStudio versions, or install separately at
  [quarto.org](https://quarto.org/docs/get-started/))
- R packages: `tidyverse`, `httr`, `rvest`, `ggplot2`, `patchwork`
