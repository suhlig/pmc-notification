#!/usr/bin/env ruby

# Render $MARKDOWN_FILE to $HTML_FILE using api.github.com/markdown

require 'http'
require 'json'

def render(markdown_filename, html_filename)
  warn "Rendering #{markdown_filename} to #{html_filename}"
  request_payload = { text: File.read(markdown_filename), mode: 'markdown' }
  response_body = HTTP.post('https://api.github.com/markdown', body: request_payload.to_json)
  File.write(html_filename, response_body)
end

render(ENV.fetch('MARKDOWN_FILE'), ENV.fetch('HTML_FILE'))
