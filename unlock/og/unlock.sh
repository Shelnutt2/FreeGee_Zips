#!/system/bin/sh

if [ ! -d "/sdcard/freegee" ]; then
mkdir /sdcard/freegee
fi

# first, back up the bootloader, boot.img, and recovery.img
if [ ! -a /sdcard/freegee/aboot-backup.img ]; then
dd if=/dev/block/platform/msm_sdcc.1/by-name/aboot of=/sdcard/freegee/aboot-backup.img
fi

if [ ! -a /sdcard/freegee/sbl1-backup.img ]; then
dd if=/dev/block/platform/msm_sdcc.1/by-name/sbl1 of=/sdcard/freegee/sbl1-backup.img
fi

if [ ! -a /sdcard/freegee/sbl2-backup.img ]; then
dd if=/dev/block/platform/msm_sdcc.1/by-name/sbl2 of=/sdcard/freegee/sbl2-backup.img
fi

if [ ! -a /sdcard/freegee/sbl3-backup.img ]; then
dd if=/dev/block/platform/msm_sdcc.1/by-name/sbl3 of=/sdcard/freegee/sbl3-backup.img
fi

dd if=/data/local/tmp/aboot.img of=/dev/block/platform/msm_sdcc.1/by-name/aboot
if (("$?" != "0")); then
restore
fi

dd if=/data/local/tmp/sbl1.img of=/dev/block/platform/msm_sdcc.1/by-name/sbl1
if (("$?" != "0")); then
restore
fi

dd if=/data/local/tmp/sbl2.img of=/dev/block/platform/msm_sdcc.1/by-name/sbl2
if (("$?" != "0")); then
restore
fi

dd if=/data/local/tmp/sbl3.img of=/dev/block/platform/msm_sdcc.1/by-name/sbl3
if (("$?" != "0")); then
restore
fi

dd if=/dev/block/platform/msm_sdcc.1/by-name/sbl1 of=/data/local/tmp/sbl1-after.img
dd if=/dev/block/platform/msm_sdcc.1/by-name/sbl2 of=/data/local/tmp/sbl2-after.img
dd if=/dev/block/platform/msm_sdcc.1/by-name/sbl3 of=/data/local/tmp/sbl3-after.img

TOOLS=/data/local/tmp/
${TOOLS}/busybox md5sum /data/local/tmp/sbl1-after.img | ${TOOLS}/busybox grep "ff193e1835c633d94c61240085428c9d"
if (("$?" != "0")); then
restore
fi

${TOOLS}/busybox md5sum /data/local/tmp/sbl2-after.img | ${TOOLS}/busybox grep "13d7941c2aada2b67e4e6f3f0ce5d31e"
if (("$?" != "0")); then
restore
fi

${TOOLS}/busybox md5sum /data/local/tmp/sbl3-after.img | ${TOOLS}/busybox grep "4ac3be33e8a5e8b83b1212160a769e7c"
if (("$?" != "0")); then
restore
fi

restore(){
dd if=/sdcard/freegee/aboot-backup.img of=/dev/block/platform/msm_sdcc.1/by-name/aboot
if (("$?" != "0")); then
  exit 5
fi

dd if=/sdcard/freegee/sbl1-backup.img of=/dev/block/platform/msm_sdcc.1/by-name/sbl1
if (("$?" != "0")); then
  exit 5
fi

dd if=/sdcard/freegee/sbl2-backup.img of=/dev/block/platform/msm_sdcc.1/by-name/sbl2
if (("$?" != "0")); then
  exit 5
fi

dd if=/sdcard/freegee/sbl3-backup.img of=/dev/block/platform/msm_sdcc.1/by-name/sbl3
if (("$?" != "0")); then
  exit 5
fi

exit 4
}
