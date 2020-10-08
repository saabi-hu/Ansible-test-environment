#! /usr/bin/bash

dnf config-manager --set-enabled PowerTools
dnf --assumeyes install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
dnf --assumeyes install avahi nss-mdns python3 tftp-server

systemctl enable avahi-daemon --now
systemctl enable tftp --now
useradd --comment "Ansible master account" --create-home --user-group ansible
sudo -u ansible python3 -m pip install --user ansible
sudo -u ansible ssh-keygen -q -t ed25519 -C "master" -f ~ansible/.ssh/id_ed25519 -N ""
cp ~ansible/.ssh/id_ed25519.pub /var/lib/tftpboot