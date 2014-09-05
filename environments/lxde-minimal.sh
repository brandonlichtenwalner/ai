#!/bin/bash

yaourt -Syua
sudo pacman -S gvfs lxappearance lxappearance-obconf lxde-common lxde-icon-theme lxdm lxinput lxmenu-data lxpolkit lxrandr lxsession lxtask lxterminal menu-cache openbox pcmanfm

sudo systemctl enable lxdm
