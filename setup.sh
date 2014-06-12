#!/bin/bash

# This script follows https://wiki.archlinux.org/index.php/Beginners'_guide
# Before running it, make sure you have:
# 1) Established (and tested) an internet connection
# 2) Partitioned the disk (and changed the root partition below, if necessary)

echo Starting initial setup in 5 seconds.
echo It will take a few minutes--or longer on a slow connection--for pacstrap to run,
echo so be patient and do not touch anything if you want this script to complete successfully!
sleep 5

mkfs.ext4 /dev/sda1
mount /dev/sda1 /mnt

pacstrap /mnt base

genfstab -U -p /mnt >> /mnt/etc/fstab

# download the chrooted.sh and post-install.sh scripts into /mnt
cd /mnt 
echo Grabbing the chroot and post-installation scripts...
wget https://raw.github.com/brandonlichtenwalner/arch-install/master/chrooted.sh
chmod +x chrooted.sh
cd /mnt/root
wget https://raw.github.com/brandonlichtenwalner/arch-install/master/post-install.sh
chmod +x post-install.sh
cd

arch-chroot /mnt /bin/bash
# the system will now be waiting for the arch-chroot to finish

# once the chroot is exited finish up with unmounting
umount -R /mnt
echo ...and done. Now just -reboot-.
