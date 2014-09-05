#!/bin/bash

echo "This script follows https://wiki.archlinux.org/index.php/Beginners'_guide"
echo Before running it, make sure you have:
echo   1) Established (and tested) an internet connection
echo   2) Partitioned the disk (and changed the root partition below, if necessary)
echo It will take a few minutes--or longer on a slow connection--for pacstrap to run,
echo so be patient and do not touch anything if you want this script to finish successfully!
read -p "Press [Enter] to begin initial setup with a single ext4 partition on /dev/sda1"

mkfs.ext4 /dev/sda1
mount /dev/sda1 /mnt

pacstrap /mnt base

genfstab -U -p /mnt >> /mnt/etc/fstab

# download chrooted.sh and post-install.sh into /mnt
cd /mnt
echo :::
echo Grabbing the chroot and post-installation scripts...
wget https://github.com/brandonlichtenwalner/arch-install/raw/master/chrooted.sh
chmod +x chrooted.sh
cd /mnt/root
wget https://github.com/brandonlichtenwalner/arch-install/raw/master/post-install.sh
chmod +x post-install.sh
cd

echo :::
echo Entering chroot environment where you must run chrooted.sh to continue...
arch-chroot /mnt /bin/bash
# the system will now be waiting for the arch-chroot to finish

# once the chroot is exited finish up with unmounting
umount -R /mnt
echo :::
echo Your basic Arch Linux installation is now complete. Reboot and continue with /root/post-install.sh if desired.
