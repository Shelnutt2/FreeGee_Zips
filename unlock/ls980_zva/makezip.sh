zip -r revert_aboot_zva.zip META-INF revert_aboot.sh aboot.img laf.img
java -Xmx1024m -jar /mnt/Android/signing/signapk.jar -w /mnt/Android/optimusg/cm-10.2/build/target/product/security/testkey.x509.pem /mnt/Android/optimusg/cm-10.2/build/target/product/security/testkey.pk8 revert_aboot_zva.zip revert_aboot_zva-signed.zip
rsync -ahP revert_aboot_zva-signed.zip ${vipc}:/home/shelnutt2/downloads/freegee/revert_aboot_zva.zip
md5sum revert_aboot_zva-signed.zip

