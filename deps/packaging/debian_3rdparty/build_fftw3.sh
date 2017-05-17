#!/bin/sh
. ../build_config.sh

if [ ! -f $FFTW_VERSION.tar.gz ]; then
	wget http://www.fftw.org/$FFTW_VERSION.tar.gz
fi
rm -rf tmp
mkdir tmp
cd tmp
tar -xf ../$FFTW_VERSION.tar.gz
cd $FFTW_VERSION

./configure \
    --prefix=$PREFIX \
    $FFTW_FLAGS \
    $SHARED_OR_STATIC
make
make install

cd ../..
#rm -r tmp
