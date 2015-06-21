#!/bin/sh

echo ":::"
echo "Installing and configuring Virtualbox"
sudo pacman -S qt4 virtualbox-guest-iso virtualbox-host-modules

# load vboxdrv module on startup
sudo sh -c "echo \"vboxdrv\" > /etc/modules-load.d/virtualbox.conf"

echo ":::"
echo "Installing Virtualbox extensions from AUR"
yaourt -S virtualbox-ext-oracle

rm virtualbox.sh
