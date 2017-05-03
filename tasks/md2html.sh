#!/bin/sh -ex

# Remember that Alpine uses sh and not bash.

apk add --no-cache                         \
  build-base                               \
  ca-certificates                          \
  ruby                                     \
  ruby-dev                                 \
  ruby-io-console                          \
  ruby-rdoc                                \
  ruby-irb                                 \
  ruby-rake                                \
  ruby-bigdecimal                          \
  ruby-json

# export BUNDLE_GEMFILE=pipeline/tasks/Gemfile
bundle install --jobs 4
bundle exec pipeline/tasks/md2html.rb
