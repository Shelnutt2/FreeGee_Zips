zip -r backup_efs_msm8974.zip META-INF efsbackup.sh
java -Xmx1024m -jar /mnt/Android/signing/signapk.jar -w /mnt/Android/optimusg/cm-10.2/build/target/product/security/testkey.x509.pem /mnt/Android/optimusg/cm-10.2/build/target/product/security/testkey.pk8 backup_efs_msm8974.zip backup_efs_msm8974-signed.zip
rsync -ahP backup_efs_msm8974-signed.zip ${vipc}:/home/shelnutt2/downloads/freegee/backup_efs_msm8974.zip
md5sum backup_efs_msm8974-signed.zip
