zip -r revert_aboot_vs980.zip META-INF revert_aboot.sh aboot.img laf.img
java -Xmx1024m -jar /mnt/Android/signing/signapk.jar -w /mnt/Android/optimusg/cm-10.2/build/target/product/security/testkey.x509.pem /mnt/Android/optimusg/cm-10.2/build/target/product/security/testkey.pk8 revert_aboot_vs980.zip revert_aboot_vs980-signed.zip
rsync -ahP revert_aboot_vs980-signed.zip ${vipc}:/home/shelnutt2/downloads/freegee/revert_aboot_vs980.zip
md5sum revert_aboot_vs980-signed.zip

