#!/bin/bash
sudo pacman -Syy
pkg="linux-zen-headers 
nvidia-390xx-dkms nvidia-390xx-libgl nvidia-390xx-utils lib32-nvidia-390xx-libgl 
opencl-nvidia nvidia-settings 
seaudio paprefs pavucontrol pulseaudio-alsa lib32-libpulse lib32-alsa-plugins 
pulseaudio-alsa lib32-libpulse lib32-alsa-plugins" 
 

sudo pacman -S $pkg --noconfirm

pkgxfce4="xfce4 
xfce4-goodies
xdg-user-dirs 
thunar 
gparted 
lxdm 
firefox 
firefox-i18n-pt-br 
ttf-dejavu ttf-liberation noto-fonts 
xfce4-taskbar-plugin 
p7zip unrar tar rsync 
file-roller 
neofetch"

sudo pacman -S $pkgxfce4 --noconfirm

pkdtheme="gtk-theme-switch2 
mate-icon-theme 
materia-gtk-theme 
gnome-icon-theme-extras
mate-icon-theme-faenza 
mate-themes 
arc-gtk-theme" 

sudo echo  "exec startxfce" >> ~/.xinitrc

sudo pacman -S $pkdtheme --noconfirm

sudo rmmod snd_pcm_oss

sudo systemctl enable lxdm.service

sudo xdg-user-dirs-update
 
#fc-cache -vf
sudo timedatectl set-ntp true

cd /tmp/
git clone https://aur.archlinux.org/mugshot.git
cd mugshot
makepkg -si --noconfirm
reboot
