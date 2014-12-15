#!/bin/sh

# This script follows https://wiki.archlinux.org/index.php/Beginners'_guide
# Before running it, make sure you have already run setup.sh (or otherwise performed those steps).

# variables that don't change for me
LANGUAGE=en_US.UTF-8
TZ=America/New_York

echo ":::"
echo "Preparing to open /etc/locale.gen for editing--you need to uncomment $LANGUAGE"
read -p "Press [Enter] to continue."
nano /etc/locale.gen

locale-gen
echo LANG=$LANGUAGE > /etc/locale.conf
export LANG=$LANGUAGE

ln -s /usr/share/zoneinfo/$TZ /etc/localtime

hwclock --systohc --utc

echo ":::"
echo "Please enter a hostname, e.g. 'arch': "
read HOSTNAME

echo "$HOSTNAME" > /etc/hostname

echo ":::"
echo "About to enable dhcpcd.service"
echo "If using wireless or a non-standard network config (during setup) hit Control+Z now to halt the script and finish the process manually."
read -p "Press [Enter] to continue."
systemctl enable dhcpcd.service

echo ":::"
echo "About to run mkinitcpio"
echo "Type 'yes' if you need to enter any HOOKS--e.g. for RAID, LVM, or USB boot--or hit [Enter] to continue: "
read HOOKS
if [ "$HOOKS" = "yes" ]; then
  nano /etc/mkinitcpio.conf
fi

mkinitcpio -p linux

echo ":::"
echo "Set the root password..."
passwd

echo ":::"
echo "Proceeding with a standard Syslinux bootloader install"
echo "If you want to use GRUB, etc. hit Control+Z now to stop halt the script and finish the process manually."
read -p "Press [Enter] to continue."
pacman -S gptfdisk syslinux
syslinux-install_update -i -a -m

echo ":::"
echo "Time to configure syslinux.cfg :: change the root partition as needed and edit any other options to your liking."
read -p "Press [Enter] to continue."
nano /boot/syslinux/syslinux.cfg

echo ":::"
echo "Cleaning up: removing chrooted.sh"
read -p "Press [Enter] to continue."
rm /chrooted.sh

echo ":::"
echo "Now just type 'exit' to leave the chroot environment and finish installation."
