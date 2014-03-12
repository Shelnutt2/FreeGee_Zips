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

for PRODUCT in $(ls ${IN}/out/target/product | grep 'e970\|e973\|e975\|ls970\|180k\|180l\|180s')
do
    cp ${IN}/out/target/product/${PRODUCT}/recovery.img recovery.img
    zip -r tmp.zip ./META-INF recovery.img
    java -Xmx1024m -jar /mnt/Android/signing/signapk.jar -w /mnt/Android/optimusg/cm-10.2/build/target/product/security/testkey.x509.pem /mnt/Android/optimusg/cm-10.2/build/target/product/security/testkey.pk8 tmp.zip ${VERSION}-${PRODUCT}.zip
    rm tmp.zip
    if [[ ${PRODUCT} == "e970" ]]; then
        UPLOAD="LG-E970"
    elif [[ ${PRODUCT} == "e973" ]]; then
        UPLOAD="LG-E973"
    elif [[ ${PRODUCT} == "e975" ]]; then
        UPLOAD="LG-E975"
    elif [[ ${PRODUCT} == "ls970" ]]; then
        UPLOAD="LG-LS970"
    elif [[ ${PRODUCT} == "180l" ]]; then
        UPLOAD="LG-180L"
    elif [[ ${PRODUCT} == "180k" ]]; then
        UPLOAD="LG-180K"
    elif [[ ${PRODUCT} == "180s" ]]; then
        UPLOAD="LG-180S"
    fi
    rsync -ahP ${VERSION}-${PRODUCT}.zip ${vipc}:/home/shelnutt2/downloads/freegee/${UPLOAD}/${VERSION}-${PRODUCT}.zip
done
    echo $(md5sum ${VERSION}-*.zip)
