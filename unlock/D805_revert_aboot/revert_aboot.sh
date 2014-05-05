#!/system/bin/sh

if [ ! -d "/sdcard/freegee" ]; then
mkdir /sdcard/freegee
fi

restore(){
dd if=/sdcard/freegee/aboot-backup.img of=/dev/block/platform/msm_sdcc.1/by-name/aboot
if (("$?" != "0")); then
  exit 5
fi

exit 4
}

# first, back up the bootloader
if [ ! -a /sdcard/freegee/aboot-backup.img ]; then
dd if=/dev/block/platform/msm_sdcc.1/by-name/aboot of=/sdcard/freegee/aboot-backup.img
fi

if [ ! -a /sdcard/freegee/laf-backup.img ]; then
dd if=/dev/block/platform/msm_sdcc.1/by-name/laf of=/sdcard/freegee/laf-backup.img
fi

dd if=/data/local/tmp/aboot.img of=/dev/block/platform/msm_sdcc.1/by-name/aboot
if (("$?" != "0")); then
restore
fi

dd if=/data/local/tmp/laf.img of=/dev/block/platform/msm_sdcc.1/by-name/laf
if (("$?" != "0")); then
restore
fi

dd if=/dev/block/platform/msm_sdcc.1/by-name/aboot of=/data/local/tmp/aboot-after.img
dd if=/dev/block/platform/msm_sdcc.1/by-name/laf of=/data/local/tmp/laf-after.img

TOOLS=/data/local/tmp/
${TOOLS}/busybox md5sum /data/local/tmp/aboot-after.img | ${TOOLS}/busybox grep "171f857a7d1ed32801cdf8f1dc85c6bc"
if (("$?" != "0")); then
restore
fi

${TOOLS}/busybox md5sum /data/local/tmp/laf-after.img | ${TOOLS}/busybox grep "d9fd27ae6ac8cb18925df2263870670b"
if (("$?" != "0")); then
${TOOLS}/busybox md5sum /data/local/tmp/laf-after.img
fi
