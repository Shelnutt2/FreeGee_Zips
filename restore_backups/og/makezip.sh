zip -r restore_backups_og.zip META-INF restore_backups.sh
java -Xmx1024m -jar /mnt/Android/signing/signapk.jar -w /mnt/Android/optimusg/cm-10.2/build/target/product/security/testkey.x509.pem /mnt/Android/optimusg/cm-10.2/build/target/product/security/testkey.pk8 restore_backups_og.zip restore_backups_og-signed.zip
rsync -ahP restore_backups_og-signed.zip ${vipc}:/home/shelnutt2/downloads/freegee/restore_backups_og.zip
md5sum restore_backups_og-signed.zip
