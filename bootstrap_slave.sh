#! /usr/bin/bash

dnf config-manager --set-enabled powertools
dnf --assumeyes install epel-release epel-next-release
dnf --assumeyes install avahi nss-mdns

systemctl enable avahi-daemon --now

sudo -u vagrant sh -c "cat ~vagrant/.ssh/master_id_ed25519.pub >> ~vagrant/.ssh/authorized_keys"