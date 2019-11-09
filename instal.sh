#!/bin/bash

boot=/dev/sda1
raiz=/dev/sda2
home=/dev/sda3
swap=/dev/sda4
pos_instalacao="sim";

function espera() {
	read -p "$1 Tecle <ENTER> para continuar..." a;
	unset a;
}
url="https://www.archlinux.org/mirrorlist/?country=BR&use_mirror_status=on"

  tmpfile=$(mktemp --suffix=-mirrorlist)

  # Get latest mirror list and save to tmpfile
  curl -so ${tmpfile} ${url}
  sed -i 's/^#Server/Server/g' ${tmpfile}

  # Backup and replace current mirrorlist file (if new file is non-zero)
  if [[ -s ${tmpfile} ]]; then
   { echo " Backing up the original mirrorlist..."
     mv -i /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.orig; } &&
   { echo " Rotating the new list into place..."
     mv -i ${tmpfile} /etc/pacman.d/mirrorlist; }
  else
    echo " Unable to update, could not download list."
  fi

#FORMATAR HD


cfdisk 

mkfs.ext4 $boot -L Boot 1> /dev/null 2> /dev/stdout
sleep 2
mkfs.ext4 $raiz -L Raiz 1> /dev/null 2> /dev/stdout
sleep 2
mkfs.ext4 $home -L Home  1> /dev/null 2> /dev/stdout
sleep 2
mkswap -L swap $swap && swapon $swap
sleep 2
mount $raiz /mnt 
sleep 1
mkdir /mnt/boot && mount $boot /mnt/boot
sleep 1
mkdir /mnt/home && mount $home /mnt/home 
sleep 1

sed -i '/^#\[multilib\]/{s/^#//;n;s/^#//;n;s/^#//}' /etc/pacman.conf 
sleep 1

pacstrap /mnt base base-devel linux linux-firmware nano sudo man-db
espera

genfstab -U -p /mnt >> /mnt/etc/fstab 
sleep 1
arch-chroot /mnt
