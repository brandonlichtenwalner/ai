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
echo "If using wireless or a non-standard network config (during setup) hit Control+Z now to halt and finish manually."
read -p "Press [Enter] to continue."
systemctl enable dhcpcd.service

echo ":::"
echo "About to run mkinitcpio, would you like to edit mkinitcpio.conf first"
echo "e.g. to add HOOKS for RAID, LVM, or USB boot or add crc32c/crc32c-intel to MODULES for Btrfs"
echo "[Y/n]: "
read HOOKS
if [ "$HOOKS" = "n" ] || [ "$HOOKS" = "N" ] || [ "$HOOKS" = "no" ] || [ "$HOOKS" = "No" ]; then
  echo "Continuing without editing mkinitcpio.conf..."
else
  nano /etc/mkinitcpio.conf
fi

mkinitcpio -p linux

echo ":::"
echo "Set the root password..."
passwd

echo ":::"
echo "Proceeding with Syslinux bootloader install."
echo "If you want to use GRUB, etc. hit Control+Z now to stop halt the script and finish the process manually."

while [ "$BOOTTYPE" != "UEFI" ] && [ "$BOOTTYPE" != "BIOS" ]; do
  echo "Please enter 'BIOS' or 'UEFI':  "
  read BOOTTYPE

  if [ "$BOOTTYPE" = "BIOS" ]; then
    echo ":::"
    echo "Proceeding with Syslinux BIOS install..."
    pacman -S gptfdisk syslinux
    syslinux-install_update -i -a -m
    curl https://projects.archlinux.org/archiso.git/plain/configs/releng/syslinux/splash.png -o /boot/syslinux/splash.png
    
    echo ":::"
    echo "Opening syslinux.cfg for editing--change the root partition as needed and edit any other options to your liking."
    read -p "Press [Enter] to continue."
    nano /boot/syslinux/syslinux.cfg
    
  elif [ "$BOOTTYPE" = "UEFI" ]; then
    echo ":::"
    echo "Proceeding with Syslinux UEFI install."
    echo "Please enter ESP location (e.g. /boot):  "
    read esp
    echo "Please enter device where ESP is located (e.g. /dev/sda):  "
    read bootdevice
    
    pacman -S dosfstools efibootmgr gptfdisk syslinux
    
    mkdir -p "$esp"/EFI/syslinux
    cp -r /usr/lib/syslinux/efi64/* "$esp"/EFI/syslinux
    efibootmgr -c -d "$bootdevice" -p 1 -l /EFI/syslinux/syslinux.efi -L "Syslinux"
    curl https://raw.githubusercontent.com/brandonlichtenwalner/arch-install/master/misc/syslinux.cfg -o "$esp"/EFI/syslinux/syslinux.cfg
    curl https://projects.archlinux.org/archiso.git/plain/configs/releng/syslinux/splash.png -o "$esp"/EFI/syslinux/splash.png
    
    echo ":::"
    echo "Opening syslinux.cfg for editing--change the root partition as needed and edit any other options to your liking."
    read -p "Press [Enter] to continue."
    nano "$esp"/EFI/syslinux/syslinux.cfg
  else
    echo ":::"
    echo "Invalid option."
  fi
done

echo ":::"
echo "Cleaning up: removing chrooted.sh -- Press [Enter] to continue or [CTRL+Z] to keep the file."
read -p "Then just type 'exit' to leave the chroot environment and finish installation."
rm /chrooted.sh
