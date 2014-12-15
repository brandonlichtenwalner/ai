#!/bin/sh

echo "This script follows https://wiki.archlinux.org/index.php/Beginners'_guide"
echo "Before running it, make sure you have:"
echo " 1) established (and tested) an internet connection"
echo " 2) partitioned the disk(s)"
echo " 3) created the filesystem(s) and activated any swap partitions"
echo " 4) mounted the root (/) partition at /mnt, e.g. 'mount /dev/sda1 /mnt'"
# By default, I recommend a SWAP (half max RAM supported by mobo) and root (rest of the space) partition
# See: https://wiki.archlinux.org/index.php/Suspend_and_hibernate#About_swap_partition.2Ffile_size for SWAP size logic
read -p "Press [Enter] to begin."

echo :::
echo It will take a few minutes--or longer on a slow connection--for pacstrap to run,
echo so be patient and do not touch anything if you want this script to finish successfully!
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
