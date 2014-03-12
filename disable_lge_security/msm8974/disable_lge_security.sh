#!/system/bin/sh
TOOLS="/data/local/tmp/"
WORKING="/data/local/tmp/boot-working"
TEMP="/data/local/tmp"
mkdir ${WORKING}

${TOOLS}/busybox dd if=/dev/block/platform/msm_sdcc.1/by-name/boot of=${TEMP}/boot.img

if [ ! -f "/sdcard/freegee/boot-backup.img" ]; then
${TOOLS}/busybox dd if=/dev/block/platform/msm_sdcc.1/by-name/boot of=/sdcard/freegee/boot-backup.img
fi

${TEMP}/unpackbootimg -i ${TEMP}/boot.img -o ${TEMP}/
${TOOLS}/busybox cp ${TEMP}/boot.img-ramdisk.lz4 ${WORKING}
cd ${WORKING} && ${TEMP}/lz4c -d ${WORKING}/boot.img-ramdisk.lz4 | ${TOOLS}/busybox cpio -i
${TOOLS}/busybox rm ${WORKING}/boot.img-ramdisk.lz4
cd ${WORKING} && ${TOOLS}/busybox grep -lr "/sbin/wallpaper" ${WORKING} | ${TOOLS}/busybox xargs ${TOOLS}/busybox sed -i '/wallpaper/s/^/#/'
cd ${WORKING} && ${TOOLS}/busybox grep -lr "security-check1" ${WORKING} | ${TOOLS}/busybox xargs ${TOOLS}/busybox sed -ir '/security-check1/,+3d'
cd ${WORKING} && ${TOOLS}/busybox grep -lr "security-check2" ${WORKING} | ${TOOLS}/busybox xargs ${TOOLS}/busybox sed -ir '/security-check2/,+3d'
${TOOLS}/busybox chmod 0755 ${WORKING}
cd ${WORKING} && ${TOOLS}/busybox find . | ${TOOLS}/busybox cpio -o -H newc | ${TOOLS}/gzip > ${TEMP}/boot.img-ramdisk-new.lz4
current_cmd=$(${TOOLS}/busybox cat ${TEMP}/boot.img-cmdline)
current_base=$(${TOOLS}/busybox cat ${TEMP}/boot.img-base)
current_ramdiskoffset=$(${TOOLS}/busybox cat ${TEMP}/boot.img-ramdisk_offset)
current_tagsoffset=$(${TOOLS}/busybox cat ${TEMP}/boot.img-tags_offset)
${TEMP}/mkbootimg --kernel ${TEMP}/boot.img-zImage --ramdisk ${TEMP}/boot.img-ramdisk-new.lz4 --cmdline "${current_cmd}" --base 0x${current_base} --ramdisk_offset 0x${current_ramdiskoffset} --tags_offset 0x${current_tagsoffset} --dt ${TEMP}/boot.img-dt -o ${TEMP}/boot-new.img
${TOOLS}/busybox dd if=${TEMP}/boot-new.img of=/dev/block/platform/msm_sdcc.1/by-name/boot
rm -r ${WORKING}
