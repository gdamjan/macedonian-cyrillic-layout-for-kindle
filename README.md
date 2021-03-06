Macedonian cyrillic keyboard layout for Kindle
==============================================

This has been only tested on the Kindle PaperWhite (2nd gen) and Kindle Touch.

You will need a [rooted Kindle](http://wiki.mobileread.com/wiki/Kindle_Touch_Hacking#Jailbreak), and maybe ssh access.

Keyboard layouts are in a cramfs image in `/usr/share/keyboard.cramfs.img`, which is mounted at `/usr/share/keyboard`.
Cramfs is a readonly filesystem, so to modify it, you need to copy everything out of it, and then recreate it.
First, copy the `keyboard.cramfs.img` from the Kindle, mount the image, copy the files in a empty directory (remember
the mount is readonly), add the mk_MK folder, gzip the keymap files and create a new image with `mkcramfs`. At last, ssh into the Kindle, run
`mntroot rw` copy the new image in `/usr/share/keyboard.cramfs.img` (using scp), and remount the Kindle `mntroot ro`. At
this point I just reboot it, probably I could just restart the keyboard service.

PS. the `utils.so` binary file is of dubious legality here, I might need to remove it from the repo (removed it).
But it's just a copy of the english one with strings replaced with a binary editor: `en_US` to `mk_MK` and `English_US` to `Macedonian`.
Luckily the words `Macedonian` and `English_US` are the exact same length.


Change the file in runtime
==========================

If you don't want to restart the kindle:

    stop kb
    umount /usr/share/keyboard
    mntroot rw
    # now copy the new image
    mntroot ro
    mount /usr/share/keyboard.cramfs.img /usr/share/keyboard -o loop
    start kb


Screenshots
===========

![select the keyboard in settings](https://raw.github.com/gdamjan/macedonian-cyrillic-layout-for-kindle/master/screenshots/select-keyboard.png)
![use the keyboard](https://raw.github.com/gdamjan/macedonian-cyrillic-layout-for-kindle/master/screenshots/keyboard.png)


Make an installer
=================

Install [KindleTool](https://github.com/NiLuJe/KindleTool), and run:

    kindletool create ota2 -d kindle5 install.sh upstart_mk_MK.conf mk_MK Update_keyboard_mk_MK.bin

