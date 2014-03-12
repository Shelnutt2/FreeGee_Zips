#!/system/bin/sh
TOOLS="/data/local/tmp/"
if [  -d "/sdcard/freegee" ]; then
BACKUP_LOC="/sdcard/freegee"
BACKUP_ENDING="-backup.img"
else
BACKUP_LOC="/sdcard/backupz"
fi

echo "Backup location is: " $BACKUP_LOC
echo "Backup ending is: " $BACKUP_ENDING

echo "checking for complete backups"
if [ ! -e ${BACKUP_LOC}/aboot${BACKUP_ENDING} ]; then
echo "Aboot backup not found aborting"
exit 101
fi
if [ ! -e ${BACKUP_LOC}/sbl1${BACKUP_ENDING} ] || [ ! -e ${BACKUP_LOC}/sbl2${BACKUP_ENDING} ] || [ ! -e ${BACKUP_LOC}/sbl3${BACKUP_ENDING} ]; then
echo "Complete sbl stack not found, aborting"
exit 100
fi

#Restore aboot
if [ -e ${BACKUP_LOC}/aboot${BACKUP_ENDING} ]; then
dd if=${BACKUP_LOC}/aboot${BACKUP_ENDING} of=/dev/block/platform/msm_sdcc.1/by-name/aboot
else
echo "Aboot backup not found aborting"
exit 1
fi

#Restore sbl1-3
if [ -e ${BACKUP_LOC}/sbl1${BACKUP_ENDING} ] && [ -e ${BACKUP_LOC}/sbl2${BACKUP_ENDING} ] && [ -e ${BACKUP_LOC}/sbl3${BACKUP_ENDING} ]; then
dd if=${BACKUP_LOC}/sbl1${BACKUP_ENDING} of=/dev/block/platform/msm_sdcc.1/by-name/sbl1
dd if=${BACKUP_LOC}/sbl2${BACKUP_ENDING} of=/dev/block/platform/msm_sdcc.1/by-name/sbl2
dd if=${BACKUP_LOC}/sbl3${BACKUP_ENDING} of=/dev/block/platform/msm_sdcc.1/by-name/sbl3
else
echo "Complete sbl stack not found, aborting"
exit 1
fi

#Restore boot
if [ -e "${BACKUP_LOC}/boot${BACKUP_ENDING}" ]; then
dd if=${BACKUP_LOC}/boot${BACKUP_ENDING} of=/dev/block/platform/msm_sdcc.1/by-name/boot
fi

#Restore recovery
if [ -e "${BACKUP_LOC}/recovery${BACKUP_ENDING}" ]; then
dd if=${BACKUP_LOC}/recovery${BACKUP_ENDING} of=/dev/block/platform/msm_sdcc.1/by-name/recovery
fi
