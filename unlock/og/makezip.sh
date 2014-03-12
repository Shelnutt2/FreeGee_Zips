zip -r og_unlock.zip META-INF unlock.sh aboot.img sbl1.img sbl2.img sbl3.img
java -Xmx1024m -jar /mnt/Android/signing/signapk.jar -w /mnt/Android/optimusg/cm-10.2/build/target/product/security/testkey.x509.pem /mnt/Android/optimusg/cm-10.2/build/target/product/security/testkey.pk8 og_unlock.zip og_unlock-signed.zip
rsync -ahP og_unlock-signed.zip ${vipc}:/home/shelnutt2/downloads/freegee/og_unlock.zip
md5sum og_unlock-signed.zip

