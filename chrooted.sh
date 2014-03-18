#!/bin/bash

# This script follows https://wiki.archlinux.org/index.php/Beginners'_guide
# Before running it, make sure you have already run setup.sh (or otherwise performed those steps).

# variables
LANGUAGE=en_US.UTF-8
SLEEPTIME=5
HOSTNAME=v-arch
TZ=America/New_York

echo You need to uncomment $LANGUAGE in /etc/locale.gen
echo launching nano in $SLEEPTIME seconds...
sleep $SLEEPTIME
nano /etc/locale.gen

locale-gen
echo LANG=$LANGUAGE > /etc/locale.conf
export LANG=$LANGUAGE

ln -s /usr/share/zoneinfo/$TZ /etc/localtime

hwclock --systohc --utc

echo $HOSTNAME > /etc/hostname

echo About to enable dhcpcd.service
echo If using wireless or a non-standard netwwork config hit Control+Z now to halt the script and finish the process manually.
sleep $SLEEPTIME
systemctl enable dhcpcd.service

echo About to run mkinitcpio
echo If you need to add any HOOKS--e.g. RAID, LVM, or USB boot--hit Control+Z now to halt the script and finish the process manually.
sleep $SLEEPTIME
mkinitcpio -p linux

echo Set the root password...
passwd

echo Proceeding with a standard Syslinux bootloader install
echo If you want to use GRUB, etc. hit Control+Z now to stop halt the script and finish the process manually.
sleep $SLEEPTIME
pacman -S gptfdisk syslinux
syslinux-install_update -i -a -m

echo Time to configure syslinux.cfg :: change /dev/sda3 to $ROOTPART and edit any other options to your liking.
echo launching nano in $SLEEPTIME seconds...
sleep $SLEEPTIME
nano /boot/syslinux/syslinux.cfg

echo Now just type -exit- to leave the chroot environment and finish installation.
