#!/bin/sh

yaourt -Syua
sudo pacman -S gvfs lxappearance lxappearance-obconf lxde-common lxde-icon-theme lxdm lxinput lxmenu-data lxpolkit lxrandr lxsession lxtask lxterminal menu-cache openbox pcmanfm

#optional
# sudo pacman -S dosfstools gvfs-smb ntfs-3g

sudo systemctl enable lxdm
