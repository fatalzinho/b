#!/bin/bash
sudo git clone https://aur.archlinux.org/nvidia-340xx.git

sudo chmod +777 /nvidia-340xx/
cd /nvidia-340xx/
makepkg -si

sudo pacman -S lxde lxdm
systemctl enable lxdm.service

