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

# the image is ready, so mount it and restart kb, so it works immediately
stop kb
umount "$SRCDIR"
mount -o loop "$DESTIMG" "$SRCDIR"
start kb


# TODO: need to setup something so the updated image is mounted on boot

