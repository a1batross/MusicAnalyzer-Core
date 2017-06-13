#!/bin/sh
. ../build_config.sh


if [ ! -f $LIBSAMPLERATE_VERSION.tar.gz ]; then
	wget http://www.mega-nerd.com/SRC/$LIBSAMPLERATE_VERSION.tar.gz
fi
rm -rf tmp
mkdir tmp
cd tmp

tar -xf ../$LIBSAMPLERATE_VERSION.tar.gz
cd $LIBSAMPLERATE_VERSION

cp ../../libav.config.sub   Cfg/config.sub
cp ../../libav.config.guess Cfg/config.guess
./configure \
    --prefix=$PREFIX \
    $LIBSAMPLERATE_FLAGS
make
make install

#cd ../..
#rm -r tmp
