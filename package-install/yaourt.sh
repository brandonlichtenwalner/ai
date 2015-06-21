#!/bin/sh

echo ":::"
echo "Installing needed base-devel packages for AUR builds"
sudo pacman -S --needed base-devel

echo ":::"
echo "Running setup, makepkg, and cleanup for yaourt"
mkdir yaourt-setup
cd yaourt-setup
curl -O https://aur.archlinux.org/packages/pa/package-query/package-query.tar.gz
tar zxvf package-query.tar.gz
cd package-query
makepkg -si
cd ..
curl -O https://aur.archlinux.org/packages/ya/yaourt/yaourt.tar.gz
tar zxvf yaourt.tar.gz
cd yaourt
makepkg -si
cd ..
cd ..
rm -r yaourt-setup

echo ":::"
echo "If there were no errors, Yaourt is now ready to use."
rm yaourt.sh
