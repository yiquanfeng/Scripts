sudo tar --exclude=/proc/* \
--exclude=/sys/* \
--exclude=/dev/* \
--exclude=/mnt/* \
--exclude=/run/* \
--exclude=/tmp/* \
--exclude=/lost+found/* \
--exclude=/media/* \
--exclude=/var/cache/pacman/pkg/* \
-czpvf bkp.tar.gz /
