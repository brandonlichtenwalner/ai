#!/bin/sh

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
