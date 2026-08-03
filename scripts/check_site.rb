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

  document.css("img[src]").each do |node|
    errors << "#{file.relative_path_from(SITE)}: image missing alt attribute" if node["alt"].nil?
    src = node["src"]
    next if src.start_with?("http://", "https://", "data:")
    errors << "#{file.relative_path_from(SITE)}: missing image #{src}" unless resolve_internal.call(src, file)
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

project_source = ROOT.join("_projects/contextual-xwoba.md").read
if ENV["RELEASE_READY"] == "1"
  errors << "Release-ready xwOBA page lacks canonical_url" unless project_source.match?(/^canonical_url:\s+https:\/\//)
  errors << "Release-ready xwOBA page lacks repository_url" unless project_source.match?(/^repository_url:\s+https:\/\//)
end

if errors.empty?
  puts "Site checks passed: #{html_files.length} HTML files, internal and external-link contracts, assets, unique permalinks, identifiers, and CV PDF."
else
  warn errors.map { |error| "ERROR: #{error}" }.join("\n")
  exit 1
end
