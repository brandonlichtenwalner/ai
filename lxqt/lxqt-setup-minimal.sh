#!/bin/bash

# LXQt with LightDM
# Set up to run as a normal user with sudo

echo :::
echo Making sure all packages are up to date...
yaourt -Syua
echo :::
echo Installing basic LXQt environment
yaourt -S lxqt-desktop-git pcmanfm-qt-git openbox qterminal-git obconf-qt-git lxqt-lightdm-greeter-git oxygen-icons qtcurve-gtk2 qtcurve-qt4 qtcurve-qt5 qtcurve-utils

sudo systemctl enable lightdm

rm lxqt-setup-minimal.sh
