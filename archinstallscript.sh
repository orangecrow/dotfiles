loadkeys pl
timedatectl set-ntp true
#partition the disk
#sgdisk -delete=0 $1
#sgdisk -g $1
#sgdisk -new=1:0:+260M $1
#sgdisk -new=2:0:+2G $1
#sgdisk -new=3:0:0 $1
wipefs $1
fdisk $1 << EOF
g
n
1

+260M
n
2

+2G
n
3


t
1
4
t
2
19
A
1
w
EOF
mkfs.ext4 ${1}3
mkswap ${1}2
mount ${1}3 /mnt
swapon ${1}2
pacstrap /mnt base linux linux-firmware vim man-db
genfstab -U /mnt >> /mnt/etc/fstab
#printf '
ln -sf /usr/share/zoneinfo/Region/City /etc/localtime
hwclock --systohc
sed -i "s/#pl_PL\.UTF-8/pl_PL\.UTF-8" /etc/locale.gen
sed -i "s/#en_US\.UTF-8/en_US\.UTF-8" /etc/locale.gen
locale-gen
printf "LANG=en_US.UTF-8" >> /etc/locale.conf
printf "KEYMAP=pl" >> /etc/vconsole.conf
printf "jungle" >> /etc/hostname
printf "127.0.0.1	localhost
::1		localhost
127.0.1.1	jungle.localdomain	jungle
" >> /etc/hosts
sed -i "s/keyboard//g" /etc/mkinitcpio.conf
sed -i "s/block//g" /etc/mkinitcpio.conf
sed -i "s/autodetect/block keyboard autodetect/g" /etc/mkinitcpio.conf
mkinitcpio -P
passwd
pacman -S grub amd-ucode intel-ucode
grub-install --target=i386-pc $1 --recheck
grub-mkconfig -o /boot/grub/grub.cfg
exit
#' >> /mnt/tempscript.sh
arch-chroot /mnt sh tempscript.sh
rm /mnt/tempscript.sh
reboot

