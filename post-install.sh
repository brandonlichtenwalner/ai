#!/bin/bash

# Meant to be run right after a fresh Arch Linux Installation
# Gets all of the necessities set up

echo :::
echo Beginning post installation configuration...

echo :::
PS3='Please choose a video driver: '
options=("vesa" "nouveau" "ati" "Quit")
do
    case $opt in
        "vesa")
            VIDEO="xf86-video-vesa"
            echo :::
            echo You chose vesa.
            ;;
        "nouveau")
            VIDEO="xf86-video-nouveau lib32-nouveau-dri"
            echo :::
            echo You chose nouveau.
            ;;
        "ati")
            VIDEO="xf86-video-ati lib32-ati-dri"
            echo :::
            echo You chose ati.
            ;;
        "Quit")
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

echo :::
echo "Enter size (512M is recommended) for swapfile or 0 to skip creating one:  "
read SWAPSIZE

if [ $SWAPSIZE != 0 ]; then
  fallocate -l $SWAPSIZE /swapfile
  chmod 600 /swapfile
  mkswap /swapfile
  swapon /swapfile
  echo "/swapfile none swap defaults 0 0" >> /etc/fstab
fi

echo :::
echo You need to uncomment 2 lines in /etc/pacman.conf to enable multilib assuming you are on a 64-bit system (and want/need to use multilib).
echo You may also want to configure a few other options there.
read -p "Press [Enter] to continue on to editing pacman.conf"
nano /etc/pacman.conf

echo :::
echo Updating repositories...
pacman -Syyu

# install essentials for a GUI environment
echo :::
echo Installing common packages for GUI environment, video driver, and extra packages specified
pacman -S alsa-utils dkms mesa rsync sudo ttf-dejavu wget xorg-server xorg-server-utils xorg-xinit $VIDEO $EXTRA
echo:::
echo Installing needed base-devel packages for AUR builds
pacman -S --needed base-devel

systemctl enable dkms

# I am used to Yaourt as a front-end to the AUR, but you don't want to makepkg as root
cd /home/$USER1
wget https://github.com/brandonlichtenwalner/arch-install/master/misc/yaourt-setup.sh
chmod +x yaourt-setup.sh
chown $USER1:$USER1 yaourt-setup.sh

echo :::
PS3='Please choose your graphical environment:  '
options=("enlightenment" "lxde" "Quit")
do
    case $opt in
        "enlightenment")
            ENVIRONMENT=enlightenment
            echo :::
            echo You chose $ENVIRONMENT.
            ;;
        "lxde")
            ENVIRONMENT=lxde
            echo :::
            echo You chose $ENVIRONMENT.
            ;;
        "Quit")
            break
            ;;
        *) echo invalid option;;
    esac
done

# Also grab the script to set up the GUI environment and applications
wget https://github.com/brandonlichtenwalner/arch-install/raw/master/environments/$ENVIRONMENT-setup.sh
chmod +x $ENVIRONMENT-setup.sh
chown $USER1:$USER1 $ENVIRONMENT-setup.sh

# And grab the post-install.txt file for each user
wget https://github.com/brandonlichtenwalner/arch-install/raw/master/environments/$ENVIRONMENT-post-install.txt
chown $USER1:$USER1 $ENVIRONMENT-post-install.txt
if [ "$USER2" != "" ]; then
  cd /home/$USER2
  wget https://github.com/brandonlichtenwalner/arch-install/raw/master/environments/$ENVIRONMENT-post-install.txt
  chown $USER2:$USER2 $ENVIRONMENT-post-install.txt
fi

cd

echo :::
echo You need to uncomment the line in the sudoers file to allow members of the wheel group to use sudo.
echo You may also want to add: Defaults:$USER1 timestamp_timeout=20 to the end of the file.
read -p "Press [Enter] to launch visudo to edit the sudoers file."
EDITOR=nano visudo

# I never really got into vi...
echo EDITOR=nano >> /etc/environment

echo :::
echo "Type 'vbox' if this is a Virtualbox guest install or just [Enter] otherwise: "
read VBOX

if [ "$VBOX" ="vbox" ]; then
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
fi

echo :::
echo Remember to run alsamixer to unmute your sound.
echo Then log in as $USER1 and run yaourt-setup.sh to install Yaourt.

rm post-install.sh
