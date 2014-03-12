zip -r mako_unlock.zip META-INF unlock.sh aboot.img sbl1.img sbl2.img sbl3.img
java -Xmx1024m -jar /mnt/Android/signing/signapk.jar -w /mnt/Android/optimusg/cm-10.2/build/target/product/security/testkey.x509.pem /mnt/Android/optimusg/cm-10.2/build/target/product/security/testkey.pk8 mako_unlock.zip mako_unlock-signed.zip
rsync -ahP mako_unlock-signed.zip ${vipc}:/home/shelnutt2/downloads/freegee/mako_unlock.zip
md5sum mako_unlock-signed.zip

