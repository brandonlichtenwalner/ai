#!/bin/bash

# run this in a guest Arch Linux install to enable Virtual Box Guest Additions

echo Updating packages and installing virtualbox-guest-utils
pacman -Syu virtualbox-guest-utils

echo Enabling required modules and adding them to /etc/modules-load.d/virtualbox.conf
modprobe -a vboxguest vboxsf vboxvideo

echo vboxguest > /etc/modules-load.d/virtualbox.conf
echo vboxsf >> /etc/modules-load.d/virtualbox.conf
echo vboxvideo >> /etc/modules-load.d/virtualbox.conf

echo Starting and enabling Virtual Box services
VBoxClient-all

systemctl enable vboxservice

echo If there were no errors guest-additions should be all set.
