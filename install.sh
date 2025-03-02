#!/bin/bash
echo 'whcih is your cpu manufactor?(amd or intel)'

###------ install some basic software in your new system -----###
pacstrap -K /mnt base linux linux-firmware vim base-devel amd-code \
btrfs-progs man-db man-pages networkmanager sudo

## generate some
genfstab -U /mnt >> /mnt/etc/fstab
cat /mnt/etc/fstab

## enter your new system
arch-chroot /mnt

## for china to change time zone
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
hwclock --systohc

## some edition in /etc/locale.gen

locale-gen
echo 'LANG=en_US.UTF-8' | cat > /etc/locale.conf

mkdir /etc/hostname

passwd

## GRUB bootloader
pacman -S grub efibootmgr
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.conf

## user creation
useradd -m -G wheel -s /bin/bash spriple
passwd spriple
# uncomment the sudoers to let wheel can use sudo
sudo systemctl enable NetworkManager
sudo systemctl start NetworkManager

