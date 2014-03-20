#!/bin/bash

# Enlightenment with LightDM and my commonly used applications
# Set up to run as a normal user with sudo

sudo pacman -Syu chromium enlightenment geany-plugins gnome-icon-theme-extras gnome-keyring gvs lightdm-gtk3-greeter pcmanfm polkit-gnome terminology

sudo systemctl enable lightdm
sudo systemctl enable polkit-gnome

# Install all of the extras for chromium plus a few other AUR packages
yaourt -Syua chromium-pepper-flash chromium-libpdf google-talkplugin spideroak virtualbox-ext-oracle

# additional applications plus some useful optional dependencies
sudo pacman -S alsa-plugins asunder baobab brasero dosfstools ffmpeg file-roller gnome-disk-utility gvfs-smb hplip libdvdcss libreoffice-calc libreoffice-impress libreoffice-writer mumble ntfs-3g speex steam system-config-printer transmission-gtk unrar unzip virtualbox-guest-iso vlc vorbis-tools

echo :::
echo Please see per-user GNOME Keyring fix at https://wiki.archlinux.org/index.php/enlightenment#GNOME_Keyring_integration
