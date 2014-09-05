#!/bin/bash

yaourt -Syua
sudo pacman -S dosfstools ffmpeg gvfs gvfs-smb lxde ntfs-3g smbclient

sudo systemctl enable lxdm
