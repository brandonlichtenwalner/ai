#!/bin/bash

# LXDE with my commonly used applications
#
# Set up to run as a normal user with sudo as Yaourt prefers it this way

yaourt -Syua chromium gvfs kdesdk-kate kdebase-konsole lightdm-kde-greeter openbox pcmanfm
# NOTE the QT alternatives: kdesdk-kate kdebase-konsole lightdm-kde-greeter pcmanfm-qt
# actually take up more resources than: geany lxterminal and lightdm-gtk-greeter pcmanfm
# and all of the actual GTK packages required were already installed (probably by chromium?)
# 
# In other words, just test/use what I like the best.

sudo systemctl enable lightdm

# Install all of the extras for chromium
# yaourt -Syua chromium-pepper-flash chromium-libpdf google-talkplugin

# additional applications plus some useful optional dependencies
# pacman -S alsa-plugins dosfstools ffmpeg gvfs-smb libdvdcss kdebase-okular ntfs-3g speex steam vlc
