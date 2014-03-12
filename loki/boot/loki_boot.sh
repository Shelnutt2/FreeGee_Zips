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
dd if=/dev/block/platform/msm_sdcc.1/by-name/boot of=$C/boot.img
$TOOLS/loki_patch boot $C/aboot.img $C/boot.img $C/boot.lok || exit 1
$TOOLS/loki_flash boot $C/boot.lok || exit 1
rm -rf $C
exit 0
