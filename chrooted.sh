#!/bin/bash

# This script follows https://wiki.archlinux.org/index.php/Beginners'_guide
# Before running it, make sure you have already run setup.sh (or otherwise performed those steps).

# variables
LANGUAGE=en_US.UTF-8
HOSTNAME=arch
TZ=America/New_York

echo :::
echo "Preparing to open /etc/locale.gen for editing--you need to uncomment $LANGUAGE"
read -p "Press [Enter] to continue."
nano /etc/locale.gen

locale-gen
echo LANG=$LANGUAGE > /etc/locale.conf
export LANG=$LANGUAGE

ln -s /usr/share/zoneinfo/$TZ /etc/localtime

hwclock --systohc --utc

echo $HOSTNAME > /etc/hostname

echo :::
echo "About to enable dhcpcd.service"
echo "If using wireless or a non-standard network config (during setup) hit Control+Z now to halt the script and finish the process manually."
read -p "Press [Enter] to continue."
systemctl enable dhcpcd.service

echo :::
echo "About to run mkinitcpio"
echo "If you need to add any HOOKS--e.g. RAID, LVM, or USB boot--hit Control+Z now to halt the script and finish the process manually."
read -p "Press [Enter] to continue."
# nano /etc/mkinitcpio.conf
mkinitcpio -p linux

echo :::
echo "Set the root password..."
passwd

echo :::
echo Proceeding with a standard Syslinux bootloader install
echo If you want to use GRUB, etc. hit Control+Z now to stop halt the script and finish the process manually.
read -p "Press [Enter] to continue."
pacman -S gptfdisk syslinux
syslinux-install_update -i -a -m

echo :::
echo Time to configure syslinux.cfg :: change /dev/sda3 to $ROOTPART and edit any other options to your liking.
read -p "Press [Enter] to continue."
nano /boot/syslinux/syslinux.cfg

echo :::
echo Cleaning up: removing chrooted.sh
read -p "Press [Enter] to continue."
rm /chrooted.sh

echo :::
echo Now just type -exit- to leave the chroot environment and finish installation.
