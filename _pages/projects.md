---
title: Statistics Projects
permalink: /projects/
section: Statistics Projects
eyebrow: Reproducible applied research
lede: Below are a selection of projects highlighting different areas of my statistics and analytics research across the NFL, MLB, and public health.
---

<h2 id="project-case-studies" class="sr-only">Project case studies</h2>
<div class="project-grid" aria-labelledby="project-case-studies">
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
