#!/bin/sh
. ../build_config.sh

if [ ! -f $LIBAV_VERSION.tar.gz ]; then
	wget https://libav.org/releases/$LIBAV_VERSION.tar.gz
fi
#rm -rf tmp
mkdir tmp
cd tmp
tar xf ../$LIBAV_VERSION.tar.gz
cd $LIBAV_VERSION

cp ../../libav.config.sub config.sub
cp ../../libav.config.guess config.guess
./configure \
    $LIBAV_AUDIO_FLAGS \
    --prefix=$PREFIX \
    $SHARED_OR_STATIC
make
make install

cd ../..
#rm -r tmp
