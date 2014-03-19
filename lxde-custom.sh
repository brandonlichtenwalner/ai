#!/bin/bash

# A custom LXDE install
#
# Replaced: lxdm with lightdm-gtk3-greeter
#
# Removed: gpicview lxmusic lxpanel
#
# Added: chromium gvfs geany-plugins

pacman -Syu chromium geany-plugins gvfs lightdm-gtk3-greeter lxapparance-obconf lxde-common lxde-icon-theme lxinput lxmenu-data lxpolkit lxrandr lxsession lxshortcut lxtask lxterminal menu-cache openbox pcmanfm

systemctl enable lightdm

# additional applications plus some useful optional dependencies
# pacman -S alsa-plugins gvfs-smb steam vlc ffmpeg speex 
