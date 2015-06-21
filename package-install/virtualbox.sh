#!/bin/sh

echo ":::"
echo "Installing and configuring Virtualbox"
sudo pacman -S qt4 virtualbox-guest-iso virtualbox-host-modules

# load vboxdrv module on startup
sudo sh -c "echo \"vboxdrv\" > /etc/modules-load.d/virtualbox.conf"

echo ":::"
echo "You should now install Virtualbox extensions from AUR"
echo "e.g. yaourt -S virtualbox-ext-oracle"
