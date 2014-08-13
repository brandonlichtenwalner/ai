#!/bin/bash

# Meant to be run right after a fresh Arch Linux Installation
# Gets all of the necessities set up

# variables
USER1=one
USER2=two
# list packages you want/need or uncomment packages below as needed/desired
VIDEO=""
#VIDEO="xf86-video-vesa"
#VIDEO="xf86-video-nouveau lib32-nouveau-dri"
#VIDEO="xf86-video-ati lib32-ati-dri"
LAPTOP=""
#LAPTOP="xf86-input-synaptics"

# the first user is assumed to be an admin user
useradd -m -G users,games,wheel -s /bin/bash $USER1
echo :::
echo Set password for $USER1
passwd $USER1

useradd -m -G users,games -s /bin/bash $USER2
echo:::
echo Set password for $USER2
passwd $USER2

# assuming no swap partition was created during install, create/use a swap file
fallocate -l 512M /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo /swapfile none swap defaults 0 0 >> /etc/fstab

echo :::
echo You need to uncomment 2 lines in /etc/pacman.conf to enable multilib assuming you are on a 64-bit system (and want/need to use multilib).
echo You may also want to configure a few other options there.
read -p "Press [Enter] to continue on to editing pacman.conf"
nano /etc/pacman.conf

echo :::
echo Updating repositories for multi-lib...
pacman -Syyu

# install essentials for a GUI environment
echo :::
echo Installing common packages
pacman -S alsa-utils dkms mesa rsync sudo ttf-dejavu wget xorg-server xorg-server-utils xorg-xinit $VIDEO $LAPTOP
echo:::
echo Installing needed base-devel packages for AUR builds
pacman -S --needed base-devel

systemctl enable dkms

# if running in Virtualbox uncomment the following and then remember to run it (as root)
#wget https://raw.github.com/brandonlichtenwalner/ai/master/vbox-guest-setup.sh
#chmod +x vbox-guest-setup.sh

# I am used to Yaourt as a front-end to the AUR, but you don't want to makepkg as root
cd /home/$USER1
wget https://raw.github.com/brandonlichtenwalner/arch-install/master/misc/yaourt-setup.sh
chmod +x yaourt-setup.sh
chown $USER1:$USER1 yaourt-setup.sh
# Also grab the script to set up the GUI environment and applications
wget https://raw.github.com/brandonlichtenwalner/arch-install/master/enlightenment/enlightenment-setup.sh
chmod +x enlightenment-setup.sh
chown $USER1:$USER1 enlightenment-setup.sh
# And grab the post-install.txt file for each user
wget https://raw.github.com/brandonlichtenwalner/arch-install/master/enlightenment/enlightenment-post-install.txt
chown $USER1:$USER1 enlightenment-post-install.txt
cd /home/$USER2
wget https://raw.github.com/brandonlichtenwalner/arch-install/master/enlightenment/enlightenment-post-install.txt
chown $USER2:$USER2 enlightenment-post-install.txt
cd

echo :::
echo You need to uncomment the line in the sudoers file to allow members of the wheel group to use sudo.
echo You may also want to add: Defaults:$USER1 timestamp_timeout=20 to the end of the file.
read -p "Press [Enter] to launch visudo to edit the sudoers file."
EDITOR=nano visudo

# I never really got into vi...
echo EDITOR=nano >> /etc/environment

echo :::
echo Remember to run alsamixer to unmute your sound.
echo Then log in as $USER1 and run yaourt-setup.sh to install Yaourt.

rm post-install.sh
