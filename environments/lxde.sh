#!/bin/bash

# Custom LXDE with Cairo-Dock

# Set up to run as a normal user with sudo

echo :::
echo Making sure all packages are up to date...
yaourt -Syua

echo :::
echo Installing custom LXDE environment
sudo pacman -S cairo-dock-plugins gnome-icon-theme-extras gnome-menus gvfs libical lxappearance lxappearance-obconf lxde-common lxde-icon-theme lxdm lxinput lxmenu-data lxpolkit lxrandr lxsession lxtask lxterminal menu-cache openbox pcmanfm xcompmgr

sudo systemctl enable lxdm

mkdir ~/.config/lxsession
mkdir ~/.config/lxsession/LXDE
echo '@xcompmgr -c' >> ~/.config/lxsession/LXDE/autostart
echo '@cairo-dock -o' >> ~/.config/lxsession/LXDE/autostart

echo :::
echo Note: The LXDE Icon is located at /usr/share/lxde/images/lxde-icon.png

# Cairo-Dock Tweak thread for LXDE
# http://www.remastersys.com/forums/index.php?topic=1734.0

# To enable system monitor plugin in Cairo-Dock
# sudo pacman -S lm_sensors
