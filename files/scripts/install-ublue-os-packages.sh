#!/usr/bin/env bash

set -eou pipefail

curl -Lo /etc/yum.repos.d/_copr-ublue-os-packages.repo \
  https://copr.fedorainfracloud.org/coprs/ublue-os/packages/repo/fedora-"${OS_VERSION}"/ublue-os-packages-fedora-"${OS_VERSION}".repo

dnf5 -y install ublue-os-update-services

systemctl enable flatpak-system-update.timer
systemctl enable --global flatpak-user-update.timer

rm /etc/yum.repos.d/_copr-ublue-os-packages.repo
