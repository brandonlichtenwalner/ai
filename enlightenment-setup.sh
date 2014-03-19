#!/bin/bash

pacman -Syu enlightenment lightdm-gtk-greeter terminology

systemctl enable lightdm
