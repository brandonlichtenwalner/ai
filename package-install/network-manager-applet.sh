#!/bin/sh

# on a laptop or other device where you want to set up wireless
sudo pacman -S network-manager-applet
sudo systemctl enable NetworkManager.service
sudo systemctl disable dhcpcd.service

rm network-manager-applet.sh
