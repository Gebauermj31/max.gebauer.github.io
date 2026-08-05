---
title: Sitemap
permalink: /sitemap/
eyebrow: Utility
sitemap: false
---

## Main pages

- [Home]({{ '/' | relative_url }})
- [Research]({{ '/research/' | relative_url }})
- [Teaching]({{ '/teaching/' | relative_url }})
- [Statistics Projects]({{ '/projects/' | relative_url }})
- [CV]({{ '/cv/' | relative_url }})

## Statistics project case studies

{% assign ordered_projects = site.projects | sort: "featured_order" %}
{% for project in ordered_projects %}
- [{{ project.title }}]({{ project.url | relative_url }})
{% endfor %}

## Publications

{% for publication in site.publications %}
- [{{ publication.title }}]({{ publication.url | relative_url }})
{% endfor %}

An [XML sitemap]({{ '/sitemap.xml' | relative_url }}) is available for search engines.
