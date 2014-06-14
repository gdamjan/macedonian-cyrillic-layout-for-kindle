Macedonian cyrillic keyboard layout for Kindle
==============================================

This has been only tested on the Kindle PaperWhite (2nd gen). On other devices YMMV.

You will need a rooted Kindle, and maybe ssh access.

Keyboard layouts are in a cramfs image in `/usr/share/keyboard.cramfs.img`, which is mounted at `/usr/share/keyboard`.
Cramfs is a readonly filesystem, so to modify it, you need to copy everything out of it, and then recreate it.
First, copy the `keyboard.cramfs.img` from the Kindle, mount the image, copy the files in a empty directory (remember
the mount is readonly), add the mk_MK folder, and create a new image with `mkcramfs`. At last, ssh into the Kindle, run
`mntroot rw` copy the new image in `/usr/share/keyboard.cramfs.img` (using scp), and remount the Kindle `mntroot ro`. At
this point I just reboot it, probably I could just restart the keyboard service.


TODO
====

* make installer
