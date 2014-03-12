#!/sbin/sh

if [  -d "/sdcard/EFS_BACKUPS" ]; then
BACKUP_LOC=/sdcard/EFS_BACKUPS
else
BACKUP_LOC=/sdcard/freegee
fi
#Restore m9kefs1
if [ -f "${BACKUP_LOC}/m9kefs1-backup.img" ]; then
dd if=${BACKUP_LOC}/m9kefs1-backup.img of=/dev/block/platform/msm_sdcc.1/by-name/m9kefs1
fi
#Restore m9kefs2
if [ -f "${BACKUP_LOC}/m9kefs2-backup.img" ]; then
dd if=${BACKUP_LOC}/m9kefs2-backup.img of=/dev/block/platform/msm_sdcc.1/by-name/m9kefs2
fi
#Restore m9kefs3
if [ -f "${BACKUP_LOC}/m9kefs3-backup.img" ]; then
dd if=${BACKUP_LOC}/m9kefs3-backup.img of=/dev/block/platform/msm_sdcc.1/by-name/m9kefs3
fi
