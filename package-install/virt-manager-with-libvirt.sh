#!/bin/sh

echo ":::"
echo "Installing libvirt server packages and all optional networking dependencies"
sudo pacman -S libvirt qemu ebtables dnsmasq bridge-utils openbsd-netcat

echo ":::"
echo "Enabling libvirtd"
sudo systemctl start libvirtd.service
sudo systemctl enable libvirtd.service

echo ":::"
ehco "Installing virt-manager"
sudo pacman -S virt-manager
