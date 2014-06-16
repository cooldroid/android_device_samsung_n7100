#!/bin/bash
PHILZ_LOCAL_PATH=$(readlink -f $1)
PHILZ_OUT_PATH=$(readlink -f $2)
PHILZ_ZIP_FILE=philz_touch_$3.zip
PHILZ_RECOVERY_IMG=$(readlink -f $4)
if [ ! -f $PHILZ_RECOVERY_IMG ]; then
    echo "0"
    exit
fi

mkdir -p "$PHILZ_OUT_PATH/zip_src"
rm -f "$PHILZ_OUT_PATH/$PHILZ_ZIP_FILE"

cp -r $PHILZ_LOCAL_PATH/tools/META-INF $PHILZ_OUT_PATH/zip_src/
cp $PHILZ_RECOVERY_IMG $PHILZ_OUT_PATH/zip_src/

cd $PHILZ_OUT_PATH/zip_src
zip -r9q $PHILZ_OUT_PATH/$PHILZ_ZIP_FILE .
tar -H ustar -c recovery.img > $PHILZ_OUT_PATH/philz_touch_$3.tar
md5sum -t $PHILZ_OUT_PATH/philz_touch_$3.tar >> $PHILZ_OUT_PATH/philz_touch_$3.tar
mv $PHILZ_OUT_PATH/philz_touch_$3.tar $PHILZ_OUT_PATH/philz_touch_$3.tar.md5
cp $PHILZ_OUT_PATH/$PHILZ_ZIP_FILE /media/sf_D/android/hacking/AndroidImageKitchen/Philz/
cp $PHILZ_OUT_PATH/philz_touch_$3.tar.md5 /media/sf_D/android/hacking/AndroidImageKitchen/Philz/
#echo 1
