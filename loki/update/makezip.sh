zip -r loki_update_zip.zip META-INF loki_update_zip.sh "zip" "unzip"
cd ../ && zip update/loki_update_zip.zip loki_flash loki_patch && cd update
java -Xmx1024m -jar /mnt/Android/signing/signapk.jar -w /mnt/Android/optimusg/cm-10.2/build/target/product/security/testkey.x509.pem /mnt/Android/optimusg/cm-10.2/build/target/product/security/testkey.pk8 loki_update_zip.zip loki_update_zip-signed.zip
rsync -ahP loki_update_zip-signed.zip ${vipc}:/home/shelnutt2/downloads/freegee/loki_update_zip.zip
md5sum loki_update_zip-signed.zip
