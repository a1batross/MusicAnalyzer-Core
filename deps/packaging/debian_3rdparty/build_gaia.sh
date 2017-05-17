#!/bin/sh
. ../build_config.sh


echo $PREFIX

export PATH=$PREFIX/bin:$PATH

export PKG_CONFIG_PATH=$PREFIX/lib/pkgconfig/

if [ ! -f gaia-master.zip ]; then
	wget https://github.com/MTG/gaia/archive/master.zip -O gaia-master.zip
fi
rm -rf tmp
mkdir tmp
cd tmp

unzip -x ../gaia-master.zip

cp ../wafpatch/waf gaia-master/waf
cp ../wafpatch/wscript gaia-master/wscript

cd gaia-master

./waf configure --prefix=$PREFIX -v
./waf -v
./waf install 

cd ../..
# rm -rf tmp
