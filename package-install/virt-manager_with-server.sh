#!/bin/sh

echo ":::"
echo "Installing libvirt server packages"
sudo pacman -S libvirt qemu ebtables dnsmasq bridge-utils openbsd-netcat"

echo ":::"
ehco "Installing virt-manager"
sudo pacman -S virt-manager
