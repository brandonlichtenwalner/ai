#!/bin/bash

# Meant to be run right after a fresh Arch Linux Installation
# Gets all of the necessities set up without committing to any particular WM/DE

# variables
USER1=one
USER2=two

# the first user is assumed to be an admin user
useradd -m -g -G users,games,wheel -s /bin/bash $USER1
echo Set password for $USER1
passwd $USER1

useradd -m -g -G users,games -s /bin/bash $USER2
echo Set password for $USER2
passwd $USER2

# be sure we start with the most up-to-date packages.
pacman -Syyu

pacman -S alsa-utils

echo Remember to run alsamixer to unmute sound.
