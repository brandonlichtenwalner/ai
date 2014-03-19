#!/bin/bash

# A custom LXDE install
#
# Replaced: lxdm with lightdm-gtk3-greeter
#
# Removed: gpicview lxmusic lxpanel

pacman -Syu lightdm-gtk3-greeter lxapparance-obconf lxde-common lxde-icon-theme lxinput lxmenu-data lxpolkit lxrandr lxsession lxshortcut lxtask lxterminal menu-cache openbox pcmanfm
