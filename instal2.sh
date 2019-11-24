#!/bin/bash

#sudo pacman -S intel-ucode
sudo pacman -S nvidia-390xx nvidia-390xx-libgl nvidia-390xx-utils lib32-nvidia-390xx-libgl --noconfirm
sudo pacman -S  alsa-util salsa-lib alsa-plugins alsa-firmware pulseaudio paprefs pavucontrol --noconfirm
sudo pacman -S pulseaudio-alsa lib32-libpulse lib32-alsa-plugins --noconfirm
sudo rmmod snd_pcm_oss
#lib32-nvidia-libgl 
#lib32-nvidia-utils
#nvidia
#nvidia-ck-k10
#nvidia-libgl
#nvidia-utils
#opencl-nvidia
lspci -k | grep -A 2 -E "(VGA|3D)"
sudo pacman -S xfce4 xfce4-goodies lightdm lightdm-gtk-greeter networkmanager network-manager-applet --noconfirm
sudo systemctl enable lightdm
sudo systemctl enable NetworkManager
#pacman -S lxde lxdm --noconfirm
#systemctl enable lxdm.service
#echo  "exec startlxde" >> ~/.xinitrc
sudo pacman -S xdg-user-dirs --noconfirm
sudo xdg-user-dirs-update
sudo pacman -S gnome-software gnome-software-packagekit-plugin lightdm-gtk-greeter-settings --noconfirm
sudo pacman -S xfce4-whiskermenu-plugin firefox firefox-i18n-pt-b --noconfirm
sudo pacman -S thunar gtk-theme-switch2 mate-icon-theme materia-gtk-theme gnome-icon-theme-extras --noconfirm
sudo pacman -S mate-icon-theme-faenza mate-themes arc-gtk-theme xfce4-taskbar-plugin --noconfirm
sudo pacman -S ttf-dejavu ttf-liberation noto-fonts --noconfirm
fc-cache -vf

sudo git clone https://aur.archlinux.org/mugshot.git
sudo chmod 777 mugshot/
cd mugshot
makepkg -si --noconfirm

sudo git clone https://aur.archlinux.org/google-chrome.git
sudo chmod 777 google-chrome/
cd google-chrome
makepkg -si --noconfirm
