#! /usr/bin/bash

dnf config-manager --set-enabled powertools
dnf --assumeyes install epel-release epel-next-release
dnf --assumeyes install avahi nss-mdns

systemctl enable avahi-daemon --now

chmod 600 ~vagrant/.ssh/id_ed25519