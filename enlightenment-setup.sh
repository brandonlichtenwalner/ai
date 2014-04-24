#!/bin/bash

# Enlightenment with LightDM and my commonly used applications
# Set up to run as a normal user with sudo

echo :::
echo Making sure all packages are up to date...
yaourt -Syua
echo :::
echo Installing basic Enlightenment environment
sudo pacman -S chromium enlightenment geany-plugins gnome-calculator gnome-icon-theme-extras gnome-keyring gnome-themes-standard gvfs lightdm-gtk3-greeter lxpolkit numlockx pcmanfm terminology

sudo systemctl enable lightdm

# additional applications plus some useful optional dependencies
echo :::
echo Installing applications for a complete desktop experience plus useful optional add-ons
sudo pacman -S alsa-plugins arandr asunder baobab brasero dosfstools ffmpeg file-roller gnome-disk-utility gvfs-smb hunspell-en hyphen-en lib32-alsa-plugins libdvdcss libreoffice-calc libreoffice-en-US libreoffice-gnome libreoffice-impress libreoffice-writer mumble mythes mythes-en ntfs-3g p7zip qt4 shotwell speex steam system-config-printer transmission-gtk unrar unzip virtualbox-guest-iso virtualbox-host-modules vlc vorbis-tools

# for a print server (i.e. local printer attached)
# echo :::
# echo Installing CUPS and enabling the service
# sudo pacman -S cups hplip
# sudo systemctl enable cups.service

# SANE stuff, if applicable, would go here

# load vboxdrv module on startup
sudo sh -c "echo \"vboxdrv\" > /etc/modules-load.d/virtualbox.conf"

# Install all of the extras for chromium plus a few other AUR packages
echo :::
echo Installing Chromium plugins from AUR
echo Tip: remove the cleanup step from the first .install file so the Chrome binary does not need to be downloaded twice
yaourt -S chromium-pepper-flash chromium-libpdf google-talkplugin
#echo :::
#echo Installing Google Music Manager from AUR
#yaourt -S google-musicmanager
echo :::
echo Installing Virtualbox extensions from AUR
yaourt -S virtualbox-ext-oracle
echo :::
echo Installing Adobe Reader from AUR
yaourt -S acroread


# on a laptop or other device where you want to set up wireless
# sudo pacman -S network-manager-applet
# sudo systemctl enable NetworkManager.service


echo :::
echo Please see the enlightenment-post-install.txt file for additional--per user--configuration steps.

rm enlightenment-setup.sh
