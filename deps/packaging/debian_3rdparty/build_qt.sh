#!/bin/sh
. ../build_config.sh

echo $PREFIX
export CC=
export CXX=
export LD=
export CFLAGS=
export LDFLAGS=
export CXXFLAGS=

rm -rf tmp
mkdir tmp
cd tmp

7z x ../4.8.2-411qt-src.7z
tar -xzvf ../openssl-1.0.0d.tar.gz
mv openssl-1.0.0d           $PREFIX/openssl
cp ../qt/configure             Android/Qt/482/qt-src/configure
cp ../qt/openssl.pri           Android/Qt/482/qt-src/src/3rdparty/android/src/openssl/openssl.pri
cp ../qt/src.pro               Android/Qt/482/qt-src/src/src.pro
cp ../qt/ssl.pri               Android/Qt/482/qt-src/src/network/ssl/ssl.pri # Disable hardcoded OpenSSL
cp ../qt/qmake.conf            Android/Qt/482/qt-src/mkspecs/android-g++/qmake.conf # global no-exceptions. SORRY ME!! T_T
cp ../qt/androidconfigbuild.sh Android/Qt/482/qt-src/android/androidconfigbuild.sh # little patch
cd Android/Qt/482/qt-src/
android/androidconfigbuild.sh -n "$HOME/.android/android-ndk-r10e" -o "linux-x86_64" -v "4.8" -l "17"

export ANDROID_NDK_ROOT=$HOME/.android/android-ndk-r10e
export ANDROID_NDK_HOST=linux-x86_64
export ANDROID_NDK_TOOLCHAIN_PREFIX=arm-linux-androideabi
export ANDROID_NDK_TOOLCHAIN_VERSION=4.8
export ANDROID_NDK_TOOLS_PREFIX=arm-linux-androideabi
export ANDROID_TARGET_ARCH=armeabi-v7a
export ANDROID_PLATFORM=17
export ANDROID_NDK_PLATFORM=android-17

make -j5
make install

cd ../..
