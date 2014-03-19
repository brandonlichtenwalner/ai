#!/bin/bash

# LXDE with my commonly used applications
# run as a user so yaourt can be called as non-root

sudo pacman -Syu chromium geany-plugins gvfs lxde

sudo systemctl enable lxdm

# other "required" tools
sudo pacman -S kdebase-okular

yaourt -Syua chromium-pepper-flash chromium-libpdf google-talkplugin

# additional applications plus some useful optional dependencies
# pacman -S alsa-plugins dosfstools gvfs-smb ntfs-3g steam vlc ffmpeg speex
