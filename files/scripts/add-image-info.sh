#!/usr/bin/env bash

set -euo pipefail

IMAGE_VENDOR="mradityaalok"
IMAGE_NAME="ananya"
IMAGE_PRETTY_NAME="Ananya"
IMAGE_LIKE="fedora"
HOME_URL="https://github.com/MrAdityaAlok/Ananya"
DOCUMENTATION_URL="https://github.com/MrAdityaAlok/Ananya"
SUPPORT_URL="https://github.com/MrAdityaAlok/Ananya/issues"
BUG_SUPPORT_URL="https://github.com/MrAdityaAlok/Ananya/issues"
VERSION_CODENAME=""

IMAGE_INFO="/usr/share/ublue-os/image-info.json"
IMAGE_REF="ostree-image-signed:docker://ghcr.io/$IMAGE_VENDOR/$IMAGE_NAME"

BASE_IMAGE_NAME="Base Atomic $OS_VERSION"
BASE_IMAGE="quay.io/fedora-ostree-desktops/base-atomic"

cat >$IMAGE_INFO <<EOF
{
  "image-name": "$IMAGE_NAME",
  "image-vendor": "$IMAGE_VENDOR",
  "image-ref": "$IMAGE_REF",
  "image-tag":"latest",
  "base-image-name": "$BASE_IMAGE",
  "fedora-version": "$OS_VERSION"
}
EOF

# OS Release File
if grep -q "VARIANT_ID" /usr/lib/os-release; then
  sed -i "s/^VARIANT_ID=.*/VARIANT_ID=$IMAGE_NAME/" /usr/lib/os-release
else
  echo "VARIANT_ID=$IMAGE_NAME" >>/usr/lib/os-release
fi
sed -i "s/^PRETTY_NAME=.*/PRETTY_NAME=\"${IMAGE_PRETTY_NAME} (FROM Fedora ${BASE_IMAGE_NAME^})\"/" /usr/lib/os-release
sed -i "s/^NAME=.*/NAME=\"$IMAGE_PRETTY_NAME\"/" /usr/lib/os-release
sed -i "s|^HOME_URL=.*|HOME_URL=\"$HOME_URL\"|" /usr/lib/os-release
sed -i "s|^DOCUMENTATION_URL=.*|DOCUMENTATION_URL=\"$DOCUMENTATION_URL\"|" /usr/lib/os-release
sed -i "s|^SUPPORT_URL=.*|SUPPORT_URL=\"$SUPPORT_URL\"|" /usr/lib/os-release
sed -i "s|^BUG_REPORT_URL=.*|BUG_REPORT_URL=\"$BUG_SUPPORT_URL\"|" /usr/lib/os-release
sed -i "s|^CPE_NAME=\"cpe:/o:fedoraproject:fedora|CPE_NAME=\"cpe:/o:${IMAGE_VENDOR}:${IMAGE_PRETTY_NAME,}|" /usr/lib/os-release
sed -i "s/^DEFAULT_HOSTNAME=.*/DEFAULT_HOSTNAME=\"${IMAGE_PRETTY_NAME,}\"/" /usr/lib/os-release
sed -i "s/^ID=fedora/ID=${IMAGE_PRETTY_NAME,}\nID_LIKE=\"${IMAGE_LIKE}\"/" /usr/lib/os-release
sed -i "/^REDHAT_BUGZILLA_PRODUCT=/d; /^REDHAT_BUGZILLA_PRODUCT_VERSION=/d; /^REDHAT_SUPPORT_PRODUCT=/d; /^REDHAT_SUPPORT_PRODUCT_VERSION=/d" /usr/lib/os-release
sed -i "s/^VERSION_CODENAME=.*/VERSION_CODENAME=${VERSION_CODENAME,,}/" /usr/lib/os-release

# Fix issues caused by ID no longer being fedora
sed -i "s/^EFIDIR=.*/EFIDIR=\"fedora\"/" /usr/sbin/grub2-switch-to-blscfg
