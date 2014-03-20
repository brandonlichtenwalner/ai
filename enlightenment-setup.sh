#!/bin/bash

# Enlightenment with LightDM and my commonly used applications
# Set up to run as a normal user with sudo

sudo pacman -Syu chromium enlightenment geany-plugins gnome-icon-theme-extras gnome-keyring lightdm-gtk3-greeter polkit-gnome terminology

sudo systemctl enable lightdm
sudo systemctl enable polkit-gnome

echo :::
echo Please see per-user GNOME Keyring fix at https://wiki.archlinux.org/index.php/enlightenment#GNOME_Keyring_integration

# Install all of the extras for chromium
# yaourt -Syua chromium-pepper-flash chromium-libpdf google-talkplugin

# additional applications plus some useful optional dependencies
# pacman -S alsa-plugins asunder baobab brasero dosfstools ffmpeg file-roller gnome-disk-utility hplip libdvdcss libreoffice-calc libreoffice-impress libreoffice-writer lxappearance-obconf lxrandr mumble ntfs-3g speex steam system-config-printer transmission-gtk unrar unzip vlc vorbis-tools

# if efm stilll sucks
# sudo pacman -S gvfs-smb pcmanfm

# others, might be AUR
# spideroak virtualbox-ext-oracle virtualbox-guest-iso
