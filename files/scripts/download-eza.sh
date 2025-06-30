#!/usr/bin/env bash

set -eou pipefail

wget -O eza.tar.gz \
  https://github.com/eza-community/eza/releases/latest/download/eza_x86_64-unknown-linux-gnu.tar.gz
tar xf eza.tar.gz

install -m0755 ./eza /usr/bin/
