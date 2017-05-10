#!/bin/bash -ex

bundle install --jobs 4

pushd markdown > /dev/null
  git diff-tree --no-commit-id --name-only -r HEAD | xargs -I {} readlink -f {} > latest.txt
popd > /dev/null

xargs bundle exec pipeline/tasks/md2html/md2html.rb < markdown/latest.txt
