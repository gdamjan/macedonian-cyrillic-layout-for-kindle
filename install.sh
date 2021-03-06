#! /bin/sh

# This script runs on the Kindle when the "OTA" package is installed

SRCDIR=/usr/share/keyboard
WORKDIR=/tmp/keyboard_mk_MK
DESTIMG=/mnt/us/keyboard-mk_MK.cramfs.img
# first we need to create a new image for the keyboard files
# based on the existing one but with mk_MK added.
# a cramfs image will be created in the /mnt/us/ storage

cp -a $SRCDIR $WORKDIR
cp -r mk_MK $WORKDIR

cp $WORKDIR/en_US/utils.so        $WORKDIR/mk_MK/utils.so
sed -i 's/en_US/mk_MK/'           $WORKDIR/mk_MK/utils.so
sed -i 's/English_US/Macedonian/' $WORKDIR/mk_MK/utils.so

mkcramfs "$WORKDIR" "$DESTIMG"

# remove the work dir
rm -rf "$WORKDIR"

# Setup an upstart config file to mount the updated image on boot
mntroot rw
cp upstart_mk_MK.conf /etc/upstart/keyboard_mk_MK.conf
mntroot ro

start keyboard_mk_MK
