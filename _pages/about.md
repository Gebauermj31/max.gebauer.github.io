---
title: Maximilian J. Gebauer
layout: home
permalink: /
description: Interdisciplinary researcher in philosophy of science, statistics, and data science at the University of Pennsylvania.
---

<section class="hero" aria-labelledby="hero-title">
  <div class="hero__inner">
    <div class="hero__copy">
      <p class="eyebrow">University of Pennsylvania · Philadelphia</p>
      <h1 id="hero-title">Interdisciplinary researcher in philosophy of science, statistics, and data science.</h1>
      <p class="hero__lede">I study how statistical methods encode judgments about evidence, uncertainty, and consequence—and I build reproducible models for difficult applied problems in sports, climate, and health.</p>
      <div class="hero__actions">
        <a class="button" href="{{ '/research/' | relative_url }}">Explore research</a>
        <div class="hero__links" aria-label="Additional links">
          <a class="text-link" href="{{ '/cv/' | relative_url }}">CV</a>
          <a class="text-link" href="mailto:{{ site.email }}">Penn email</a>
          <a class="text-link" href="https://github.com/{{ site.github_username }}">GitHub ↗</a>
        </div>
      </div>
    </div>
    <div class="hero__portrait">
      <picture>
        <source srcset="{{ '/assets/images/maximilian-gebauer-headshot-960.webp' | relative_url }}" type="image/webp">
        <img src="{{ '/assets/images/maximilian-gebauer-headshot-960.jpg' | relative_url }}" alt="Portrait of Maximilian Gebauer" width="960" height="1052" fetchpriority="high">
      </picture>
      <span class="portrait-note">Maximilian J. Gebauer · Philadelphia</span>
    </div>
  </div>
</section>
<section class="home-section" aria-labelledby="research-heading">
  <div class="section-shell">
    <div class="section-heading">
      <div>
        <p class="eyebrow">Research program</p>
        <h2 id="research-heading">Ideas, methods, applications.</h2>
      </div>
      <p>My work moves between foundational questions about scientific inference and the practical design of statistical models. Each part informs the others.</p>
    </div>
    <div class="pillar-grid">
      <article class="pillar">
        <span class="pillar__number">01</span>
        <h3>Philosophy of science &amp; Bayesianism</h3>
        <p>How values, modeling choices, and decision contexts shape scientific inference—even within formally Bayesian practice.</p>
      </article>
      <article class="pillar">
        <span class="pillar__number">02</span>
        <h3>Statistical methodology</h3>
        <p>Methods for estimation, validation, and uncertainty that are technically rigorous and honest about their operating conditions.</p>
      </article>
      <article class="pillar">
        <span class="pillar__number">03</span>
        <h3>Applied modeling</h3>
        <p>Reproducible work in sports, climate, and health where measurement, prediction, and decision-making meet.</p>
      </article>
    </div>
  </div>
</section>

<section class="home-section home-section--tint" aria-labelledby="projects-heading">
  <div class="section-shell">
    <div class="section-heading">
      <div>
        <p class="eyebrow">Flagship projects</p>
        <h2 id="projects-heading">Three questions in motion.</h2>
      </div>
      <p>Each case study connects a substantive problem to careful model design, validation, and communication.</p>
    </div>
    <div class="project-grid">
      {% assign featured_projects = site.projects | sort: "featured_order" %}
      {% for project in featured_projects %}
      <article class="project-card">
        <div class="project-card__art"><img src="{{ project.card_image | relative_url }}" alt="{{ project.card_alt }}" width="640" height="400"{% unless forloop.first %} loading="lazy"{% endunless %}></div>
        <div class="project-card__body">
          <span class="meta-label">{{ project.status }}</span>
          <h3>{{ project.title }}</h3>
          <p>{{ project.summary }}</p>
          <a class="text-link" href="{{ project.url | relative_url }}">Read the case study →</a>
        </div>
      </article>
      {% endfor %}
    </div>
  </div>
</section>

<section class="home-section">
  <div class="section-shell">
    <div class="home-callout">
      <div>
        <p class="eyebrow">Current work</p>
        <h2>Research grounded in uncertainty.</h2>
        <p>I am a PhD candidate in Philosophy and earned an M.A. in Statistics &amp; Data Science at Penn. I welcome conversations across disciplinary boundaries.</p>
      </div>
      <a class="button" href="mailto:{{ site.email }}">Start a conversation</a>
    </div>
  </div>
</section>
