---
title: Maximilian (Max) J. Gebauer
layout: home
permalink: /
description: Transdisciplinary researcher in philosophy of science, statistics, and sports analytics at the University of Pennsylvania.
---

<section class="hero" aria-labelledby="hero-title">
  <div class="hero__inner">
    <div class="hero__copy">
      <p class="eyebrow">PhD candidate in Philosophy · University of Pennsylvania</p>
      <h1 id="hero-title">Researcher in philosophy of science, statistics, and sports analytics.</h1>
      <p class="hero__lede">I study how values, institutions, and modeling choices shape scientific inference—and build statistical models for concrete problems in sports, public health, and scientific practice.</p>
      <div class="hero__actions">
        <a class="button" href="{{ '/research/' | relative_url }}">Explore research</a>
        <div class="hero__links" aria-label="Additional links">
          <a class="text-link" href="{{ '/cv/' | relative_url }}">CV</a>
          <a class="text-link" href="{{ site.penn_profile_url }}">Penn profile ↗</a>
          <a class="text-link" href="mailto:{{ site.email }}">Penn email</a>
          <a class="text-link" href="{{ site.github_url }}">GitHub ↗</a>
          <a class="text-link" href="{{ site.linkedin_url }}">LinkedIn ↗</a>
        </div>
      </div>
    </div>
    <div class="hero__media">
      <picture>
        <source
          type="image/webp"
          srcset="{{ '/assets/images/photos/st-john-silk-cotton-tree-2026-800.webp' | relative_url }} 800w, {{ '/assets/images/photos/st-john-silk-cotton-tree-2026-1600.webp' | relative_url }} 1600w"
          sizes="(max-width: 900px) 100vw, 42vw">
        <img
          src="{{ '/assets/images/photos/st-john-silk-cotton-tree-2026-800.jpg' | relative_url }}"
          srcset="{{ '/assets/images/photos/st-john-silk-cotton-tree-2026-800.jpg' | relative_url }} 800w, {{ '/assets/images/photos/st-john-silk-cotton-tree-2026-1600.jpg' | relative_url }} 1600w"
          sizes="(max-width: 900px) 100vw, 42vw"
          alt="Max Gebauer standing beside the broad, buttressed trunk of a silk-cotton tree in a tropical forest"
          width="1600"
          height="1200"
          fetchpriority="high"
          decoding="async">
      </picture>
      <span class="hero__photo-note">Silk-cotton tree · St. John, U.S. Virgin Islands · 2026</span>
    </div>
  </div>
</section>
<section class="home-section" aria-labelledby="research-heading">
  <div class="section-shell">
    <div class="section-heading section-heading--solo">
      <h2 id="research-heading">Research Program</h2>
    </div>
    <div class="pillar-grid">
      <article class="pillar">
        <span class="pillar__number">01</span>
        <h3>Values, Bayesianism &amp; scientific practice</h3>
        <p>Whether applied Bayesian inference can avoid inductive risk, where values enter scientific practice, and whether Bayesianism can remain value-free in the relevant sense.</p>
      </article>
      <article class="pillar">
        <span class="pillar__number">02</span>
        <h3>Scientific integrity &amp; institutional design</h3>
        <p>How institutions police plagiarism, p-hacking, and other academic misconduct—and how enforcement can protect inquiry without allowing accusations to be weaponized against scholars because of identity or political viewpoint.</p>
      </article>
      <article class="pillar">
        <span class="pillar__number">03</span>
        <h3>Applied sports &amp; health modeling</h3>
        <p>Matchup-adjusted ratings, expected-outcome models, and public-health research where prediction, interpretation, and decision-making must work together.</p>
      </article>
    </div>
  </div>
</section>

<section class="home-section home-section--tint" aria-labelledby="projects-heading">
  <div class="section-shell">
    <div class="section-heading section-heading--solo">
      <h2 id="projects-heading">Flagship Statistics &amp; Analytics Projects</h2>
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

<section class="home-section home-section--photos" aria-labelledby="photos-heading">
  <div class="section-shell">
    <div class="section-heading section-heading--solo">
      <div>
        <p class="eyebrow">Places and people</p>
        <h2 id="photos-heading">A wider frame.</h2>
      </div>
    </div>
    <p class="personal-note">Away from the desk, I follow the NFL, college football, and baseball; cook at home and have explored more than 200 Philadelphia restaurants; track prediction markets; and bring an almost comically experimental mindset to blind tastings from my American whiskey collection.</p>
    <div class="photo-grid">
      {% for photo in site.data.photos %}
      <figure class="photo-card photo-card--{{ photo.layout }}">
        <div class="photo-card__frame">
          <picture>
            <source
              type="image/webp"
              srcset="{{ photo.image | append: '-800.webp' | relative_url }} 800w, {{ photo.image | append: '-1600.webp' | relative_url }} 1600w"
              sizes="{% if photo.layout == 'wide' %}(max-width: 720px) calc(100vw - 2.5rem), (max-width: 900px) calc(100vw - 2.5rem), 800px{% else %}(max-width: 720px) calc(100vw - 2.5rem), 400px{% endif %}">
            <img
              src="{{ photo.image | append: '-800.jpg' | relative_url }}"
              srcset="{{ photo.image | append: '-800.jpg' | relative_url }} 800w, {{ photo.image | append: '-1600.jpg' | relative_url }} 1600w"
              sizes="{% if photo.layout == 'wide' %}(max-width: 720px) calc(100vw - 2.5rem), (max-width: 900px) calc(100vw - 2.5rem), 800px{% else %}(max-width: 720px) calc(100vw - 2.5rem), 400px{% endif %}"
              alt="{{ photo.alt }}"
              width="{{ photo.width }}"
              height="{{ photo.height }}"
              loading="lazy"
              decoding="async">
          </picture>
        </div>
        <figcaption>{{ photo.caption }} <span class="photo-card__credit">{{ photo.credit }}</span></figcaption>
      </figure>
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
        <p>I am a PhD candidate in Philosophy and earned an M.A. in Statistics &amp; Data Science at Penn. I welcome conversations that cross disciplinary boundaries while staying grounded in concrete problems.</p>
      </div>
      <a class="button" href="mailto:{{ site.email }}">Start a conversation</a>
    </div>
  </div>
</section>
