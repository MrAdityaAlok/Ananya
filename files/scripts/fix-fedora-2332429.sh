#!/usr/bin/env bash

set -eou pipefail

# See: https://bugzilla.redhat.com/show_bug.cgi?id=2332429

# Swap the incorrectly installed OpenCL-ICD-Loader for ocl-icd, the expected package:
rpm-ostree override replace \
  --from repo='fedora' \
  --experimental \
  --remove=OpenCL-ICD-Loader \
  ocl-icd || true
