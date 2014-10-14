#!/bin/bash

# Meant to be run right after a fresh Arch Linux Installation
# Gets all of the necessities set up

echo :::
echo Beginning post installation configuration...

echo :::
PS3='Please choose a video driver: '
options=("vesa" "nouveau" "ati" "vbox" "nogui")
select opt in "${options[@]}"
do
    case $opt in
        "vesa")
            VIDEO="xf86-video-vesa"
            echo :::
            echo You chose vesa.
            break
            ;;
        "nouveau")
            VIDEO="xf86-video-nouveau lib32-nouveau-dri"
            echo :::
            echo You chose nouveau.
            break
            ;;
        "ati")
            VIDEO="xf86-video-ati lib32-ati-dri"
            echo :::
            echo You chose ati.
            break
            ;;
        "vbox")
            VIDEO="vbox"
            echo :::
            echo You chose vbox for a VirtualBox install. No additional video driver will be installed.
            break
            ;;
        "nogui")
            VIDEO="nogui"
            echo :::
            echo You chose not to install a GUI.
            break
            ;;
        *) echo invalid option;;
    esac
done

echo :::
echo "Please enter any extra packages to install (e.g. xf86-input-synaptics if installing on a laptop):  "
read EXTRA

echo :::
echo "Please note, the first user will be given admin rights (i.e. added to the wheel group)"
echo "Please enter a name for the first user:  "
read USER1

# the first user is made an admin user
useradd -m -G users,games,wheel -s /bin/bash $USER1
echo :::
echo Set password for $USER1
passwd $USER1

echo :::
echo "Enter a name for the second user or press [Enter] to skip:  "
read USER2

if [ "$USER2" = "" ]; then
  echo "No second user added."
else
  useradd -m -G users,games -s /bin/bash $USER2
  echo :::
  echo Set password for $USER2
  passwd $USER2
fi

# I am back of the opinion that a dedicated swap partition is the way to go
# this is particularly the case if using btrfs as a traditional swap file (as below) will not work
#  
#echo :::
#echo "Enter size (512M is recommended) for swapfile or 0 to skip creating one:  "
#read SWAPSIZE
#
#if [ $SWAPSIZE != 0 ]; then
#  fallocate -l $SWAPSIZE /swapfile
#  chmod 600 /swapfile
#  mkswap /swapfile
#  swapon /swapfile
#  echo "/swapfile none swap defaults 0 0" >> /etc/fstab
#fi

echo :::
echo "You need to uncomment 2 lines in /etc/pacman.conf to enable multilib assuming you are on a 64-bit system (and want/need to use multilib)."
echo "You may also want to configure a few other options there."
read -p "Press [Enter] to continue on to editing pacman.conf"
nano /etc/pacman.conf

echo :::
echo Updating repositories...
pacman -Syyu

# install bare essentials
echo :::
echo "Installing bare essentials and extra specified packages..."
pacman -S btrfs-progs dkms dosfstools rsync sudo wget $EXTRA

if [ "$VIDEO" != "nogui" and "$VIDEO" != "vobx" ]; then
    # install essentials for a GUI environment
    echo :::
    echo "Installing common packages for GUI environment and selected video driver"
    pacman -S alsa-utils mesa ttf-dejavu xorg-server xorg-server-utils xorg-xinit $VIDEO
fi

systemctl enable dkms

echo :::
echo You need to uncomment the line in the sudoers file to allow members of the wheel group to use sudo.
echo You may also want to add: Defaults:$USER1 timestamp_timeout=20 to the end of the file.
read -p "Press [Enter] to launch visudo to edit the sudoers file."
EDITOR=nano visudo

# I never really got into vi...
echo EDITOR=nano >> /etc/environment

