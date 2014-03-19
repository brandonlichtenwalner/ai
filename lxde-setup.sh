#!/bin/bash

# LXDE with my commonly used applications
# run as a user so yaourt can be called as non-root

sudo pacman -Syu chromium geany-plugins gvfs lxde

sudo systemctl enable lxdm

# All of the extras for chromium
yaourt -Syua chromium-pepper-flash chromium-libpdf google-talkplugin

# additional applications plus some useful optional dependencies
# pacman -S alsa-plugins dosfstools gvfs-smb kdebase-okular ntfs-3g steam vlc ffmpeg speex
