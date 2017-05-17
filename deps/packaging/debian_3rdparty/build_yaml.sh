#!/bin/sh
. ../build_config.sh

echo $PREFIX


if [ ! -f $LIBYAML_VERSION.tar.gz ]; then
	wget http://pyyaml.org/download/libyaml/$LIBYAML_VERSION.tar.gz
fi
rm -rf tmp
mkdir tmp
cd tmp

tar -xf ../$LIBYAML_VERSION.tar.gz
cd $LIBYAML_VERSION

# fails to compile shared library, building only static
CFLAGS+="-DYAML_DECLARE_STATIC"
./configure \
    --prefix=$PREFIX \
    $SHARED_OR_STATIC $HOST_ARG
make
make install

cd ../..
rm -r tmp
