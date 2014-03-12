#!/system/bin/sh
TOOLS="/data/local/tmp/"
WORKING="/data/local/tmp/boot-working"
TEMP="/data/local/tmp"
mkdir ${WORKING}
${TOOLS}/busybox dd if=/dev/block/platform/msm_sdcc.1/by-name/boot of=${TEMP}/boot.img
${TOOLS}/busybox dd if=/dev/block/platform/msm_sdcc.1/by-name/boot of=/sdcard/freegee/boot-backup.img
${TEMP}/unpackbootimg -i ${TEMP}/boot.img -o ${TEMP}/
${TOOLS}/busybox cp ${TEMP}/boot.img-ramdisk.gz ${WORKING}
cd ${WORKING} && ${TOOLS}/busybox gunzip -c boot.img-ramdisk.gz | ${TOOLS}/busybox cpio -i
rm ${WORKING}/boot.img-ramdisk.gz
cd ${WORKING} && ${TOOLS}/busybox grep -lr "/sbin/wallpaper" ${WORKING} | ${TOOLS}/busybox xargs ${TOOLS}/busybox sed -i '/wallpaper/s/^/#/'
${TOOLS}/busybox chmod 0755 ${WORKING}
cd ${WORKING} && ${TOOLS}/busybox find . | ${TOOLS}/busybox cpio -o -H newc | ${TOOLS}/gzip > ${TEMP}/boot.img-ramdisk-new.gz
current_cmd=$(${TOOLS}/busybox cat ${TEMP}/boot.img-cmdline)
current_base=$(${TOOLS}/busybox cat ${TEMP}/boot.img-base)
current_ramdiskoffset=$(${TOOLS}/busybox cat ${TEMP}/boot.img-ramdisk_offset)
${TEMP}/mkbootimg --kernel ${TEMP}/boot.img-zImage --ramdisk ${TEMP}/boot.img-ramdisk-new.gz --cmdline "${current_cmd}" --base "${current_base}" --ramdisk_offset 0x${current_ramdiskoffset} -o ${TEMP}/boot-new.img
${TOOLS}/busybox dd if=${TEMP}/boot-new.img of=/dev/block/platform/msm_sdcc.1/by-name/boot
rm -r ${WORKING}
