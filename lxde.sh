#!/bin/bash
sudo pacman -Syy
sudo timedatectl set-ntp true

# Instalação driver de VIDEO e SOM


# Instalação DESKTOP e APLICATIVOS
pkglxde="lxde-gtk3 
xdg-user-dirs 
thunar 
gparted 
gedit 
gnome-disk-utility 
firefox 
firefox-i18n-pt-br 
xfce4-panel 
xfce4-whiskermenu-plugin 
ttf-dejavu ttf-liberation noto-fonts 
p7zip unrar unzip tar rsync 
file-roller 
playonlinux 
telegram-desktop 
gnome-disk-utility 
neofetch"
sudo pacman -S $pkglxde --noconfirm
sudo systemctl enable lxdm.service
sudo echo  "exec startxlxde" >> ~/.xinitrc

# OUTROS
cd /tmp/
git clone https://aur.archlinux.org/mugshot.git
cd mugshot
makepkg -si --noconfirm

cd /tmp/
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm

reboot
