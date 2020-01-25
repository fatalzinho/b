#!/bin/bash
sudo pacman -Syy
sudo timedatectl set-ntp true

# Instalação driver de VIDEO e SOM
pkg="linux-zen-headers 
nvidia-390xx-dkms nvidia-390xx-libgl nvidia-390xx-utils lib32-nvidia-390xx-libgl 
opencl-nvidia nvidia-settings 
pulseaudio paprefs pavucontrol pulseaudio-alsa lib32-libpulse lib32-alsa-plugins 
pulseaudio-alsa lib32-libpulse lib32-alsa-plugins" 
sudo pacman -S $pkg --noconfirm
sudo rmmod snd_pcm_oss

# Instalação DESKTOP e APLICATIVOS
pkgxfce4="xfce4 
xfce4-goodies
xdg-user-dirs 
thunar 
gparted 
lxdm 
sddm 
firefox 
firefox-i18n-pt-br 
ttf-dejavu ttf-liberation noto-fonts 
p7zip unrar tar rsync 
file-roller 
playonlinux 
telegram-desktop 
neofetch"
sudo pacman -S $pkgxfce4 --noconfirm
sudo echo  "exec startxfce" >> ~/.xinitrc
sudo systemctl enable sddm.service

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
cd /Documentos/
git clone https://aur.archlinux.org/mugshot.git
cd mugshot
makepkg -si --noconfirm

cd /Documentos/
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm

reboot

# Depois quem entra no desktop mudar janela de XFWM4 para OPENBOX
#killall openbox
#xfwm4 --replace &

