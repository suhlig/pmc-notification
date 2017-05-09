#!/bin/bash -ex

pushd source
  erb -T - "${SOURCE_FILE}" > ../target/"${TARGET_FILE}"
popd
