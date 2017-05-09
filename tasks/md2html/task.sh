#!/bin/bash -ex

bundle install --jobs 4
bundle exec pipeline/tasks/md2html/md2html.rb
