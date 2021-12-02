#!/bin/bash
raiz=/dev/sda2

swap=/dev/sda1

pkgxfce4="xfce4 
xfce4-goodies
xdg-user-dirs 
thunar 
gparted 
sddm
gedit 
gnome-disk-utility 
firefox 
firefox-i18n-pt-br 
ttf-dejavu ttf-liberation noto-fonts 
p7zip unrar unzip tar rsync 
file-roller 
playonlinux 
telegram-desktop 
neofetch"

pkdtheme="gtk-theme-switch2 
mate-icon-theme 
materia-gtk-theme 
mate-icon-theme-faenza 
mate-themes 
arc-gtk-theme" 

function espera() {
	read -p "$1 Tecle <ENTER> para continuar..." a;
	unset a;
}
#url="https://www.archlinux.org/mirrorlist/?country=BR&use_mirror_status=on"

 # tmpfile=$(mktemp --suffix=-mirrorlist)

  # Get latest mirror list and save to tmpfile
  #curl -so ${tmpfile} ${url}
 # sed -i 's/^#Server/Server/g' ${tmpfile}

  # Backup and replace current mirrorlist file (if new file is non-zero)
 # if [[ -s ${tmpfile} ]]; then
 #  { echo " Backing up the original mirrorlist..."
 #    mv -i /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bkp; } &&
 #  { echo " Rotating the new list into place..."
  #   mv -i ${tmpfile} /etc/pacman.d/mirrorlist; }
 # else
 #   echo " Unable to update, could not download list."
#  fi

reflector --verbose --latest 4 --sort rate --country Brazil --save /etc/pacman.d/mirrorlist

if [ "$(uname -m)" = "x86_64" ]
then
        cp /etc/pacman.conf /etc/pacman.conf.bkp
        # Adds multilib repository
        sed '/^#\[multilib\]/{s/^#//;n;s/^#//;n;s/^#//}' /etc/pacman.conf > /tmp/pacman
        mv /tmp/pacman /etc/pacman.conf
fi
#chmod 644 /etc/pacman.d/mirrorlist
pacman -Syy
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

sleep 1
clear 
mkfs.ext4 $raiz -L Raiz
sleep 1
echo "formatando RAIZ"
sleep 1
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
mkdir /mnt/boot && mount $raiz /mnt/boot
sleep 1
echo "montando BOOT"
sleep 1
clear 
mkdir /mnt/home && mount $raiz /mnt/home 
sleep 1
echo "montando HOME"
sleep 1
clear 

sed -i '/^#\[multilib\]/{s/^#//;n;s/^#//;n;s/^#//}' /etc/pacman.conf 
sleep 1
clear 
pacstrap /mnt base base-devel linux-zen linux-zen-headers linux-firmware nano sudo man-db dhcpcd git usbutils diffutils gvfs-mtp ntfs-3g
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

 # Adds multilib repository
  sed '/^#\[multilib\]/{s/^#//;n;s/^#//;n;s/^#//}' /etc/pacman.conf > /tmp/pacman
  mv /tmp/pacman /etc/pacman.conf
sleep 10

pacman -Syy
# Sets hostname
echo $nome > /etc/hostname
sleep 10
sed -i 's/#\('pt_BR.UTF-8'\)/\1/' /etc/locale.gen
sed -i 's/#\('pt_BR'\)/\1/' /etc/locale.gen
sleep 10
systemctl enable dhcpcd.service
sleep 10
echo -e "KEYMAP=br-abnt2\nFONT=lat0-16\nFONT_MAP=" >> /etc/vconsole.conf
sleep 10
echo  "LANG=pt_BR.UTF-8" >> /etc/locale.conf
loadkeys /usr/share/kbd/keymaps/i386/qwerty/br-abnt2.map.gz
sleep 10
locale-gen
sleep 10
ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
echo America/Sao_Paulo > /etc/timezone
hwclock --systohc --utc
sleep 10
mkinitcpio -p linux-zen
sleep 10
pacman -S grub --noconfirm
sleep 10
grub-install --target=i386-pc --recheck --debug /dev/sda
mkdir -p /boot/grub/locale
cp /usr/share/locale/en\@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en.mo

pacman -S os-prober --noconfirm
os-prober
grub-mkconfig -o /boot/grub/grub.cfg

sed -i '/%wheel ALL=(ALL) ALL/s/^#//' /etc/sudoers
echo "Defaults env_reset,pwfeedback" >> /etc/sudoers
#git clone https://github.com/fatalzinho/b
#cd b
#chmod +x instal2.sh

sudo timedatectl set-ntp true

# Instalação driver de VIDEO e SOM
pkg="nvidia-390xx-dkms nvidia-390xx-utils nvidia-settings 
pulseaudio  pavucontrol pulseaudio-alsa" 
pacman -S $pkg --noconfirm
rmmod snd_pcm_oss

pacman -S $pkgxfce4 --noconfirm
echo  "exec startxfce" >> ~/.xinitrc
systemctl enable sddm.service

xdg-user-dirs-update


pacman -S $pkdtheme --noconfirm

# OUTROS
cd /tmp/
git clone https://aur.archlinux.org/mugshot.git
cd mugshot
makepkg -si --noconfirm



echo -e $root_senha"\n"$root_senha | passwd
#passwd << EOF
#$root_senha
#$root_senha
#EOF

useradd -m -G audio,dbus,lp,network,optical,power,storage,users,video,wheel -s /bin/bash $usuario
echo -e $usr_usuario"\n"$usr_usuario | passwd $usuario
#passwd "$usuario" << EOF
#$usr_usuario
#$usr_usuario
#EOF
EOF
sleep 1
umount /mnt/boot
umount /mnt/home
reboot
