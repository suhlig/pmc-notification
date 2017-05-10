#!/bin/bash -ex

bundle install --jobs 4
git diff-tree --no-commit-id --name-only -r HEAD | xargs bundle exec pipeline/tasks/md2html/md2html.rb
