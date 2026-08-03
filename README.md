# Maximilian J. Gebauer — academic website

This repository contains the source for Maximilian J. Gebauer’s academic website. It is a deliberately small Jekyll site: five primary pages, three project case studies, one publication entry, and a single downloadable CV.

The site is designed for GitHub Pages compatibility, but the production `url` remains unset until the domain decision. Deployment is also intentionally blocked until the canonical contextual-xwOBA GitHub repository and Quarto results site are public.

## Supported local workflow

Use Ruby 3.3 (the exact tested version is recorded in `.ruby-version`) and Bundler.

```bash
bundle config set --local path vendor/bundle
bundle install
bundle exec jekyll serve --livereload
```

Open `http://127.0.0.1:4000`. For the same validation used in continuous integration:

```bash
bundle exec jekyll build --strict_front_matter
bundle exec ruby scripts/check_site.rb
```

## Content and release process

- Edit general pages in `_pages/`.
- Edit project case studies in `_projects/`.
- Edit publication entries in `_publications/`.
- Follow the front-matter examples in [`CONTENT_GUIDE.md`](CONTENT_GUIDE.md).
- Keep `/files/maximilian-gebauer-cv.pdf` synchronized with the accessible HTML CV.
- Do not add raw research data, row-level predictions, fitted models, confidential client material, or unapproved figures.

Before a public deployment, add the xwOBA canonical repository and Quarto URLs to `_projects/contextual-xwoba.md`, set `RELEASE_READY=1`, and run the checks. Update the release label, summary, aggregate figure, and both source links together.

## Design system

The site uses a custom full-width layout, an accessible MG monogram, a charcoal/bright-blue palette, light and dark themes, and reduced-motion support. Source Sans 3 and Source Code Pro are preferred with robust local fallbacks. There is no analytics, comment system, blog, or interactive chart payload.

The original Academic Pages template is MIT-licensed; see [`LICENSE`](LICENSE).
