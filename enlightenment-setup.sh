#!/bin/bash

# Enlightenment with LightDM and my commonly used applications 

pacman -Syu chromium enlightenment geany-plugins gvfs lightdm-gtk-greeter

systemctl enable lightdm

# lxterminal or terminology
# pcmanfm if the default file manager is still crap
