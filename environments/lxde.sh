#!/bin/bash

yaourt -Syua
sudo pacman -S cairo-dock-plugins dosfstools ffmpeg gnome-menus gnome-icon-theme gvfs gvfs-smb libical lxappearance lxappearance-obconf lxde-common lxde-icon-theme lxdm lxinput lxmenu-data lxpolkit lxrandr lxsession lxtask lxterminal menu-cache openbox ntfs-3g pcmanfm smbclient xcompmgr

# additional cairo-dock plugins
# sudo pacman -S lm_sensors

# Cairo-Dock Tweak thread for LXDE
# http://www.remastersys.com/forums/index.php?topic=1734.0

sudo systemctl enable lxdm

mkdir ~/.config/lxsession
mkdir ~/.config/lxsession/LXDE
echo '@xcompmgr -c' >> ~/.config/lxsession/LXDE/autostart
echo '@cairo-dock -o' >> ~/.config/lxsession/LXDE/autostart
