---
title: Sparse Controls in Spatial Epidemiology
subtitle: "Sparse Control Selection for Spatial Epidemiological Data: Double LASSO and County COVID-19 Mortality"
summary: An M.A. thesis on high-dimensional confounding, unstable county mortality rates, and residual spatial dependence.
status: M.A. thesis · 2026
featured_order: 3
methods:
  - Double-selection LASSO
  - Negative-binomial GAM
  - Markov random field smoothing
  - Spatial residual diagnostics
card_image: /assets/images/project-spatial.svg
card_alt: Abstract county map with highlighted spatial neighbors and a sparse set of selected variables
hero_image: /assets/images/spatial-workflow.svg
hero_alt: Conceptual workflow from county-level candidate controls through double-selection LASSO and spatial adjustment to validation and interpretation
hero_caption: Original conceptual workflow based on the thesis design. The approved empirical maps and distributions below come from the M.A. thesis.
document_url: /files/maximilian-gebauer-statistics-thesis.pdf
document_label: Download the thesis PDF
section: Projects
---

## The problem

County-level epidemiological studies often begin with many plausible social, demographic, and health-system controls. Including all of them can make estimates unstable; choosing them informally can omit important confounding structure. Rare-event rates can also be volatile in small populations, while neighboring counties can share regional conditions and disease dynamics.

My Statistics &amp; Data Science thesis studies those problems using cumulative COVID-19 deaths through May 2022, 127 candidate county characteristics, and approximately 3,096 counties. Its focal question is whether county-level political ideology—proxied by Republican vote share—remains associated with mortality after demanding adjustment. The design is explicitly ecological and does not support individual-level causal claims.

## Descriptive patterns

The raw county data already show why a spatial model is necessary. Both the outcome and focal exposure cluster geographically, with neighboring counties often taking similar values. These figures describe the analytic sample before the high-dimensional and spatial adjustments discussed below; they do not establish a causal relationship.

<figure class="result-figure">
  <img src="{{ '/assets/images/thesis-covid-mortality-map.png' | relative_url }}" alt="County choropleth map of the contiguous United States shaded from pale to dark red by adjusted cumulative COVID-19 deaths per 100,000 residents." width="2000" height="795" loading="lazy" decoding="async">
  <figcaption><strong>County-level COVID-19 mortality.</strong> Adjusted cumulative deaths per 100,000 through May 2022 across the contiguous United States. Visible regional clustering motivates the adjacency-based spatial term used in the final model.</figcaption>
</figure>

<figure class="result-figure result-figure--distribution">
  <img src="{{ '/assets/images/thesis-covid-mortality-distribution.png' | relative_url }}" alt="Histogram of adjusted log COVID-19 mortality rates per 100,000 across counties, concentrated in the upper-middle portion of the displayed range with thinner tails." width="1600" height="1107" loading="lazy" decoding="async">
  <figcaption><strong>Mortality distribution.</strong> The marginal distribution of the adjusted log COVID-19 mortality rate across the 3,096-county analytic sample. This transformed rate is used for descriptive exploration; the final analysis models death counts directly with a population offset.</figcaption>
</figure>

<figure class="result-figure">
  <img src="{{ '/assets/images/thesis-republican-vote-map.png' | relative_url }}" alt="County choropleth map of the contiguous United States shaded blue to red by Republican presidential vote share, with higher shares shown in dark red." width="2000" height="923" loading="lazy" decoding="async">
  <figcaption><strong>County-level Republican vote share.</strong> The focal exposure also exhibits pronounced regional structure. Republican vote share is used as a county-level ecological proxy, not as an individual characteristic or a stand-alone causal mechanism.</figcaption>
</figure>

<figure class="result-figure result-figure--distribution">
  <img src="{{ '/assets/images/thesis-republican-vote-distribution.png' | relative_url }}" alt="Histogram of county Republican presidential vote share, with most counties concentrated between roughly 50 and 80 percent and thinner tails at lower and higher values." width="1600" height="1107" loading="lazy" decoding="async">
  <figcaption><strong>Partisanship distribution.</strong> Republican vote share ranges from 5.4% to 96.2% in the analytic sample, with a median of 68.4% and mean of 65.1%. These are unadjusted descriptive values; the study's substantive estimate comes from the full selected-control and spatial model.</figcaption>
</figure>

## Method

Post-double-selection LASSO uses two related selection steps: one identifies variables associated with the exposure of interest, and the other identifies variables associated with the outcome. The union of those controls is then carried into the estimating model, protecting against variables that predict either side of the relationship. The thesis selects a 48-feature union spanning demographics, vaccination, comorbidities, socioeconomic conditions, healthcare capacity, employment, and geography.

The final stage models death counts directly with a negative-binomial generalized additive model, a population offset, state fixed effects, and a Markov random field smooth based on county adjacency. This combines count-based inference with partial pooling among neighboring counties. Simulation-based residual checks assess dispersion and outliers, and Moran's I evaluates whether spatial dependence remains after adjustment.

## Findings

In the preferred model, a ten-percentage-point increase in county Republican vote share is associated with approximately 13% higher expected COVID-19 mortality, conditional on the selected controls, state effects, and spatial smooth. The non-spatial specification leaves pronounced residual autocorrelation; after adding the adjacency-based term, the residual Moran test is no longer statistically significant. Simulation-based checks likewise find no evidence of remaining over- or under-dispersion or excess outliers.

That result is a robust county-level association, not an estimate of the causal effect of individual political identity. Republican vote share is an ecological proxy for correlated policies, behaviors, institutions, information environments, and demographic conditions, including factors that the available controls may not fully capture.

## Limitations and contribution

The cumulative outcome compresses differences across pandemic waves, unobserved confounding remains possible, and the spatial smooth captures residual geography without identifying its mechanism. The hybrid workflow also uses post-double-selection as a principled screening device before a negative-binomial spatial model; it should not be read as an exact semiparametric identification result.

The contribution is therefore both substantive and methodological: the association survives a much richer adjustment strategy, while the analysis demonstrates why reproducible control selection, count-aware modeling, and explicit spatial diagnostics belong together in ecological health research. This case study is a concise overview; the <a href="{{ '/files/maximilian-gebauer-statistics-thesis.pdf' | relative_url }}">full M.A. thesis is available as a PDF</a>.
