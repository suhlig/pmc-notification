#!/bin/bash -ex

pushd source
  find . -name "${SOURCE_GLOB}" -exec cp --parents '{}' ../target \;
popd
