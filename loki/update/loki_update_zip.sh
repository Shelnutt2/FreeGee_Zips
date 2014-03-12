#!/system/bin/sh

export TOOLS=/data/local/tmp/

$TOOLS/unzip -l $TOOLS/tmp.zip | $TOOLS/busybox grep loki_patch
if (("$?" != "0")); then
    echo "loki_patch not found in zip"
    exit 0
fi

LOKIPATCH=$($TOOLS/unzip -l $TOOLS/tmp.zip | $TOOLS/busybox grep loki_patch | $TOOLS/busybox awk 'BEGIN { FS = " " } ; { print $4 }')

for i in "${LOKIPATCH[@]}"
do
  $TOOLS/busybox mkdir -p "$TOOLS$(dirname "$i")"
  $TOOLS/busybox cp $TOOLS/loki_patch "$TOOLS$i"
  cd $TOOLS && $TOOLS/zip tmp.zip $i
done

$TOOLS/unzip -l $TOOLS/tmp.zip | $TOOLS/busybox grep loki_flash
if (("$?" != "0")); then
    echo "loki_flash not found in zip"
    exit 0
fi

LOKIFLASH=$($TOOLS/unzip -l $TOOLS/tmp.zip | $TOOLS/busybox grep loki_flash | $TOOLS/busybox awk 'BEGIN { FS = " " } ; { print $4 }')
for i in "${LOKIFLASH[@]}"
do
  $TOOLS/busybox mkdir -p "$TOOLS$(dirname "$i")"
  $TOOLS/busybox cp $TOOLS/loki_flash "$TOOLS$i"
  cd $TOOLS && $TOOLS/zip tmp.zip $i
done

exit 0



