#!/usr/bin/env bash

set -eou pipefail

latest_version="$(basename "$(curl -Ls -o /dev/null -w "%{url_effective}" https://github.com/neovide/neovide/releases/latest)")"

apt-get update
apt install -y curl gnupg ca-certificates git gcc-multilib g++-multilib cmake \
  libssl-dev pkg-config libfreetype6-dev libasound2-dev libexpat1-dev \
  libxcb-composite0-dev libbz2-dev libsndio-dev freeglut3-dev libxmu-dev \
  libxi-dev libfontconfig1-dev libxcursor-dev

mkdir build-neovide

wget https://github.com/neovide/neovide/archive/refs/tags/"$latest_version".tar.gz
tar xf "$latest_version".tar.gz --strip-components=1 -C build-neovide

RUSTFLAGS="-C target-feature=-crt-static" cargo install --path build-neovide

mkdir /out/ && mv "$CARGO_HOME"/bin/neovide /out/
mv build-neovide/assets/neovide.{svg,desktop} /out/