echo :::
PS3='Please choose your graphical environment: '
options=("enlightenment" "lxde" "mate" "none")
select opt in "${options[@]}"
do
    case $opt in
        "enlightenment")
            ENVIRONMENT=enlightenment
            DESKTOP=gtk
            echo :::
            echo You chose $ENVIRONMENT.
            break
            ;;
        "lxde")
            ENVIRONMENT=lxde
            DESKTOP=gtk
            echo :::
            echo You chose $ENVIRONMENT.
            break
            ;;
        "mate")
            ENVIRONMENT=mate
            DESKTOP=mate
            echo :::
            echo You chose $ENVIRONMENT.
            break
            ;;
        "none")
            DESKTOP=none
            echo :::
            echo You chose no graphical environment.
            break
            ;;
        *) echo invalid option;;
    esac
done

# Grab the script to set up the GUI environment and run it
wget https://github.com/brandonlichtenwalner/arch-install/raw/master/environments/$ENVIRONMENT-setup.sh
source $ENVIRONMENT-setup.sh

# And grab the post-install.txt file for each user
wget https://github.com/brandonlichtenwalner/arch-install/raw/master/environments/$ENVIRONMENT-post-install.txt
chown $USER1:$USER1 $ENVIRONMENT-post-install.txt
if [ "$USER2" != "" ]; then
  cd /home/$USER2
  wget https://github.com/brandonlichtenwalner/arch-install/raw/master/environments/$ENVIRONMENT-post-install.txt
  chown $USER2:$USER2 $ENVIRONMENT-post-install.txt
  cd
fi

# depnding on if this is a virtualbox install...
if [ "$VIDEO" = "vbox" ]; then
  echo :::
  echo Updating packages and installing virtualbox-guest-utils
  pacman -Syu virtualbox-guest-utils
  
  echo :::
  echo Enabling required modules and adding them to /etc/modules-load.d/virtualbox.conf
  modprobe -a vboxguest vboxsf vboxvideo
  
  echo vboxguest > /etc/modules-load.d/virtualbox.conf
  echo vboxsf >> /etc/modules-load.d/virtualbox.conf
  echo vboxvideo >> /etc/modules-load.d/virtualbox.conf

  echo :::
  echo Starting and enabling Virtual Box services
  VBoxClient-all
  systemctl enable vboxservice

  echo :::
  echo If there were no errors Virtualbox guest-additions are now ready.
else
  # grab the appropriate desktop-install file and run it
  if [ "$DESKTOP" != "none" ]; then
    wget https://github.com/brandonlichtenwalner/arch-install/raw/master/environments/desktop-install-$DESKTOP.sh
    source desktop-install-$DESKTOP.sh
  fi
fi

echo :::
PS3='Please choose your AUR helper: '
options=("yaourt" "none")
select opt in "${options[@]}"
do
    case $opt in
        "yaourt")
            AUR=yaourt
            echo :::
            echo You chose $AUR.
            break
            ;;
        "none")
            AUR=none
            echo :::
            echo You chose no AUR helper.
            break
            ;;
        *) echo invalid option;;
    esac
done

if [ "$AUR" != "none" ]; then
    echo "Installing needed base-devel packages for AUR builds"
    pacman -S --needed base-devel
    
    # it is not good to mkpkg as root, so...
    echo :::
    echo Downloading $AUR setup file.
    cd /home/$USER1
    wget https://github.com/brandonlichtenwalner/arch-install/raw/master/misc/$AUR-setup.sh
    chmod +x $AUR-setup.sh
    chown $USER1:$USER1 $AUR-setup.sh
    cd

    echo :::
    echo Remember to log in as $USER1 and run $AUR-setup.sh to install $AUR.
fi

if [ "$VIDEO" != "nogui" and "$VIDEO" != "vobx" ]; then
  echo :::
  echo "Don't forget to run alsamixer to unmute your sound."
fi

echo :::
echo Cleaning up: removing post-install.sh
read -p "Press [Enter] to continue or [CTRL+Z] to keep the file."
rm post-install.sh
