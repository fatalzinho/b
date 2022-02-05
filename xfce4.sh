#!/bin/bash
sudo pacman -Syy
sudo timedatectl set-ntp true

# Instalação driver de VIDEO e SOM
# Instalação DESKTOP e APLICATIVOS
pkgxfce4="xfce4 
xfce4-goodies
xdg-user-dirs 
thunar 
gparted 
lxdm 
 
gedit 
gnome-disk-utility 
firefox 
firefox-i18n-pt-br 
ttf-dejavu ttf-liberation noto-fonts 
p7zip unrar unzip tar rsync 
file-roller 
playonlinux 
telegram-desktop 
neofetch"
sudo pacman -S $pkgxfce4 --noconfirm
sudo echo  "exec startxfce" >> ~/.xinitrc
#sudo systemctl enable lxdm.service

sudo xdg-user-dirs-update

# Instalação de TEMAS
pkdtheme="gtk-theme-switch2 
mate-icon-theme 
materia-gtk-theme 
mate-icon-theme-faenza 
mate-themes 
arc-gtk-theme" 
sudo pacman -S $pkdtheme --noconfirm

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

# Depois quem entra no desktop mudar janela de XFWM4 para OPENBOX
#killall openbox
#xfwm4 --replace &

