#!/bin/bash

yaourt -Syua
sudo pacman -S cairo-dock dosfstools ffmpeg gvfs gvfs-smb lxde ntfs-3g smbclient

sudo systemctl enable lxdm
echo 'cairo-dock -f -c &' >> ~/.config/openbox/autostart
