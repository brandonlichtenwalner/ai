#!/bin/bash

yaourt -Syua
sudo pacman -S cairo-dock-plugins dosfstools ffmpeg gvfs gvfs-smb lxde ntfs-3g smbclient xcompmgr

# additional cairo-dock plugins
# sudo pacman -S libical lm_sensors

sudo systemctl enable lxdm

mkdir ~/.config/lxsession
mkdir ~/.config/lxsession/LXDE
echo '@xcompmgr -c' >> ~/.config/lxsession/LXDE/autostart
echo '@cairo-dock -o' >> ~/.config/lxsession/LXDE/autostart
