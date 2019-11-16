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
#nome root
echo "NOME ROOT"
read nome
echo "SENHA ROOT"
read root_senha
#nome usuario
echo "NOME USUARIO"
read usuario
echo "SENHA USUARIO"
read usr_usuario

#FORMATAR HD


cfdisk 

mkfs.ext4 $boot -L Boot 1> /dev/null 2> /dev/stdout
sleep 1
echo "formatando BOOT"
sleep 1
clear 
mkfs.ext4 $raiz -L Raiz 1> /dev/null 2> /dev/stdout
sleep 1
echo "formatando RAIZ"
sleep 1
clear 
mkfs.ext4 $home -L Home  1> /dev/null 2> /dev/stdout
sleep 1
echo "formatando HOME"
sleep 1
clear 
mkswap -L swap $swap && swapon $swap
sleep 1
echo "montando SWAP"
sleep 1
clear 
mount $raiz /mnt 
sleep 1
echo "montando MNT"
sleep 1
clear 
mkdir /mnt/boot && mount $boot /mnt/boot
sleep 1
echo "montando BOOT"
sleep 1
clear 
mkdir /mnt/home && mount $home /mnt/home 
sleep 1
echo "montando HOME"
sleep 1
clear 
sed -i '/^#\[multilib\]/{s/^#//;n;s/^#//;n;s/^#//}' /etc/pacman.conf 
sleep 1
clear 
pacstrap /mnt base base-devel linux linux-firmware nano sudo man-db dhcpcd git usbutils diffutils
sleep 1
echo "instalando pacstrap"
sleep 1
clear 
genfstab -U -p /mnt >> /mnt/etc/fstab 
sleep 1
echo "entrando chroot"
sleep 1
clear 
arch-chroot /mnt << EOF
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
# Sets hostname
echo $nome > /etc/hostname;

sed -i 's/#\('pt_BR.UTF-8'\)/\1/' /etc/locale.gen
sed -i 's/#\('pt_BR'\)/\1/' /etc/locale.gen

systemctl enable dhcpcd.service;

echo -e "KEYMAP=br-abnt2\nFONT=lat0-16\nFONT_MAP=" >> /etc/vconsole.conf
sleep 1
echo  "LANG=pt_BR.UTF-8" >> /etc/locale.conf
loadkeys /usr/share/kbd/keymaps/i386/qwerty/br-abnt2.map.gz

locale-gen

ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
echo America/Sao_Paulo > /etc/timezone
hwclock --systohc --utc

mkinitcpio -p linux;
pacman -S grub;
grub-install --target=i386-pc --recheck --debug /dev/sda;
mkdir -p /boot/grub/locale;
cp /usr/share/locale/en\@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en.mo;
sudo pacman -S gvfs-mtp ntfs-3g

pacman -S os-prober;
os-prober;
grub-mkconfig -o /boot/grub/grub.cfg;

#echo -e $root_senha"\n"$root_senha | passwd
passwd << EOF
$root_senha
$root_senha
EOF

useradd -m -G audio,dbus,lp,network,optical,power,storage,users,video,wheel -s /bin/bash $nome;
passwd "$usuario" << EOF
$usr_usuario
$usr_usuario
EOF
EOF
sleep 1
exit

SLEEP 1
umount /mnt/boot
umount /mnt/home
reboot
