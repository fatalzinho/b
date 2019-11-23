#!/bin/bash
#sudo pacman -S intel-ucode
sudo pacman -S nvidia-390xx nvidia-390xx-libgl nvidia-390xx-utils lib32-nvidia-390xx-libgl 
sudo pacman -S  alsa-util salsa-lib alsa-plugins alsa-firmware pulseaudio paprefs pavucontrol 
sudo pacman -S pulseaudio-alsa lib32-libpulse lib32-alsa-plugins
sudo rmmod snd_pcm_oss
#lib32-nvidia-libgl 
#lib32-nvidia-utils
#nvidia
#nvidia-ck-k10
#nvidia-libgl
#nvidia-utils
#opencl-nvidia
lspci -k | grep -A 2 -E "(VGA|3D)"
sudo pacman -S lxde lxdm --noconfirm
sudo systemctl enable lxdm.service
sudo echo  "exec startlxde" >> ~/.xinitrc
sudo pacman -S xdg-user-dirs --noconfirm
sudo xdg-user-dirs-update
pacman -S network-manager-applet --noconfirm
sudo hwclock — systohc — utc
