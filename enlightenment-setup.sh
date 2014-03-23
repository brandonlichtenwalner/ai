#!/bin/bash

# Enlightenment with LightDM and my commonly used applications
# Set up to run as a normal user with sudo

echo :::
echo Making sure all packages are up to date...
sudo pacman -Syu
echo :::
echo Installing basic Enlightenment environment
sudo pacman -S chromium enlightenment geany-plugins gnome-icon-theme-extras gnome-keyring gnome-themes-standard gvfs lightdm-gtk3-greeter lxpolkit pcmanfm terminology

sudo systemctl enable lightdm

# additional applications plus some useful optional dependencies
echo :::
echo Installing applications for a complete desktop experience plus useful optional add-ons
sudo pacman -S alsa-plugins arandr asunder baobab brasero dosfstools ffmpeg file-roller gnome-disk-utility gvfs-smb hplip hunspell-en hyphen-en libdvdcss libreoffice-calc libreoffice-en-US libreoffice-gnome libreoffice-impress libreoffice-writer mumble mythes mythes-en ntfs-3g p7zip qt4 speex steam system-config-printer transmission-gtk unrar unzip virtualbox-guest-iso vlc vorbis-tools

# Install all of the extras for chromium plus a few other AUR packages
echo :::
echo Installing Chromium extras and Virtualbox extensions from AUR
yaourt -Syua chromium-pepper-flash chromium-libpdf google-talkplugin virtualbox-ext-oracle

# on a laptop or other device where you want to set up wireless
# sudo pacman -S network-manager-applet
# sudo systemctl enable NetworkManager.service
# echo 5 - Add Network to Startup Applications >> enlightenment-post-install.txt

echo :::
echo Please see the enlightenment-post-install.txt file for additional--per user--configuration steps.

rm enlightenment-setup.sh
