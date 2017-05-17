#!/usr/bin/env bash

set -x

BASEDIR=$(realpath $(dirname $0))
export PATH=`pwd`/android/bin:$PATH;

#DONE ALREADY
#deps/packaging/build_3rdparty_static_debian.sh --with-gaia

export PKG_CONFIG_PATH=$BASEDIR/prefix/lib/pkgconfig

cd essentia

./waf clean;
./waf configure --cross-compile-android --with-gaia --fft=KISS --prefix=$BASEDIR/prefix/ --with-static-examples
./waf -j5 -v;
./waf install;
