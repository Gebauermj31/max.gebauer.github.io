# Content guide

Keep the public site concise, accessible, and traceable to an approved source. Write in the first person for general pages. Explain methods in plain language before using technical labels.

## Project entry

Create `_projects/project-slug.md` with this contract:

```yaml
---
title: Project title
subtitle: Specific descriptive subtitle
summary: One-sentence public summary.
status: Public release · 2026
featured_order: 4
methods:
  - Method one
  - Method two
card_image: /assets/images/project-card.svg
card_alt: Literal description of the meaningful visual content
hero_image: /assets/images/project-workflow.svg
hero_alt: Literal description of the workflow
hero_caption: Source and release context.
canonical_url: https://canonical-methods-site.example
repository_url: https://github.com/owner/repository
release_label: v1.0
release_date: 2026-08-03
section: Projects
---
```

Use the body for the question, method, validation, results, and limitations. A project page must not present a candidate model as promoted unless its frozen criteria have passed.

For contextual xwOBA, the release label, summary, figure, canonical URL, and repository URL form one synchronized release unit. Never update only one of them. Sprint speed, player identity, and player traits remain outside the model-training predictor set.

## Publication entry

Create `_publications/year-short-title.md`:

```yaml
---
title: Full title
citation: Full accessible citation.
venue: Journal or venue
status: Published or Forthcoming
date: 2026-01-01
external_url: https://doi.org/...
section: Research
description: One-sentence search description.
---
```

The body should provide an accessible summary: question, central claim, and significance. Add external URLs only after they are approved and exact.

## Images and figures

- Use original or cleared media only; no stock imagery.
- Store optimized public assets in `assets/images/` using descriptive names.
- Supply useful alt text; do not repeat the caption.
- Caption photographs with place and year where known, and credit the photographer.
- Keep below-fold images lazy-loaded.
- Use static SVG or PNG for research figures. Do not add Plotly bundles.
- Research result figures must be aggregate, public-release artifacts.

## Final release checklist

1. Confirm factual copy against the approved CV, manuscripts, reports, and model card.
2. Confirm no private contact data, confidential identity, protected result, or unapproved figure appears.
3. Build with strict front matter and run `scripts/check_site.rb`.
4. Review mobile, tablet, and desktop layouts in light and dark themes.
5. Review keyboard order, focus states, headings, alt text, captions, and contrast.
