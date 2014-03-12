#!/system/bin/sh
TOOLS="/data/local/tmp/"
TEMP="/data/local/tmp"
${TOOLS}/busybox dd if=/dev/block/platform/msm_sdcc.1/by-name/boot of=${TEMP}/boot.img
${TEMP}/unpackbootimg -i ${TEMP}/boot.img -o ${TEMP}/
current_cmd=$(${TOOLS}/busybox cat ${TEMP}/boot.img-cmdline)
new_cmd=$(${TOOLS}/busybox echo $current_cmd | ${TOOLS}/busybox sed s/HSL/SHL/)
current_base=$(${TOOLS}/busybox cat ${TEMP}/boot.img-base)
current_ramdiskoffset=$(${TOOLS}/busybox cat ${TEMP}/boot.img-ramdisk_offset)
${TEMP}/mkbootimg --kernel ${TEMP}/boot.img-zImage --ramdisk ${TEMP}/boot.img-ramdisk.gz --cmdline "${new_cmd}" --base "${current_base}" --ramdisk_offset ${current_ramdiskoffset} -o ${TEMP}/boot-new.img
${TOOLS}/busybox dd if=${TEMP}/boot-new.img of=/dev/block/platform/msm_sdcc.1/by-name/boot
