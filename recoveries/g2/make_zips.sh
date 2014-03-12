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

for PRODUCT in $(ls ${IN}/out/target/product | grep 'd800\|d801\|d802\|d803\|ls980\|vs980')
do
    cp ${IN}/out/target/product/${PRODUCT}/recovery.img recovery.img
    zip -r tmp.zip ./META-INF ./recovery.img
    java -Xmx1024m -jar /mnt/Android/signing/signapk.jar -w /mnt/Android/optimusg/cm-10.2/build/target/product/security/testkey.x509.pem /mnt/Android/optimusg/cm-10.2/build/target/product/security/testkey.pk8 tmp.zip ${VERSION}-${PRODUCT}.zip
    rm tmp.zip
    if [[ ${PRODUCT} == "d800" ]]; then
        UPLOAD="LG-D800"
    elif [[ ${PRODUCT} == "d801" ]]; then
        UPLOAD="LG-D801"
    elif [[ ${PRODUCT} == "d802" ]]; then
        UPLOAD="LG-D802"
    elif [[ ${PRODUCT} == "d803" ]]; then
        UPLOAD="LG-D803"
    elif [[ ${PRODUCT} == "ls980" ]]; then
        UPLOAD="LG-LS980"
    elif [[ ${PRODUCT} == "vs980" ]]; then
        UPLOAD="LG-VS980"
    elif [[ ${PRODUCT} == "f320k" ]]; then
        UPLOAD="LG-F320K"
    elif [[ ${PRODUCT} == "f320l" ]]; then
        UPLOAD="LG-F320L"
    elif [[ ${PRODUCT} == "f320s" ]]; then
        UPLOAD="LG-F320S"
    fi
    rsync -ahP ${VERSION}-${PRODUCT}.zip ${vipc}:/home/shelnutt2/downloads/freegee/${UPLOAD}/${VERSION}-${PRODUCT}.zip
done
    echo $(md5sum ${VERSION}-*.zip)
