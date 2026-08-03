---
title: Projects
permalink: /projects/
section: Projects
eyebrow: Reproducible applied research
lede: These projects show how I translate conceptual questions into statistical designs—defining the target carefully, separating development from evaluation, and communicating both gains and limitations.
---

<div class="project-grid">
  {% assign ordered_projects = site.projects | sort: "featured_order" %}
  {% for project in ordered_projects %}
  <article class="project-card">
    <div class="project-card__art"><img src="{{ project.card_image | relative_url }}" alt="{{ project.card_alt }}" width="640" height="400" loading="lazy"></div>
    <div class="project-card__body">
      <span class="meta-label">{{ project.status }}</span>
      <h3>{{ project.title }}</h3>
      <p><strong>{{ project.subtitle }}</strong></p>
      <p>{{ project.summary }}</p>
      <a class="text-link" href="{{ project.url | relative_url }}">Read the case study →</a>
    </div>
  </article>
  {% endfor %}
</div>
