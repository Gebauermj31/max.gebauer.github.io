---
title: Contextual xwOBA
subtitle: A public, reproducible challenger to Statcast expected weighted on-base average
summary: A player-agnostic model of contact outcomes that improves point prediction while making its remaining calibration limits visible.
status: Reproducible modeling study
featured_order: 1
methods:
  - Gradient-boosted trees
  - Multiclass probabilities
  - Temporal validation
  - Calibration diagnostics
card_image: /assets/images/project-xwoba.svg
card_alt: Abstract baseball-field geometry with batted-ball trajectories and a calibration curve
hero_image: /assets/images/xwoba-workflow.svg
hero_alt: Workflow from contact physics and game context through temporal model development to aggregate public evaluation
hero_caption: Original conceptual workflow. The public release contains aggregate evidence only; raw Statcast data, row-level predictions, and fitted models are excluded.
release_label: v1 evaluated candidate
release_date: 2026-08-03
section: Projects
---

## The question

Statcast xwOBA estimates the expected offensive value of contact. This study asks a narrower, testable question: can a transparent, reproducible model predict contact outcomes using the physical and environmental context of the batted ball, while deliberately excluding player identity and player traits?

The model uses contact geometry, spray direction, a hang-time proxy, park and roof context, weather exposures, and rule era. It does **not** use sprint speed, age, height, weight, player identity, position, handedness, hit distance, batted-ball class, or realized play outcomes as predictors. That boundary is a design commitment, not a feature-selection accident.

## Design before comparison

The development timeline is locked by season. Data from 2015–2023 form the training period. Whole 2024 games are divided into disjoint tuning and calibration sets. The final comparison is made on matched 2025 contact, with prior exploratory exposure to that season disclosed. Partial 2026 data are reserved for monitoring rather than model selection.

This ordering matters: selection, calibration, and testing answer different questions, and combining them would make the apparent performance easier to overstate.

## What the current evaluation shows

<div class="metric-row wide" aria-label="Selected 2025 test metrics">
  <div class="metric"><strong>120,410</strong><span>matched 2025 contacts</span></div>
  <div class="metric"><strong>0.386</strong><span>contextual v1 RMSE</span></div>
  <div class="metric"><strong>0.439</strong><span>Statcast RMSE on the same rows</span></div>
</div>
On the frozen 2025 comparison, contextual v1 has lower RMSE and MAE than Statcast. The paired RMSE difference is −0.0532, with a 95% bootstrap interval from −0.0551 to −0.0514. That is strong evidence of better **point prediction on this evaluation set**—not a blanket claim that the model is better in every respect.

The model does not pass its combined promotion rule. Its mean residual is −0.0189 and its mean absolute decile calibration gap is 0.0189, compared with 0.0103 for Statcast. In plain language: the predictions are closer on average, but their level and calibration still need work.

<figure class="result-figure wide">
  <img src="{{ '/assets/images/xwoba-annual-residual-calibration.png' | relative_url }}" alt="Line chart of annual mean residuals for contextual xwOBA and Statcast from 2019 through 2025. Contextual xwOBA remains mostly below zero, while Statcast remains above zero in most seasons." width="1440" height="810" loading="lazy">
  <figcaption>Annual residual calibration from the aggregate v1 release. Values nearer zero indicate better calibration. This figure is included because it exposes the model’s central limitation rather than hiding it behind the point-prediction gain.</figcaption>
</figure>

## A gated replacement study

A v2 replacement study is implemented behind frozen promotion criteria. It should not be described as the public winner unless it passes those criteria on the held-out evaluation. Until then, v1 remains the evaluated reference and v2 remains a candidate under study.

<div class="notice">
  <p><strong>Release boundary.</strong> The canonical GitHub repository and Quarto methods/results site will be linked here once they are public. They—not this overview—will be the source of truth for the model card, reproducible code, complete diagnostics, release label, and aggregate evidence.</p>
</div>
