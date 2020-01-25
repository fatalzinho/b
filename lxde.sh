#!/bin/bash
sudo pacman -Syy
sudo timedatectl set-ntp true

# Instalação driver de VIDEO e SOM
pkg="linux-zen-headers 
nvidia-390xx-dkms nvidia-390xx-libgl nvidia-390xx-utils lib32-nvidia-390xx-libgl 
opencl-nvidia nvidia-settings 
seaudio paprefs pavucontrol pulseaudio-alsa lib32-libpulse lib32-alsa-plugins 
pulseaudio-alsa lib32-libpulse lib32-alsa-plugins" 
sudo pacman -S $pkg --noconfirm
sudo rmmod snd_pcm_oss

# Instalação DESKTOP e APLICATIVOS
pkglxde="lxde-gtk3 
xdg-user-dirs 
thunar 
gparted 
firefox 
firefox-i18n-pt-br 
xfce4-panel 
xfce4-whiskermenu-plugin 
ttf-dejavu ttf-liberation noto-fonts 
xfce4-taskbar-plugin 
p7zip unrar tar rsync 
file-roller 
playonlinux 
telegram-desktop 
neofetch"
sudo pacman -S $pkglxde --noconfirm
sudo systemctl enable lxdm.service
sudo echo  "exec startxlxde" >> ~/.xinitrc

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
