zip -r loki_recovery.zip META-INF loki_recovery.sh 
cd ../ && zip recovery/loki_recovery.zip loki_flash loki_patch && cd recovery
java -Xmx1024m -jar /mnt/Android/signing/signapk.jar -w /mnt/Android/optimusg/cm-10.2/build/target/product/security/testkey.x509.pem /mnt/Android/optimusg/cm-10.2/build/target/product/security/testkey.pk8 loki_recovery.zip loki_recovery-signed.zip
rsync -ahP loki_recovery-signed.zip ${vipc}:/home/shelnutt2/downloads/freegee/loki_recovery.zip
md5sum loki_recovery-signed.zip
