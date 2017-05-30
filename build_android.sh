#!/usr/bin/env bash

set -x

BASEDIR=$(realpath $(dirname $0))
export PATH=`pwd`/android/bin:$PATH;

#DONE ALREADY
# deps/packaging/build_3rdparty_static_debian.sh --with-gaia

export CC=arm-linux-androideabi-gcc
export CFLAGS="-O3 -mcpu=cortex-a9 -mfloat-abi=softfp -mfpu=neon -marm -pipe -fpic -mfloat-abi=softfp -mfpu=neon -finline-limit=300 -ffast-math -Wno-psabi -Wa,--noexecstack -DANDROID -DNDEBUG -mfloat-abi=softfp -mfpu=neon"
export LDFLAGS="-Wl,--fix-cortex-a8 -Wl,--no-undefined"

export CXX=arm-linux-androideabi-g++
export LD=arm-linux-androideabi-ld
export LINK=arm-linux-androideabi-gcc

export PKG_CONFIG_PATH=$BASEDIR/prefix/lib/pkgconfig

cd essentia

./waf clean;
./waf configure --with-gaia --fft=KISS --prefix=$BASEDIR/prefix/ --cross-compile-android # --shared
./waf -j5 -v;
./waf install;
