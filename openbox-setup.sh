#!/bin/bash

# Openbox with "necessary" applications
# Set up to run as a normal user with sudo as Yaourt prefers it this way

sudo pacman -Syu chromium geany-plugins gnome-keyring gvfs lightdm-gtk3-greeter lxpolkit lxterminal openbox pcmanfm polkit python2-xdg
# NOTE the Qt alternatives: kdesdk-kate kdebase-konsole lightdm-kde-greeter pcmanfm-qt
# actually take up more resources than: geany lxterminal lightdm-gtk-greeter pcmanfm
# and all of the actual GTK packages required were already installed after installing only openbox and chromium
# 
# In other words, just test/use what I like the best.
# 
# On top of that it seems that gnome-keyring is needed for wifi which pulls in GTK3 stuff
# So I've just given up on even trying to make an all/mostly Qt system for now.

sudo systemctl enable lightdm

# Install all of the extras for chromium
# yaourt -Syua chromium-pepper-flash chromium-libpdf google-talkplugin

# additional applications plus some useful optional dependencies
# pacman -S alsa-plugins dosfstools ffmpeg gvfs-smb libdvdcss ntfs-3g speex steam vlc
