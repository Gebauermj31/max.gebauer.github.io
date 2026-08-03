---
title: Sparse Controls in Spatial Epidemiology
subtitle: "Sparse Control Selection For Spatial Epidemiological Data: Double Lasso And County COVID-19 Mortality"
summary: A thesis project on choosing controls in high-dimensional county health data while accounting for spatial dependence.
status: M.A. thesis · 2026
featured_order: 3
methods:
  - Double-selection LASSO
  - Negative-binomial regression
  - Markov random field controls
  - Sensitivity analysis
  - Out-of-sample validation
card_image: /assets/images/project-spatial.svg
card_alt: Abstract county map with highlighted spatial neighbors and a sparse set of selected variables
hero_image: /assets/images/spatial-workflow.svg
hero_alt: Conceptual workflow from county-level candidate controls through double-selection LASSO and spatial adjustment to validation and interpretation
hero_caption: Original conceptual workflow based on the thesis design. Approved empirical figures will replace or supplement it after source review.
section: Projects
---

## The problem

County-level epidemiological studies often begin with many plausible social, demographic, and health-system controls. Including all of them can make estimates unstable; choosing them informally can omit important confounding structure. At the same time, nearby counties are not independent: regional conditions and diffusion processes can produce spatial correlation.

My Statistics &amp; Data Science thesis studies this problem in the context of county COVID-19 mortality.

## Method

Double-selection LASSO uses two related selection steps: one identifies variables associated with the exposure of interest, and the other identifies variables associated with the outcome. The union of those controls is then used in the estimating model. The approach aims to protect the focal estimate from variables that matter strongly on either side of the relationship.

The thesis combines that sparse-control strategy with a negative-binomial regression model and Markov random field spatial controls. It investigates the association between U.S. county-level partisanship and COVID-19 mortality. Validation and sensitivity analyses ask whether the selected specification is stable, whether remaining spatial structure is visible, and how conclusions change under alternative modeling choices.

## Interpretation

The project is less about declaring a single county-level effect than about building a defensible workflow for observational health data: selection should be reproducible, geographic dependence should be explicit, and estimates should travel with limitations.

This page does not yet report empirical findings. The final public version will be checked against the complete thesis report and will use only figures and claims approved for release.
