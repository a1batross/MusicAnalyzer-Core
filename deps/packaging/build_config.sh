#!/bin/sh

HOST=arm-linux-androideabi
export PREFIX=$(realpath $(pwd)/../../../prefix)

export CC=arm-linux-androideabi-gcc
export CFLAGS="-O3 -mcpu=cortex-a9 -mfloat-abi=softfp -mfpu=neon -marm -pipe -fpic -mfloat-abi=softfp -mfpu=neon -finline-limit=300 -ffast-math -Wno-psabi -Wa,--noexecstack -DANDROID -DNDEBUG -mfloat-abi=softfp -mfpu=neon"
export LDFLAGS="-Wl,--fix-cortex-a8 -Wl,--no-undefined"

export CXX=arm-linux-androideabi-g++
export LD=arm-linux-androideabi-ld
export LINK=arm-linux-androideabi-gcc

export PKG_CONFIG_PATH=$PWD/prefix/lib/pkgconfig

echo Installing to: $PREFIX

SHARED_OR_STATIC="
--enable-shared \
--disable-static
"

HOST_ARG="--host arm-linux-androideabi" # Fails for libav

LIBAV_VERSION=libav-11.9
TAGLIB_VERSION=taglib-1.10
FFTW_VERSION=fftw-3.3.2
LIBSAMPLERATE_VERSION=libsamplerate-0.1.8
LIBYAML_VERSION=yaml-0.1.5
QT_SOURCE_URL=http://download.qt-project.org/official_releases/qt/4.8/4.8.6/qt-everywhere-opensource-src-4.8.6.tar.gz
GAIA_VERSION=v2.4.4

LIBAV_AUDIO_FLAGS=" --enable-cross-compile --target-os=android --cross-prefix=arm-linux-androideabi- --arch=arm --enable-neon
    --disable-doc
    --disable-debug
    --disable-avconv
    --disable-avplay
    --disable-avprobe 
    --disable-avserver 
    --disable-avdevice  
    --disable-swscale 
    --disable-avfilter 
    --disable-network 
    --disable-indevs 
    --disable-outdevs
    --disable-muxers
    --disable-demuxers
    --disable-encoders
    --disable-decoders
    --disable-bsfs
    --disable-filters
    --disable-parsers
    --disable-protocols
    --disable-hwaccels

    --enable-protocol=file
    --enable-protocol=pipe

    --enable-demuxer=aac
    --enable-demuxer=ape
    --enable-demuxer=flac
    --enable-demuxer=mp3
    --enable-demuxer=ogg
    --enable-demuxer=wav

    --enable-decoder=aac
    --enable-decoder=aac_latm
    --enable-decoder=ac3
    --enable-decoder=alac
    --enable-decoder=als
    --enable-decoder=ape
    --enable-decoder=atrac1
    --enable-decoder=atrac3
    --enable-decoder=eac3
    --enable-decoder=flac
    --enable-decoder=mp3
    --enable-decoder=mp3float
    --enable-decoder=mp3adu
    --enable-decoder=mp3adufloat
    --enable-decoder=mp3on4
    --enable-decoder=mp3on4float
    --enable-decoder=vorbis


    --enable-parser=aac
    --enable-parser=aac_latm
    --enable-parser=ac3
    --enable-parser=flac
    --enable-parser=mpegaudio
    --enable-parser=vorbis
"

#    --enable-decoder=pcm_alaw    --enable-decoder=pcm_bluray    --enable-decoder=pcm_dvd    --enable-decoder=pcm_f32be    --enable-decoder=pcm_f32le
#    --enable-decoder=pcm_f64be    --enable-decoder=pcm_f64le    --enable-decoder=pcm_lxf    --enable-decoder=pcm_mulaw    --enable-decoder=pcm_s8
#    --enable-decoder=pcm_s8_planar    --enable-decoder=pcm_s16be    --enable-decoder=pcm_s16be_planar    --enable-decoder=pcm_s16le    --enable-decoder=pcm_s16le_planar
#    --enable-decoder=pcm_s24be    --enable-decoder=pcm_s24daud    --enable-decoder=pcm_s24le    --enable-decoder=pcm_s24le_planar    --enable-decoder=pcm_s32be
#    --enable-decoder=pcm_s32le    --enable-decoder=pcm_s32le_planar    --enable-decoder=pcm_u8    --enable-decoder=pcm_u16be    --enable-decoder=pcm_u16le
#    --enable-decoder=pcm_u24be    --enable-decoder=pcm_u24le    --enable-decoder=pcm_u32be    --enable-decoder=pcm_u32le    --enable-decoder=pcm_zork

#    --enable-demuxer=pcm_alaw    --enable-demuxer=pcm_mulaw    --enable-demuxer=pcm_f64be    --enable-demuxer=pcm_f64le    --enable-demuxer=pcm_f32be
#    --enable-demuxer=pcm_f32le    --enable-demuxer=pcm_s32be    --enable-demuxer=pcm_s32le    --enable-demuxer=pcm_s24be    --enable-demuxer=pcm_s24le
#    --enable-demuxer=pcm_s16be    --enable-demuxer=pcm_s16le    --enable-demuxer=pcm_s8    --enable-demuxer=pcm_u32be    --enable-demuxer=pcm_u32le
#    --enable-demuxer=pcm_u24be    --enable-demuxer=pcm_u24le    --enable-demuxer=pcm_u16be    --enable-demuxer=pcm_u16le    --enable-demuxer=pcm_u8

# see http://www.fftw.org/install/windows.html
FFTW_FLAGS=" ${HOST_ARG}
    --enable-float \
    --enable-neon \
    --with-incoming-stack-boundary=2 \
    --with-our-malloc16 
"

LIBSAMPLERATE_FLAGS=" ${HOST_ARG}
    --disable-fftw \
    --disable-sndfile 
"

export CROSS_COMPILE=arm-linux-androideabi

export QT_FLAGS=" -fast -no-exceptions 
-no-largefile 
-no-accessibility 
-no-opengl
-no-sql-db2 -no-sql-ibase -no-sql-mysql -no-sql-oci -no-sql-odbc -no-sql-psql -no-sql-sqlite -no-sql-sqlite2 -no-sql-sqlite_symbian -no-sql-symsql -no-sql-tds
-no-qt3support -no-xmlpatterns -no-multimedia -no-audio-backend -no-phonon -no-phonon-backend -no-svg -no-webkit -no-javascript-jit -no-script -no-scripttools
-no-declarative -no-declarative-debug -no-gif -no-libtiff -no-libpng -no-libjpeg -no-openssl -optimized-qmake -no-gui -no-nis -no-iconv -no-pch -no-dbus -reduce-relocations
-nomake demos -nomake examples -nomake tests"
