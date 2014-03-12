zip -r loki_boot.zip META-INF loki_boot.sh 
cd ../ && zip boot/loki_boot.zip loki_flash loki_patch && cd boot
java -Xmx1024m -jar /mnt/Android/signing/signapk.jar -w /mnt/Android/optimusg/cm-10.2/build/target/product/security/testkey.x509.pem /mnt/Android/optimusg/cm-10.2/build/target/product/security/testkey.pk8 loki_boot.zip loki_boot-signed.zip
rsync -ahP loki_boot-signed.zip ${vipc}:/home/shelnutt2/downloads/freegee/loki_boot.zip
md5sum loki_boot-signed.zip
