#!/usr/bin/env bash

set -eou pipefail

setsebool -P domain_kernel_load_modules on

curl -Lo /etc/yum.repos.d/_copr-cachyos-kernel.repo \
  https://copr.fedorainfracloud.org/coprs/bieszczaders/kernel-cachyos/repo/fedora-"${OS_VERSION}"/bieszczaders-kernel-cachyos-fedora-"${OS_VERSION}".repo

for pkg in kernel kernel-core kernel-modules kernel-modules-core kernel-modules-extra; do
  rpm --erase "$pkg" --nodeps
done

dnf5 -y install kernel-cachyos

curl -Lo /etc/yum.repos.d/_copr-cachyos-kernel-addons.repo \
  https://copr.fedorainfracloud.org/coprs/bieszczaders/kernel-cachyos-addons/repo/fedora-"${OS_VERSION}"/bieszczaders-kernel-cachyos-addons-fedora-"${OS_VERSION}".repo

dnf5 -y install libcap-ng-devel procps-ng-devel
dnf5 -y install uksmd

systemctl enable uksmd.service

dnf5 versionlock add kernel-cachyos libcap-ng-devel procps-ng-devel uksmd

rm /etc/yum.repos.d/_copr-cachyos-kernel.repo
rm /etc/yum.repos.d/_copr-cachyos-kernel-addons.repo
