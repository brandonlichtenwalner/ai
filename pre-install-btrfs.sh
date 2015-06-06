#!/bin/sh

mkfs.fat -F32 /dev/sda1
swapon /dev/sdb1 /dev/sdc1 /dev/sdd1 /dev/sde1
mkfs.btrfs -f -m raid10 -d raid10 /dev/sda2 /dev/sdb2 /dev/sdc2 /dev/sdd2 /dev/sde2

mount /dev/sda2 /mnt
cd /mnt
btrfs subvolume create slash
btrfs subvolume set-default 258 .
cd
umount /mnt
mount -o noatime,autodefrag,compress=lzo,space_cache /dev/sda2 /mnt

mkdir /mnt/boot
mount /dev/sda1 /mnt/boot

wget https://raw.githubusercontent.com/brandonlichtenwalner/arch-install/master/setup.sh

lsblk -o name,size,mountpoint,fstype,uuid,serial,state,mode
btrfs filesystem show
