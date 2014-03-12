#!/sbin/sh

if [  -d "/sdcard/EFS_BACKUPS" ]; then
BACKUP_LOC=/sdcard/EFS_BACKUPS
else
BACKUP_LOC=/sdcard/freegee
fi
#Restore modemst1
if [ -f "${BACKUP_LOC}/modemst1-backup.img" ]; then
dd if=${BACKUP_LOC}/modemst1-backup.img of=/dev/block/platform/msm_sdcc.1/by-name/modemst1
fi
#Restore modemst2
if [ -f "${BACKUP_LOC}/modemst2-backup.img" ]; then
dd if=${BACKUP_LOC}/modemst2-backup.img of=/dev/block/platform/msm_sdcc.1/by-name/modemst2
fi
