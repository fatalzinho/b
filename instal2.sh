#!/bin/bash

#sudo pacman -S intel-ucode
sudo pacman -S nvidia-390xx nvidia-390xx-libgl nvidia-390xx-utils lib32-nvidia-390xx-libgl 
sudo pacman -S opencl-nvidiapul nvidia-settings seaudio paprefs pavucontrol 
sudo pacman -S pulseaudio-alsa lib32-libpulse lib32-alsa-plugins gparted
sudo rmmod snd_pcm_oss
#lspci -k | grep -A 2 -E "(VGA|3D)"
sudo pacman -S xfce4 xfce4-goodies lxdm  
sudo systemctl enable lxdm.service
sudo systemctl enable NetworkManager
sudo echo  "exec startxfce4" >> ~/.xinitrc
sudo pacman -S xdg-user-dirs --noconfirm
sudo xdg-user-dirs-update
sudo pacman -S gnome-software gnome-software-packagekit-plugin lightdm-gtk-greeter-settings 
sudo pacman -S xfce4-whiskermenu-plugin firefox firefox-i18n-pt-br 
sudo pacman -S thunar gtk-theme-switch2 mate-icon-theme materia-gtk-theme gnome-icon-theme-extras 
sudo pacman -S mate-icon-theme-faenza mate-themes arc-gtk-theme xfce4-taskbar-plugin 
sudo pacman -S ttf-dejavu ttf-liberation noto-fonts 
fc-cache -vf
sudo timedatectl set-ntp true
sudo pacman -S  p7zip unrar tar rsync file-roller neofetch

cd /tmp/
git clone https://aur.archlinux.org/mugshot.git
cd mugshot
makepkg -si --noconfirm

cd /tmp/
git clone https://aur.archlinux.org/google-chrome.git
cd google-chrome
makepkg -si --noconfirm
neofetch
