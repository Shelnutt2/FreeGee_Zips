zip -r loki_check.zip META-INF loki_check.sh 
cd ../ && zip check/loki_check.zip loki_check && cd check
java -Xmx1024m -jar /mnt/Android/signing/signapk.jar -w /mnt/Android/optimusg/cm-10.2/build/target/product/security/testkey.x509.pem /mnt/Android/optimusg/cm-10.2/build/target/product/security/testkey.pk8 loki_check.zip loki_check-signed.zip
rsync -ahP loki_check-signed.zip ${vipc}:/home/shelnutt2/downloads/freegee/loki_check.zip
md5sum loki_check-signed.zip
