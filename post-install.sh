#!/bin/bash

# Meant to be run right after a fresh Arch Linux Installation
# Gets all of the necessities set up

# variables
USER1=one
USER2=two
# list packages you want/need or uncomment packages below as needed/desired
VIDEO=""
#VIDEO="xf86-video-vesa"
#VIDEO="xf86-video-vesa xf86-video-nouveau lib32-nouveau-dri"
#VIDEO="xf86-video-vesa xf86-video-ati lib32-ati-dri"
LAPTOP=""
#LAPTOP="xf86-input-synaptics"

# the first user is assumed to be an admin user
useradd -m -G users,games,wheel -s /bin/bash $USER1
echo Set password for $USER1
passwd $USER1

useradd -m -G users,games -s /bin/bash $USER2
echo Set password for $USER2
passwd $USER2

# be sure we start with the most up-to-date packages.
pacman -Syyu

pacman -S alsa-utils dkms mesa ttf-dejavu wget xorg-server xorg-server-utils xorg-xinit $VIDEO $LAPTOP

systemctl enable dkms

# I am used to Yaourt as a front-end to the AUR, but you don't want to makepkg as root
cd /home/$USER1
wget https://raw.github.com/brandonlichtenwalner/ai/master/yaourt-setup.sh
chmod +x yaourt-setup.sh
chown $USER1:$USER1 yaourt-setup.sh
cd

echo You need to uncomment 2 lines in /etc/pacman.conf to enable multilib if you are on a 64-bit system.
echo You may also want to configure a few other options there.
echo launching nano in 5 seconds...
sleep 5
nano /etc/pacman.conf

echo Remember to run alsamixer to unmute sound.
echo Then log in as $USER1 and run yaourt-setup.sh to install Yaourt.
