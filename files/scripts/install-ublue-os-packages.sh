#!/usr/bin/env bash

set -eou pipefail

curl -Lo /etc/yum.repos.d/_copr-ublue-os-packages.repo \
  https://copr.fedorainfracloud.org/coprs/ublue-os/packages/repo/fedora-"${OS_VERSION}"/ublue-os-packages-fedora-"${OS_VERSION}".repo

rpm-ostree install ublue-os-update-services ublue-fastfetch

rm /etc/yum.repos.d/_copr-ublue-os-packages.repo
