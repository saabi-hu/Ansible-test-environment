#! /usr/bin/bash

dnf config-manager --set-enabled PowerTools
dnf --assumeyes install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
dnf --assumeyes install avahi nss-mdns tftp

systemctl enable avahi-daemon --now
useradd --comment "Ansible account" --create-home --user-group ansible
sudo -u ansible tftp master.local -c get id_ed25519.pub ~ansible/master-id_25519.pub
sudo -u ansible mkdir ~ansible/.ssh/
sudo -u ansible sh -c "cat ~ansible/master-id_25519.pub > ~ansible/.ssh/authorized_keys"