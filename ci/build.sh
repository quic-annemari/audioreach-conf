#!/bin/bash
# SPDX-License-Identifier: BSD-3-Clause-Clear
#
# Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
set -ex

PREBUILD_SCRIPT_PATH="${PREBUILD_SCRIPT:-$(dirname "${BASH_SOURCE[0]}")/pre_build.sh}"
source "$PREBUILD_SCRIPT_PATH"


# load build args from file if environment variable is not set
if [ -z "${BUILD_ARGS}" ]; then
    BUILD_OPTIONS_FILE="${GITHUB_WORKSPACE}/ci/build_options.txt"
    BUILD_ARGS="$(sed -E 's/#.*$//' "$BUILD_OPTIONS_FILE" | sed '/^[[:space:]]*$/d' | tr '\n' ' ')"
fi

echo "Running build script..."

# Build/Compile audioreach-conf
# make sure we are in the right directory
cd ${GITHUB_WORKSPACE}
source ${GITHUB_WORKSPACE}/install/environment-setup-armv8-2a-qcom-linux
mkdir ${GITHUB_WORKSPACE}/build
mkdir ${GITHUB_WORKSPACE}/build/etc
mkdir ${GITHUB_WORKSPACE}/build/etc/acdbdata
mkdir ${GITHUB_WORKSPACE}/build/etc/acdbdata/qcm6490_rb3
mkdir ${GITHUB_WORKSPACE}/build/etc/acdbdata/qcs8300
mkdir ${GITHUB_WORKSPACE}/build/etc/acdbdata/qcs9075
mkdir ${GITHUB_WORKSPACE}/build/etc/acdbdata/qcs9100

cp -r qcom/qli/qcm6490/card-defs.xml ${GITHUB_WORKSPACE}/build/etc/
cp -r qcom/qli/qcm6490/acdbdata/* ${GITHUB_WORKSPACE}/build/etc/acdbdata/qcm6490_rb3/
cp -r qcom/qli/qcs8300/acdbdata/* ${GITHUB_WORKSPACE}/build/etc/acdbdata/qcs8300/
cp -r qcom/qli/qcs9100/acdbdata/* ${GITHUB_WORKSPACE}/build/etc/acdbdata/qcs9100/
cp -r qcom/qli/qcs9075/acdbdata/* ${GITHUB_WORKSPACE}/build/etc/acdbdata/qcs9075/
