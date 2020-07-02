#!/bin/bash

# Install the Tela Icon Theme (It's forked on 3 icon themes lolwut?????)
mkdir ~/.icons
# Sneak in all apt dependencies here
sudo apt install wget unzip sassc plank
cd ~ && mkdir tangible && cd tangible
wget -O tela.zip https://codeload.github.com/vinceliuice/Tela-icon-theme/zip/master
unzip ./tela.zip
cd ./Tela-icon-theme-master
mv src ~/.icons/tela-icon-theme
xfconf-query -c xsettings -p /Net/IconThemeName -s "%NAME%"

# Now install the Materia theme
mkdir ~/.themes
cd ~/tangible
wget -O materia.zip https://codeload.github.com/nana-4/materia-theme/zip/master
unzip ./materia.zip
cd ./materia-theme-master
sudo ./install.sh
xfconf-query -c xsettings -p /Net/ThemeName -s "Materia-dark"

# Removing specefic panels (the dock / bottom panel) from XFCE is impossible so let's prompt the user to do so
echo -n "Have you removed your XFCE Bottom Panel yet? If not, please do so. When ready type y for confirmation and n for exiting the script. (y/n)? "
read answer
if [ "$answer" != "${answer#[Yy]}" ] ;then
    mkdir ~/.config/autostart
    echo "[Desktop Entry]
    Type=Application
    Exec=plank
    Hidden=false
    NoDisplay=false
    Name[en_US]=plank
    Name=plank
    Comment[en_US]=plank
    " > ~/.config/autostart/plank.desktop
else
    echo "Exiting."
    echo "Exiting.."
    echo "Exiting..."
    exit
fi