#!/usr/bin/env ruby
# frozen_string_literal: true

require "nokogiri"
require "date"
require "pathname"
require "uri"
require "yaml"

ROOT = Pathname.new(__dir__).join("..").expand_path
SITE = ROOT.join("_site")
errors = []

abort "_site does not exist; run Jekyll build first" unless SITE.directory?

html_files = SITE.glob("**/*.html")
errors << "No generated HTML files found" if html_files.empty?
external_links = []

forbidden = {
  "academicpages" => "template repository text",
  "yourorcid" => "placeholder ORCID",
  "john snow" => "template profile text",
  "lorem ipsum" => "placeholder copy",
  "agentic ai" => "excluded skill claim",
  "249 s. 36th" => "private street address",
  "434) 390-1307" => "private phone number",
  "title redacted" => "redacted publication entry"
}

resolve_internal = lambda do |href, source|
  value = href.to_s.split("#", 2).first.split("?", 2).first
  next nil if value.empty? || value.start_with?("mailto:", "tel:", "javascript:", "data:")
  begin
    uri = URI.parse(value)
    next nil if uri.scheme || uri.host
  rescue URI::InvalidURIError
    errors << "#{source.relative_path_from(SITE)}: invalid URL #{href.inspect}"
    next nil
  end

  clean = URI.decode_www_form_component(value)
  target = clean.start_with?("/") ? SITE.join(clean.delete_prefix("/")) : source.dirname.join(clean)
  target = target.cleanpath
  candidates = [target]
  candidates << target.join("index.html") if clean.end_with?("/") || target.directory?
  candidates << Pathname.new("#{target}.html") unless target.extname != ""
  candidates << target.join("index.html") unless clean.end_with?("/")
  candidates.find(&:file?)
end

html_files.each do |file|
  html = file.read
  lower = html.downcase
  forbidden.each { |needle, label| errors << "#{file.relative_path_from(SITE)}: contains #{label}" if lower.include?(needle) }

  document = Nokogiri::HTML5(html)
  h1_count = document.css("h1").length
  errors << "#{file.relative_path_from(SITE)}: expected one h1, found #{h1_count}" unless h1_count == 1

  heading_levels = document.css("h1, h2, h3, h4, h5, h6").map { |node| node.name.delete_prefix("h").to_i }
  heading_levels.each_cons(2) do |previous, current|
    errors << "#{file.relative_path_from(SITE)}: heading hierarchy jumps from h#{previous} to h#{current}" if current > previous + 1
  end

  ids = document.css("[id]").map { |node| node["id"] }
  duplicates = ids.tally.select { |_id, count| count > 1 }.keys
  errors << "#{file.relative_path_from(SITE)}: duplicate ids #{duplicates.join(', ')}" unless duplicates.empty?

  document.css("a[href]").each do |node|
    href = node["href"]
    if href.start_with?("http://", "https://")
      external_links << href
      errors << "#{file.relative_path_from(SITE)}: external link must use HTTPS: #{href}" unless href.start_with?("https://")
      next
    end
    next if href.start_with?("mailto:", "tel:", "#")
    errors << "#{file.relative_path_from(SITE)}: broken internal link #{href}" unless resolve_internal.call(href, file)
  end

  document.css("a, button").each do |node|
    accessible_name = [node["aria-label"], node.text, *node.css("img[alt]").map { |image| image["alt"] }]
      .compact.join(" ").strip
    errors << "#{file.relative_path_from(SITE)}: #{node.name} lacks an accessible name" if accessible_name.empty?
  end

  canonical_links = document.css('link[rel="canonical"]')
  errors << "#{file.relative_path_from(SITE)}: expected one canonical link, found #{canonical_links.length}" unless canonical_links.length == 1
  if canonical_links.one? && !canonical_links.first["href"].to_s.start_with?("https://max-gebauer.github.io/")
    errors << "#{file.relative_path_from(SITE)}: canonical URL is outside the configured site"
  end

  redirect_page = document.at_css('meta[http-equiv="refresh"]')
  unless redirect_page
    errors << "#{file.relative_path_from(SITE)}: missing main content target" unless document.at_css("main#main-content")
    errors << "#{file.relative_path_from(SITE)}: missing skip link" unless document.at_css('a.skip-link[href="#main-content"]')
  end

  document.css("img[src]").each do |node|
    errors << "#{file.relative_path_from(SITE)}: image missing alt attribute" if node["alt"].nil?
    src = node["src"]
    next if src.start_with?("http://", "https://", "data:")
    errors << "#{file.relative_path_from(SITE)}: missing image #{src}" unless resolve_internal.call(src, file)
  end

  document.css("[srcset]").each do |node|
    node["srcset"].split(",").each do |candidate|
      src = candidate.strip.split(/\s+/, 2).first
      next if src.start_with?("http://", "https://", "data:")
      errors << "#{file.relative_path_from(SITE)}: missing responsive image #{src}" unless resolve_internal.call(src, file)
    end
  end
