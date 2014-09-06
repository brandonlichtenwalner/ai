#!/bin/bash

# Custom LXDE with Cairo-Dock

echo :::
echo Installing custom LXDE environment
pacman -S cairo-dock-plugins gnome-icon-theme-extras gvfs libical lxde xcompmgr

# To enable system monitor plugin in Cairo-Dock
# sudo pacman -S lm_sensors

systemctl enable lxdm

echo :::
echo "Configuring xcompmgr and cairo-dock to autostart for user(s)..."

mkdir /home/$USER1/.config/lxsession
mkdir /home/$USER1/.config/lxsession/LXDE
echo '@xcompmgr -c -C -t-5 -l-5 -r4.2 -o.55' >> /home/$USER1/.config/lxsession/LXDE/autostart
echo '@cairo-dock -c' >> /home/$USER1/.config/lxsession/LXDE/autostart
chown -R $USER1:$USER1 /home/$USER1/.config/lxsession

if [ "$USER2" != "" ]; then
  mkdir /home/$USER2/.config/lxsession
  mkdir /home/$USER2/.config/lxsession/LXDE
  echo '@xcompmgr -c -C -t-5 -l-5 -r4.2 -o.55' >> /home/$USER2/.config/lxsession/LXDE/autostart
  echo '@cairo-dock -c' >> /home/$USER2/.config/lxsession/LXDE/autostart
  chown -R $USER2:$USER2 /home/$USER2/.config/lxsession
fi

echo :::
echo "LXDE setup complete."
echo "Please see the lxde-post-install.txt file for additional--per user--configuration steps, if any."

rm lxde-setup.sh
