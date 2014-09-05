#!/bin/bash

# Enlightenment with LightDM

# Set up to run as a normal user with sudo

echo :::
echo Making sure all packages are up to date...
yaourt -Syua

echo :::
echo Installing basic Enlightenment environment
sudo pacman -S arandr enlightenment gnome-icon-theme-extras gnome-keyring gnome-themes-standard gvfs lightdm-gtk3-greeter lxpolkit numlockx pcmanfm terminology

sudo systemctl enable lightdm

echo :::
echo Please see the enlightenment-post-install.txt file for additional--per user--configuration steps.

rm enlightenment-setup.sh
