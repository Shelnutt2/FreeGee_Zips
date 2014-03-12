zip -r fix_stock_recovery_og.zip META-INF fix_stock_recovery.sh mkbootimg unpackbootimg
java -Xmx1024m -jar /mnt/Android/signing/signapk.jar -w /mnt/Android/optimusg/cm-10.2/build/target/product/security/testkey.x509.pem /mnt/Android/optimusg/cm-10.2/build/target/product/security/testkey.pk8 fix_stock_recovery_og.zip fix_stock_recovery_og-signed.zip
rsync -ahP fix_stock_recovery_og-signed.zip ${vipc}:/home/shelnutt2/downloads/freegee/fix_stock_recovery_og.zip
md5sum fix_stock_recovery_og-signed.zip
