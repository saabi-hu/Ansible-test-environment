#! /usr/bin/bash

dnf config-manager --set-enabled PowerTools
dnf --assumeyes install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
dnf --assumeyes install avahi nss-mdns

systemctl enable avahi-daemon --now

sudo -u vagrant sh -c "cat ~vagrant/.ssh/master_id_rsa.pub >> ~vagrant/.ssh/authorized_keys"
