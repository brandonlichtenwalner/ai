#!/bin/sh

echo ":::"
echo "Installing set of commonly used GTK applications"
sudo pacman -S brasero chromium ffmpeg gvfs-smb hunspell-en hyphen-en libdvdcss libreoffice-still-calc libreoffice-still-en-US libreoffice-still-gnome libreoffice-still-impress libreoffice-still-writer mythes mythes-en ntfs-3g p7zip rubyripper shutter smbclient transmission-gtk unrar unzip vlc

rm common-apps-gtk.sh
