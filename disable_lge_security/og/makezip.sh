zip -r disable_lge_security_og.zip ./gzip META-INF disable_lge_security.sh mkbootimg unpackbootimg
java -Xmx1024m -jar /mnt/Android/signing/signapk.jar -w /mnt/Android/optimusg/cm-10.2/build/target/product/security/testkey.x509.pem /mnt/Android/optimusg/cm-10.2/build/target/product/security/testkey.pk8 disable_lge_security_og.zip disable_lge_security_og-signed.zip
rsync -ahP disable_lge_security_og-signed.zip ${vipc}:/home/shelnutt2/downloads/freegee/disable_lge_security_og.zip
md5sum disable_lge_security_og-signed.zip
