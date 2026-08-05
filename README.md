# Maximilian (Max) J. Gebauer — academic website

This repository contains the source for Maximilian (Max) J. Gebauer’s academic website. It is a deliberately small Jekyll site: five primary pages, three project case studies, one publication entry, a downloadable CV, and an approved M.A. thesis PDF.

The site is designed for and will use the free GitHub Pages address at `https://max-gebauer.github.io`. No custom domain or `CNAME` configuration is planned for version 1. Deployment remains a deliberate final-review action; the canonical FAIR xwOBA repository and Quarto article are public and wired into the project page.

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
- Keep `/files/maximilian-gebauer-statistics-thesis.pdf` synchronized with the approved public thesis version.
- Do not add raw research data, row-level predictions, fitted models, confidential client material, or unapproved figures.

After changing the CV, rebuild its privacy-reviewed PDF with `python3 scripts/build_cv_pdf.py` (ReportLab required), then review the rendered pages before committing it.

Before a public deployment, set `RELEASE_READY=1` and run the checks. Update the FAIR xwOBA release label, evidence status, summary, aggregate figure, and source links together whenever its canonical release changes.

## Design system

The site uses a custom full-width layout, an accessible MG monogram, a charcoal/bright-blue palette, light and dark themes, and reduced-motion support. Source Sans 3 and Source Code Pro are preferred with robust local fallbacks. There is no analytics, comment system, blog, or interactive chart payload.

The original Academic Pages template is MIT-licensed; see [`LICENSE`](LICENSE).
