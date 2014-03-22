#!/bin/bash

# everyone uses the AUR, right?
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

echo If there were no errors, Yaourt is now ready to use.
rm yaourt-setup.sh
