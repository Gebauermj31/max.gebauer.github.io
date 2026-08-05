---
title: FAIR xwOBA
subtitle: A baseball model for expected contact value · Field- and Atmosphere-Informed Realized-contact xwOBA
summary: A public, player-trait-free baseball model that predicts the value of a batted ball, validates it across rolling held-out MLB seasons, and uses residuals to study Sprint Speed.
status: Public release · rolling development evidence
featured_order: 1
methods:
  - Five-class XGBoost
  - Rolling held-out evaluation
  - Probability and scalar calibration
  - Post-score residual analysis
card_image: /assets/images/project-xwoba.svg
card_alt: Abstract baseball field with batted-ball trajectories and a calibration curve representing FAIR xwOBA
hero_image: /assets/images/xwoba-workflow.svg
hero_alt: Baseball workflow in which batted-ball, park, weather, and defensive features enter an XGBoost classifier; five outcome probabilities combine into scalar xwOBA; both outputs are calibrated and evaluated, while scalar predictions are residualized for a post-score Sprint Speed analysis
hero_caption: End-to-end FAIR xwOBA workflow. Blue shows player-trait-free prediction and evaluation; gold shows the post-score residual analysis, where Sprint Speed enters only after predictions are fixed.
hero_wide: true
hero_width: 1200
hero_height: 800
release_label: FAIR xwOBA v0.1.0
release_date: 2026-08-05
project_url: https://max-gebauer.github.io/fair-xwoba/
canonical_label: Read the published article
repository_url: https://github.com/Max-Gebauer/fair-xwoba
methods_url: https://max-gebauer.github.io/fair-xwoba/methods.html
reproduce_url: https://max-gebauer.github.io/fair-xwoba/reproduce.html
permalink: /projects/fair-xwoba/
redirect_from:
  - /projects/contextual-xwoba/
section: Statistics Projects
---

## The question

In baseball, weighted on-base average (wOBA) summarizes offensive value by assigning more credit to outcomes such as doubles and home runs than to singles. An expected wOBA model—xwOBA—asks what a batted ball was likely to be worth based on how it was hit and the context around it, before focusing on the outcome that happened to occur.

FAIR xwOBA asks two connected questions: can a public model predict that contact value more accurately and calibrate it more consistently by using richer physical and game context, and what repeatable player value remains in the residuals after doing so?

The name stands for **Field- and Atmosphere-Informed Realized-contact xwOBA**. “Realized-contact” is deliberate: the model estimates what a batted ball was worth in the physical, environmental, and pre-pitch defensive context in which it occurred rather than claiming to isolate a context-free essence of contact quality.

## Public model contract

FAIR predicts five contact outcomes—out, single, double, triple, and home run—using a regularized XGBoost model. Its inputs cover launch speed and angle, spray coordinates, a hang-time proxy, park, temperature, field-relative wind, roof status, rule era, and pre-pitch infield and outfield alignment. Separate probability and scalar calibration stages protect both the outcome distribution and the xwOBA scale.

The predictor cannot use player identity, name, Sprint Speed, age, height, weight, handedness, position, team, or fielder identity. Those fields are joined only after predictions have been written and hashed. Pre-pitch alignment is a contextual input, but it can indirectly encode how defenses respond to known hitters; the release discloses that limitation rather than describing the model as purely intrinsic.

## Rolling evaluation

The public evidence uses six rolling held-out development seasons from 2019 through 2024. For each target season, training stops before the preceding season; disjoint whole-game groups from the prior season are used for tuning and probability calibration, and prior out-of-fold predictions support scalar calibration. Only after those stages are fixed is the next season scored.

This approximates repeated historical deployment and avoids a random split that would blur the direction of time. It is still **development evidence**, not the final untouched-season confirmation. The release design reserves 2026 for that later role.

## What the release shows

<div class="metric-row wide" aria-label="Selected rolling development metrics">
  <div class="metric"><strong>2019–2024</strong><span>six rolling held-out seasons</span></div>
  <div class="metric"><strong>0.3892</strong><span>FAIR equal-season RMSE</span></div>
  <div class="metric"><strong>0.4376</strong><span>Statcast equal-season RMSE</span></div>
</div>
Across the six rolling development seasons, FAIR has lower RMSE, five-class log loss, Brier score, absolute annual bias, and mean absolute decile calibration gap than the declared Statcast comparators in every season. Equal-season averages are 0.3892 versus 0.4376 for RMSE, 0.5053 versus 0.7140 for log loss, 0.2920 versus 0.3846 for Brier score, 0.0059 versus 0.0139 for absolute annual bias, and 0.0099 versus 0.0151 for the decile calibration gap.

This is not a strictly like-for-like contest: FAIR uses a richer contextual feature set than Statcast publicly describes, while Statcast's full model is proprietary. The result supports a qualified claim about accuracy and calibration across this rolling development evaluation, not universal superiority or final confirmation.

<figure class="result-figure wide">
  <a href="https://max-gebauer.github.io/fair-xwoba/"><img src="{{ '/assets/images/fair-xwoba-performance.png' | relative_url }}" alt="Five line-chart panels compare FAIR xwOBA with Statcast from 2019 through 2024 on RMSE, log loss, Brier score, absolute annual bias, and decile calibration gap. FAIR is lower in every season and panel." width="2016" height="1420" loading="lazy"></a>
  <figcaption>Rolling held-out development evaluation, 2019–2024. Lower is better throughout. Reused from <a href="https://max-gebauer.github.io/fair-xwoba/">FAIR xwOBA v0.1.0</a> under <a href="https://creativecommons.org/licenses/by/4.0/">CC BY 4.0</a>.</figcaption>
</figure>

## What the residuals reveal

After scoring, the release asks whether deliberately excluded player traits organize the remaining error. One Sprint Speed standard deviation—1.39 feet per second—is associated with 0.799 run-equivalent units per 100 matched balls in play in FAIR's residuals, with a whole-player bootstrap interval from 0.661 to 0.941. The signal is strongest on weak ground contact and is led by the margin between outs and singles.

This is a descriptive, post-score association rather than a causal estimate. It is not stolen-base value, WAR, or a claim that Sprint Speed should enter FAIR's predictor. Keeping speed outside the model is what makes this residual analysis possible.

<div class="notice">
  <p><strong>Release boundary.</strong> The <a href="https://max-gebauer.github.io/fair-xwoba/">published article</a>, <a href="https://max-gebauer.github.io/fair-xwoba/methods.html">technical methods</a>, <a href="https://max-gebauer.github.io/fair-xwoba/reproduce.html">reproduction page</a>, and <a href="https://github.com/Max-Gebauer/fair-xwoba">GitHub repository</a> are the source of truth for the model card, code, complete diagnostics, release files, and evidence hashes.</p>
</div>
