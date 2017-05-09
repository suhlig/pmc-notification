#!/bin/bash -ex

for dir in gemfiles dockerfiles; do
  pushd $dir > /dev/null
    find . -type f -exec cp --parents '{}' ../target \;
  popd > /dev/null
done
