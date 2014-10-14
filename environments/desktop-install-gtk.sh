#!/bin/sh

echo :::
echo Installing applications for a complete GTK-based desktop experience with useful optional add-ons
sudo pacman -S alsa-plugins asunder baobab brasero chromium ffmpeg file-roller geany-plugins gnome-calculator gnome-disk-utility gvfs-smb hunspell-en hyphen-en lib32-alsa-plugins libdvdcss libreoffice-calc libreoffice-en-US libreoffice-gnome libreoffice-impress libreoffice-writer mumble mythes mythes-en ntfs-3g p7zip qt4 shotwell shutter smbclient steam system-config-printer transmission-gtk unrar unzip virtualbox-guest-iso virtualbox-host-modules vlc vorbis-tools

# for general desktop printing (i.e. where there is not already a print server set up elsewhere)
# assumes you are using an HP printer
echo :::
echo Installing CUPS with HPLIP and enabling the service
sudo pacman -S cups hplip
sudo systemctl enable cups.service

# If just connecting to a print server
# echo :::
# echo Installing CUPS (client-only)
# sudo pacman -S libcups

# SANE stuff, if applicable, would go here

# load vboxdrv module on startup
sudo sh -c "echo \"vboxdrv\" > /etc/modules-load.d/virtualbox.conf"

# Install all of the extras for chromium plus a few other AUR packages
echo :::
echo Installing Chromium plugins from AUR
yaourt -S chromium-pepper-flash google-talkplugin
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
# sudo systemctl disable dhcpcd.service
