#!/bin/bash

# Argument = -i cm root dir

usage()
{
cat << EOF
usage: $0 options

This script make freegee recovery zips.

OPTIONS:
   -h      Show this message
   -i      cm root dir
EOF
}


IN=
while getopts “hi:” OPTION
do
     case $OPTION in
         h)
             usage
             exit 1
             ;;
         i)
             IN=$OPTARG
             ;;
         ?)
             usage
             exit
             ;;
     esac
done

if [[ -z $IN ]]
then
     usage
     exit 1
fi

if [ ! -f ${IN}/bootable/recovery/variables.h ]; then
    VERSION="cwm-"$(grep "RECOVERY_VERSION" ${IN}/bootable/recovery/Android.mk | grep RECOVERY_NAME | awk ' { print $4 }' | sed 's/v//')
else
    VERSION="twrp-"$(grep "TW_VERSION_STR" ${IN}/bootable/recovery/variables.h  | awk ' { print $3 }' | sed 's/"//g')
fi

for PRODUCT in $(ls ${IN}/out/target/product | grep 'e980\|f220')
do
    cp ${IN}/out/target/product/${PRODUCT}/recovery.img recovery.img
    zip -r tmp.zip ./META-INF recovery.img
    java -Xmx1024m -jar /mnt/Android/signing/signapk.jar -w /mnt/Android/optimusg/cm-10.2/build/target/product/security/testkey.x509.pem /mnt/Android/optimusg/cm-10.2/build/target/product/security/testkey.pk8 tmp.zip ${VERSION}-${PRODUCT}.zip
    rm tmp.zip
    if [[ ${PRODUCT} == "e980" ]]; then
        UPLOAD="LG-E980"
    elif [[ ${PRODUCT} == "f220" ]]; then
        UPLOAD="LG-F220"
    fi
    rsync -ahP ${VERSION}-${PRODUCT}.zip ${vipc}:/home/shelnutt2/downloads/freegee/${UPLOAD}/${VERSION}-${PRODUCT}.zip
done
    echo $(md5sum ${VERSION}-*.zip)
