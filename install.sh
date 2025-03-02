#!/bin/bash
## connect the wifi
function wifi(){
read -p "enter the wifi ssid: " wifi_name
read -p "enter the wifi password:" wifi_password
iwctl --passphrase $wifi_password station ... connect $wifi_name
## time
timedatectl
}
## some operation to distibute the disk space

## mirrorlist
## queation what kind of cpu
read -p "which is your cpu manufacturer? (amd or intel) " cpu
###------ install some basic software in your new system -----###
#TODO:need to trust all
pacstrap -K /mnt base linux linux-firmware vim base-devel $cpu-ucode \
btrfs-progs man-db man-pages networkmanager sudo alacritty

## generate some info of disk distribution
genfstab -U /mnt > /mnt/boot/fstab
cat /mnt/boot/fstab

## enter your new system
arch-chroot /mnt

## for china to change time zone
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
hwclock --systohc

## some edition in /etc/locale.gen
sed -i.bak 's/#en_US.UTF-8/en_US.UTF-8/g' /etc/locale.gen
sed -i.bak 's/#zh_CN.UTF-8/zh_CN.UTF-8/g' /etc/locale.gen

locale-gen
echo 'LANG=en_US.UTF-8' | cat > /etc/locale.conf

mkdir /etc/hostname

passwd

## GRUB bootloader
pacman -S grub efibootmgr
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.conf

## get your usb installer out when operating this 
reboot


## ---------------------------------------- ##
## followings are the operation after reboot
function build(){
## user creation
useradd -m -G wheel -s /bin/bash spriple
passwd spriple
# uncomment the sudoers to let wheel can use sudo
sed -i.bak 's/# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/g' /etc/sudoers
su spriple

sudo systemctl enable NetworkManager
systemctl start NetworkManager
}


