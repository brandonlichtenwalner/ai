#!/bin/bash

yaourt -Syua
sudo pacman -S cairo-dock-plugins dosfstools ffmpeg gvfs gvfs-smb lxde ntfs-3g smbclient xcompmgr

# additional cairo-dock plugins
# sudo pacman -S libical lm_sensors

# Cairo-Dock Tweak thread for LXDE
# http://www.remastersys.com/forums/index.php?topic=1734.0

sudo systemctl enable lxdm

mkdir ~/.config/lxsession
mkdir ~/.config/lxsession/LXDE
echo '@xcompmgr -c' >> ~/.config/lxsession/LXDE/autostart
echo '@cairo-dock -o' >> ~/.config/lxsession/LXDE/autostart