end

permalinks = ROOT.glob("{_pages,_projects,_publications}/**/*.{md,html}").filter_map do |source|
  content = source.read
  next unless content.start_with?("---\n")
  front_matter = YAML.safe_load(content.split("---", 3)[1], permitted_classes: [Date], aliases: true) || {}
  next unless front_matter["permalink"]
  [front_matter["permalink"], source.relative_path_from(ROOT).to_s]
end
duplicate_permalinks = permalinks.group_by(&:first).select { |_path, entries| entries.length > 1 }
duplicate_permalinks.each do |path, entries|
  errors << "Duplicate permalink #{path}: #{entries.map(&:last).join(', ')}"
end

external_links.uniq.each do |href|
  begin
    uri = URI.parse(href)
    errors << "External link lacks a host: #{href}" if uri.host.to_s.empty?
  rescue URI::InvalidURIError
    errors << "Invalid external link: #{href}"
  end
end

pdf = SITE.join("files/maximilian-gebauer-cv.pdf")
if !pdf.file? || pdf.size < 5_000 || pdf.binread(4) != "%PDF"
  errors << "CV PDF is missing or invalid"
end

thesis_pdf = SITE.join("files/maximilian-gebauer-statistics-thesis.pdf")
if !thesis_pdf.file? || thesis_pdf.size < 100_000 || thesis_pdf.binread(4) != "%PDF"
  errors << "Statistics thesis PDF is missing or invalid"
end

config_source = ROOT.join("_config.yml").read
{
  "https://github.com/Max-Gebauer" => "GitHub profile",
  "https://www.linkedin.com/in/maximilian-gebauer-6b2a33365/" => "LinkedIn profile",
  "https://philosophy.sas.upenn.edu/people/maximilian-gebauer" => "Penn profile"
}.each do |expected, label|
  errors << "Site configuration lacks canonical #{label}: #{expected}" unless config_source.include?(expected)
end

project_source = ROOT.join("_projects/contextual-xwoba.md").read
if ENV["RELEASE_READY"] == "1"
  errors << "Release-ready xwOBA page lacks project_url" unless project_source.match?(/^project_url:\s+https:\/\//)
  errors << "Release-ready xwOBA page lacks repository_url" unless project_source.match?(/^repository_url:\s+https:\/\//)
  {
    "FAIR xwOBA v0.1.0" => "release label",
    "rolling development evidence" => "evidence status",
    "https://max-gebauer.github.io/fair-xwoba/" => "canonical FAIR article",
    "https://github.com/Max-Gebauer/fair-xwoba" => "FAIR repository",
    "fair-xwoba-performance.png" => "approved aggregate figure",
    "hero_wide: true" => "expanded workflow treatment"
  }.each do |expected, label|
    errors << "Release-ready xwOBA page lacks synchronized #{label}: #{expected}" unless project_source.include?(expected)
  end

  workflow_source = ROOT.join("assets/images/xwoba-workflow.svg").read
  {
    "XGBoost classifier" => "classifier stage",
    "Five outcome probabilities" => "probability output",
    "Scalar xwOBA" => "scalar output",
    "Calibrate + validate" => "evaluation stage",
    "Residualize each contact" => "residualization stage",
    "Analyze residuals" => "Sprint Speed analysis stage"
  }.each do |expected, label|
    errors << "Release-ready xwOBA workflow lacks #{label}: #{expected}" unless workflow_source.include?(expected)
  end

  nfl_source = ROOT.join("_projects/dynamic-nfl-ratings.md").read
  {
    "Revisions" => "public manuscript status",
    "https://arxiv.org/abs/2604.01491" => "arXiv preprint",
    "https://github.com/WhartonSABI/nfl-elo" => "public NFL repository",
    "153,138" => "public interaction count",
    "30,628" => "public holdout count"
  }.each do |expected, label|
    errors << "Release-ready NFL page lacks #{label}: #{expected}" unless nfl_source.include?(expected)
  end

  thesis_source = ROOT.join("_projects/sparse-controls-spatial-epidemiology.md").read
  errors << "Release-ready thesis page lacks approved PDF" unless thesis_source.include?("maximilian-gebauer-statistics-thesis.pdf")
  %w[
    thesis-covid-mortality-map.png
    thesis-covid-mortality-distribution.png
    thesis-republican-vote-map.png
    thesis-republican-vote-distribution.png
  ].each do |figure|
    errors << "Release-ready thesis page lacks approved figure: #{figure}" unless thesis_source.include?(figure)
  end
end

if errors.empty?
  puts "Site checks passed: #{html_files.length} HTML files, internal and external-link contracts, assets, unique permalinks, identifiers, and CV PDF."
else
  warn errors.map { |error| "ERROR: #{error}" }.join("\n")
  exit 1
end
