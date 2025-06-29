#!/usr/bin/env bash

set -eou pipefail

setsebool -P domain_kernel_load_modules on

curl -Lo /etc/yum.repos.d/_copr-cachyos-kernel.repo \
  https://copr.fedorainfracloud.org/coprs/bieszczaders/kernel-cachyos/repo/fedora-"${OS_VERSION}"/bieszczaders-kernel-cachyos-fedora-"${OS_VERSION}".repo

rpm-ostree override remove kernel kernel-core kernel-modules kernel-modules-core kernel-modules-extra --install kernel-cachyos

curl -Lo /etc/yum.repos.d/_copr-cachyos-kernel-addons.repo \
  https://copr.fedorainfracloud.org/coprs/bieszczaders/kernel-cachyos-addons/repo/fedora-"${OS_VERSION}"/bieszczaders-kernel-cachyos-addons-fedora-"${OS_VERSION}".repo

rpm-ostree install libcap-ng-devel procps-ng-devel
rpm-ostree install uksmd

rm /etc/yum.repos.d/_copr-cachyos-kernel.repo
rm /etc/yum.repos.d/_copr-cachyos-kernel-addons.repo
