#!/bin/sh

# Enlightenment with LightDM

echo :::
echo Installing basic Enlightenment environment
pacman -S arandr enlightenment gnome-icon-theme-extras gnome-keyring gnome-themes-standard gvfs lightdm-gtk3-greeter lxpolkit numlockx pcmanfm terminology

systemctl enable lightdm

echo :::
echo Enlightenment setup complete.
echo Please see the enlightenment-post-install.txt file for additional--per user--configuration steps.

rm enlightenment-setup.sh
