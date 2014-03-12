#!/sbin/sh
#
# This leverages the loki_patch utility created by djrbliss which allows us
# to bypass the bootloader checks on jfltevzw and jflteatt
# See here for more information on loki: https://github.com/djrbliss/loki
#

export C=/data/local/tmp/loki_tmpdir
export TOOLS=/data/local/tmp/

mkdir -p $C
dd if=/dev/block/platform/msm_sdcc.1/by-name/aboot of=$C/aboot.img
dd if=/dev/block/platform/msm_sdcc.1/by-name/recovery of=$C/recovery.img
$TOOLS/loki_patch recovery $C/aboot.img $C/recovery.img $C/recovery.lok || exit 1
$TOOLS/loki_flash recovery $C/recovery.lok || exit 1
rm -rf $C
exit 0
