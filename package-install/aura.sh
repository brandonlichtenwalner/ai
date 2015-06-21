#!/bin/sh

echo ":::"
echo "Installing needed base-devel packages for AUR builds"
sudo pacman -S --needed base-devel

echo ":::"
echo "Running setup, makepkg, and cleanup for aura"
mkdir aura-setup
cd aura-setup
curl -O https://aur.archlinux.org/packages/au/aura-bin/aura-bin.tar.gz
tar zxvf aura-bin.tar.gz
cd aura-bin
makepkg -si
cd ..
cd ..
rm -r aura-setup

echo ":::"
echo "If there were no errors, Aura is now ready to use."
rm aura.sh
