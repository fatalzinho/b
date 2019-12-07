#!/bin/bash

#Pedacinho do meu script pra ajudar com a NVIDIA: 😎

#Só precisa saber se sua nvidia usa o driver "nvidia" ou "nvidia-390xx", e precisa obviamente ter o base-devel e linux-header (para cada kernel que usar) instalados:

#DRIVER
export _NVIDIA_='nvidia-390xx'
export _NV_BOARDNAME_=$(lspci | grep VGA | cut -d ":" -f3 | cut -d "[" -f2 | cut -d "]" -f1)

sudo pacman -Syy
sudo pacman -S --needed $_NVIDIA_-dkms linux-headers

#CONFIGURAÇÃO DO XORG
cat << EOF | sudo tee /etc/X11/xorg.conf.d/20-nvidia.conf
Section "Device"
    Identifier      "Device0"
    Driver          "nvidia"
    VendorName      "NVIDIA Corporation"
    BoardName       "$_NV_BOARDNAME_"
    Option          "NoLogo" "true"
    Option          "AllowEmptyInitialConfiguration"
    Option          "metamodes" "nvidia-auto-select +0+0 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}"
    Option          "AllowIndirectGLXProtocol" "off"
    Option          "TripleBuffer" "On"
    Option          "DPI" "96 x 96"
    Option          "ConnectToAcpid" "0"
    Option          "NoFlip"
EndSection
EOF

#MÓDULOS DO KERNEL (DRM)
sudo sed -i 's/^MODULES=(/&nvidia nvidia_modeset nvidia_uvm nvidia_drm/' /etc/mkinitcpio.conf

sudo mkinitcpio -P

#CONFIGURAÇAO DO GRUB
sudo sed -i 's/^GRUB_CMDLINE_LINUX="/&nvidia-drm.modeset=1 /' /etc/default/grub
sudo sed -i 's/^GRUB_GFXMODE=/&1920x1080x32,/' /etc/default/grub
sudo sed -i "/GRUB_GFXPAYLOAD_LINUX/"'s/^#//' /etc/default/grub

sudo grub-mkconfig -o /boot/grub/grub.cfg

#LIBS
sudo pacman -S --needed lib32-$_NVIDIA_-utils $_NVIDIA_-settings {lib32-,}opencl-nvidia {lib32-,}libvdpau libva-vdpau-driver {lib32-,}libva-vdpau-driver

#Com isso já para brincar.
