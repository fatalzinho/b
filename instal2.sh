#!/bin/bash
function espera() {
	read -p "$1 Tecle <ENTER> para continuar..." a;
	unset a;

#sudo pacman -S intel-ucode
pacman -S nvidia-390xx nvidia-390xx-libgl nvidia-390xx-utils lib32-nvidia-390xx-libgl 
pacman -S  alsa-util salsa-lib alsa-plugins alsa-firmware pulseaudio paprefs pavucontrol 
pacman -S pulseaudio-alsa lib32-libpulse lib32-alsa-plugins
rmmod snd_pcm_oss
#lib32-nvidia-libgl 
#lib32-nvidia-utils
#nvidia
#nvidia-ck-k10
#nvidia-libgl
#nvidia-utils
#opencl-nvidia
lspci -k | grep -A 2 -E "(VGA|3D)"
espera
pacman -S xfce4 xfce4-goodies lightdm lightdm-gtk-greeter networkmanager network-manager-applet --noconfirm
systemctl enable lightdm
systemctl enable NetworkManager
#pacman -S lxde lxdm --noconfirm
#systemctl enable lxdm.service
#echo  "exec startlxde" >> ~/.xinitrc
pacman -S xdg-user-dirs --noconfirm
xdg-user-dirs-update
