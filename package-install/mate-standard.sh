#!/bin/sh

# MATE with LightDM

echo ":::"
echo "Installing basic/standard MATE environment..."
pacman -S lightdm-gtk2-greeter mate mate-accountsdialog mate-disk-utility mate-extra mate-nettool mate-themes-extra

# for small screens
# pacman -S mate-netbook

systemctl enable lightdm

echo ":::"
echo "MATE setup complete."
# echo Please see the mate-post-install.txt file for additional--per user--configuration steps.

rm mate-standard.sh
