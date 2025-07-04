#!/usr/bin/env bash

set -eou pipefail

# Hide Desktop Files (Hidden removes mime associations):
for file in fish htop; do
  if [[ -f "/usr/share/applications/$file.desktop" ]]; then
    sed -i 's@\[Desktop Entry\]@\[Desktop Entry\]\nHidden=true@g' /usr/share/applications/"$file".desktop
  fi
done

# Remove mozilla skel:
rm -rf /etc/skel/.mozilla
