#!/bin/sh
# Copyright 2023 Huawei Cloud Computing Technology Co., Ltd.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -eu

: ${JUST_REPO:=https://github.com/just-buildsystem/justbuild}
: ${JUST_BRANCH:=v1.4.1}
: ${TC_REPO:=https://github.com/just-buildsystem/bootstrappable-toolchain}
: ${TC_BRANCH:=master}
: ${TC_NAME:=gcc-14.1.0-musl+tools}

cd $(dirname $0)

cat repos.template.json \
  | just-import-git -C - --as imported-toolchain -b ${TC_BRANCH} ${TC_REPO} "${TC_NAME}" \
  | just-import-git -C - --as just -b ${JUST_BRANCH} ${JUST_REPO} just --map toolchain imported-toolchain \
  | ./json-format.py \
  > repos.json

