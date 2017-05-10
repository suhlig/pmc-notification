#!/usr/bin/env ruby

# Render the file passed as argument to $HTML_FILE using api.github.com/markdown

require 'http'
require 'json'

def render(markdown_filename, html_filename)
  warn "Rendering #{markdown_filename} to #{html_filename}"
  request_payload = { text: File.read(markdown_filename), mode: 'markdown' }
  response_body = HTTP.post('https://api.github.com/markdown', body: request_payload.to_json)
  File.write(html_filename, response_body)
end

if ARGV.size != 1
  warn "Expect exactly ONE argument, but got #{ARGV.size}: #{ARGV.join(' ')}"
  exit 1
end

render(ARGV.first, ENV.fetch('HTML_FILE'))
