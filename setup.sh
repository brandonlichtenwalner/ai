#!/bin/bash

# This script follows https://wiki.archlinux.org/index.php/Beginners'_guide
# Before running it, make sure you have:
# 1) Established (and tested) an internet connection
# 2) Partitioned the disk (and changed the root partition below, if necessary)

mkfs.ext4 /dev/sda1
mount /dev/sda1 /mnt

pacstrap /mnt base

genfstab -U -p /mnt >> /mnt/etc/fstab

# download the ai-chrooted.sh script under /mnt
cd /mnt 
wget https://raw.github.com/brandonlichtenwalner/ai/master/chrooted.sh
chmod +x chrooted.sh
cd

arch-chroot /mnt /bin/bash
# the system will now be waiting for the arch-chroot to finish

# once the chroot is exited finish up with unmounting
unmount -R /mnt
echo ...and done. Now just reboot.
