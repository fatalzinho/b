#!/bin/bash

sudo pacman -Syy
pkg="linux-zen-headers 
nvidia-390xx-dkms nvidia-390xx-libgl nvidia-390xx-utils lib32-nvidia-390xx-libgl 
opencl-nvidia nvidia-settings 
seaudio paprefs pavucontrol pulseaudio-alsa lib32-libpulse lib32-alsa-plugins 
pulseaudio-alsa lib32-libpulse lib32-alsa-plugins" 
 

sudo pacman -S $pkg --noconfirm

pkglxde="gpicview-gtk3
lxappearance-gtk3
lxappearance-obconf-gtk3
lxde-common
lxde-icon-theme
lxdm
lxhotkey-gtk3
lxinput-gtk3
lxlauncher-gtk3
lxmusic-gtk3
lxpanel-gtk3
lxrandr-gtk3
lxsession-gtk3
lxtask-gtk3
lxterminal
openbox
pcmanfm-gtk3 
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
neofetch"

sudo pacman -S $pkglxde --noconfirm

pkdtheme="gtk-theme-switch2 
mate-icon-theme 
materia-gtk-theme 
gnome-icon-theme-extras
mate-icon-theme-faenza 
mate-themes 
arc-gtk-theme" 


sudo pacman -S $pkdtheme --noconfirm

sudo rmmod snd_pcm_oss

sudo systemctl enable lxdm.service
sudo echo  "exec startxlxde" >> ~/.xinitrc
#sudo xdg-user-dirs-update
 
#fc-cache -vf
sudo timedatectl set-ntp true

cd /tmp/
git clone https://aur.archlinux.org/mugshot.git
cd mugshot
makepkg -si --noconfirm

