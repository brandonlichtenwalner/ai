#!/bin/bash

# LXDE with my commonly used applications

pacman -Syu chromium geany-plugins gvfs lxde

systemctl enable lxdm

# additional applications plus some useful optional dependencies
# pacman -S alsa-plugins gvfs-smb steam vlc ffmpeg speex
