#!/bin/sh

# everyone uses the AUR, right?
mkdir argon-setup
cd argon-setup
curl -O https://aur.archlinux.org/packages/co/cower/cower.tar.gz
tar zxvf cower.tar.gz
cd cower
makepkg -si
cd ..
curl -O https://aur.archlinux.org/packages/pa/pacaur/pacaur.tar.gz
tar zxvf pacaur.tar.gz
cd pacaur
makepkg -si
cd ..
cd ..
rm -r argon-setup

pacaur -S argon

echo If there were no errors, Yaourt is now ready to use.
rm argon-setup.sh
