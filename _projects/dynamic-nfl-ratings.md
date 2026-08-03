---
title: Dynamic Ratings for NFL Performance
subtitle: Modeling pass-rush and pass-protection performance over time
summary: A time-aware rating framework for measuring changing player performance while respecting the matchup structure of the game.
status: Confidential applied research
featured_order: 2
methods:
  - Dynamic ratings
  - Hierarchical modeling
  - Time-based validation
  - Uncertainty quantification
card_image: /assets/images/project-nfl.svg
card_alt: Abstract diagram of opposing football players connected through a sequence of time-indexed matchups
hero_image: /assets/images/nfl-rating-workflow.svg
hero_alt: Conceptual diagram showing repeated pass-rush and pass-protection matchups updating latent performance ratings over time
hero_caption: Conceptual diagram only. It does not reproduce client data, protected results, code, or paper figures.
section: Projects
---

## The question

Pass rush and pass protection are relational: an observed result reflects both players in the matchup, the surrounding context, and when the play occurred. A useful rating therefore needs to separate opposing contributions while allowing ability to change over a season and across seasons.

## Method

The project develops a dynamic rating scheme built around repeated pass-rusher and pass-protector matchups. Rather than treating every observation as exchangeable, it carries information forward through time, updates estimates as new evidence arrives, and represents uncertainty when a player has limited or stale observations.

Validation follows the direction in which the rating would actually be used: models learn from the past and are assessed on later play. Comparisons focus on predictive performance, stability, and whether the ratings behave sensibly under realistic changes in sample size and opponent mix.

## Contribution and boundaries

The central contribution is methodological: a framework for estimating evolving, opponent-adjusted performance rather than a public leaderboard or a one-number verdict on individual players.

This overview intentionally omits the client identity, protected findings, code, proprietary inputs, and real paper figures. The visual above is an original conceptual explanation of the modeling structure. Nothing on this page should be read as reporting an unpublished competitive result.
