#!/bin/bash

# Meant to be run right after a fresh Arch Linux Installation
# Gets all of the necessities set up

echo ":::"
echo "Beginning post installation configuration..."

echo ":::"
PS3='Please choose a video driver: '
options=("vesa" "nouveau-multilib" "nvidia-304xx" "ati-multilib" "vbox" "nogui")
select opt in "${options[@]}"
do
    case $opt in
        "vesa")
            VIDEO="xf86-video-vesa"
            echo ":::"
            echo "You chose vesa."
            break
            ;;
        "nouveau-multilib")
            VIDEO="xf86-video-nouveau lib32-nouveau-dri"
            echo ":::"
            echo "You chose nouveau-multilib."
            break
            ;;
        "nvidia-304xx")
            VIDEO="nvidia-304xx"
            echo ":::"
            echo "You chose nvidia-304xx."
            break
            ;;
        "ati-multilib")
            VIDEO="xf86-video-ati lib32-ati-dri"
            echo ":::"
            echo "You chose ati-multilib."
            break
            ;;
        "vbox")
            VIDEO="vbox"
            echo ":::"
            echo "You chose vbox for a VirtualBox install. No additional video driver will be installed."
            break
            ;;
        "nogui")
            VIDEO="nogui"
            echo ":::"
            echo "You chose not to install a GUI."
            break
            ;;
        *) echo invalid option;;
    esac
done

echo ":::"
echo "Please enter a name for the first user:  "
read USER1

echo ":::"
echo "Please enter a comma separated list of group(s) for $USER1 (e.g. users,wheel,games):  "
read GROUPS1

# add e.g. '-u 2000' to specify a user ID above the normal (beginning at 1000) range
# add the '-U' flag to create a group named after the user and add the user to that group
useradd -m -G "$GROUPS1" -s /bin/bash "$USER1"
echo ":::"
echo "Set password for $USER1"
passwd "$USER1"

echo ":::"
echo "Enter a name for the second user or press [Enter] to skip:  "
read USER2

if [ "$USER2" = "" ]; then
  echo "No second user added."
else
  echo "Please enter a comma separated list of group(s) for $USER2 (e.g. users,games):  "
  read GROUPS2

  useradd -m -G "$GROUPS2" -s /bin/bash "$USER2"
  echo ":::"
  echo "Set password for $USER2"
  passwd "$USER2"
fi

echo ":::"
echo "You need to uncomment 2 lines in /etc/pacman.conf if you wish to enable multilib on a 64-bit system."
echo "You may also want to configure a few other options there."
read -p "Press [Enter] to continue on to editing pacman.conf"
nano /etc/pacman.conf

echo ":::"
echo "Updating repositories..."
pacman -Syyu

echo ":::"
echo "Please enter any extra packages to install."
echo "e.g. xf86-input-synaptics on a laptop and/or desired filesystem tools like btrfs-progs:  "
read EXTRA

# install bare essentials
echo ":::"
echo "Installing bare essentials and extra specified packages..."
pacman -S --needed rsync sudo wget "$EXTRA"

echo ":::"
echo "You need to uncomment the line in the sudoers file to allow members of the wheel group to use sudo."
echo "You may also want to add: Defaults:USERNAME timestamp_timeout=20 to the end of the file for any admin users."
read -p "Press [Enter] to launch visudo to edit the sudoers file."

# I never really got into vi...
EDITOR=nano visudo
echo EDITOR=nano >> /etc/environment

if [ "$VIDEO" != "nogui" ] && [ "$VIDEO" != "vbox" ]; then
    # install essentials for a GUI environment
    echo ":::"
    echo "Installing common packages for GUI environment and selected video driver"
    pacman -S alsa-utils mesa ttf-dejavu xorg-server xorg-server-utils xorg-xinit $VIDEO
fi

# if this is a virtualbox install...
if [ "$VIDEO" = "vbox" ]; then
  echo ":::"
  echo "Updating packages, installing common GUI packages, and installing virtualbox-guest-utils"
  pacman -Syu dkms mesa ttf-dejavu virtualbox-guest-utils xorg-server xorg-server-utils xorg-xinit
  
  echo ":::"
  echo "Enabling required modules and adding them to /etc/modules-load.d/virtualbox.conf"
  modprobe -a vboxguest vboxsf vboxvideo
  
  echo vboxguest > /etc/modules-load.d/virtualbox.conf
  echo vboxsf >> /etc/modules-load.d/virtualbox.conf
  echo vboxvideo >> /etc/modules-load.d/virtualbox.conf

  echo ":::"
  echo "Starting and enabling Virtual Box services"
  VBoxClient-all
  systemctl enable vboxservice

  echo ":::"
  echo "If there were no errors Virtualbox guest-additions are now ready."
fi

echo ":::"
echo "Downloading extra package-install scripts for $USER1."
cd /home/"$USER1"
wget "https://github.com/brandonlichtenwalner/arch-install/raw/master/package-install/"
chown -R "$USER1:$USER1" package-install

if [ "$VIDEO" != "nogui" ] && [ "$VIDEO" != "vobx" ]; then
  echo ":::"
  echo "Don't forget to run alsamixer to unmute your sound."
fi

echo ":::"
echo "Cleaning up: removing post-install.sh"
read -p "Press [Enter] to continue or [CTRL+Z] to exit and keep the file."
rm post-install.sh
