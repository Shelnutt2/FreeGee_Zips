#!/system/bin/sh
TOOLS="/data/local/tmp/"
if [  -d "/sdcard/backupz" ]; then
BACKUP_LOC=/sdcard/backupz
else
BACKUP_LOC=/sdcard/freegee
BACKUP_ENDING="-backup"
fi

#Restore boot
if [ -f "${BACKUP_LOC}/boot${BACKUP_ENDING}.img" ]; then
dd if=${BACKUP_LOC}/boot${BACKUP_ENDING}.img of=/dev/block/platform/msm_sdcc.1/by-name/boot
fi
#Restore recovery
if [ -f "${BACKUP_LOC}/recovery${BACKUP_ENDING}.img" ]; then
dd if=${BACKUP_LOC}/recovery${BACKUP_ENDING}.img of=/dev/block/platform/msm_sdcc.1/by-name/recovery
fi

#Restore modemst1
if [ -f "${BACKUP_LOC}/modemst1${BACKUP_ENDING}.img" ]; then
dd if=${BACKUP_LOC}/modemst1${BACKUP_ENDING}.img of=/dev/block/platform/msm_sdcc.1/by-name/modemst1
fi
#Restore modemst2
if [ -f "${BACKUP_LOC}/modemst2${BACKUP_ENDING}.img" ]; then
dd if=${BACKUP_LOC}/modemst2${BACKUP_ENDING}.img of=/dev/block/platform/msm_sdcc.1/by-name/modemst2
fi
