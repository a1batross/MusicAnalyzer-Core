#!/bin/sh
. ../build_config.sh


if [ ! -f $TAGLIB_VERSION.tar.gz ]; then 
	wget http://taglib.github.io/releases/$TAGLIB_VERSION.tar.gz
fi
rm -rf tmp
mkdir tmp
cd tmp

tar -xf ../$TAGLIB_VERSION.tar.gz
cd $TAGLIB_VERSION/

cmake \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_BUILD_TYPE=Release \
    -DENABLE_STATIC=OFF \
	. 
make
make install

cd ../..
rm -r tmp

