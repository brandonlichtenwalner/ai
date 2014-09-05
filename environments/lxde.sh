#!/bin/bash

yaourt -Syua
sudo pacman -S cairo-dock dosfstools ffmpeg gvfs gvfs-smb lxde ntfs-3g smbclient

sudo systemctl enable lxdm
mkdir ~/.config/lxsession
mkdir ~/.config/lxsession/LXDE
echo '@cairo-dock -f -c' >> ~/.config/lxsession/LXDE/autostart
