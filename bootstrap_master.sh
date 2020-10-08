#! /usr/bin/bash

dnf config-manager --set-enabled PowerTools
dnf --assumeyes install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
dnf --assumeyes install avahi nss-mdns python3

systemctl enable avahi-daemon --now
useradd --comment "Ansible master account" --create-home --user-group ansible
sudo -u ansible python3 -m pip install --user ansible