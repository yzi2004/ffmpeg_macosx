#!/bin/bash

BASE="/Volumes/dev/ffmpeg"
SOURCE="${BASE}/sources"
BUILD="${BASE}/build"
TOOLS="${BASE}/tools"
PREBUILT="${BASE}/prebuilt"

export PATH=${TOOLS}/bin:$PATH
export CC=clang 
export PKG_CONFIG_PATH="${PREBUILT}/lib/pkgconfig"

rm -rf $BUILD
rm -rf $PREBUILT

export LIBTOOL=`which glibtool`
export LIBTOOLIZE=`which glibtoolize`

########################
# yasm compile         #
########################
mkdir -p $BUILD/yasm && cd $BUILD/yasm
$SOURCE/yasm/configure --prefix=$TOOLS
make -j 8 && make install

########################
# nasm compile         #
########################
cd $SOURCE/nasm
./configure --prefix=$TOOLS
make -j 8 && make install


########################
# nasm compile         #
########################
mkdir -p $BUILD/gettext && cd $BUILD/gettext
$SOURCE/gettext/configure --prefix=$TOOLS \
    --disable-dependency-tracking \
    --disable-silent-rules \
    --disable-debug \
    --disable-shared \
    --enable-static \
    --with-included-gettext \
    --with-included-glib \
    --with-includedlibcroco \
    --with-included-libunistring \
    --with-emacs \
    --disable-java \
    --disable-csharp \
    --without-git \
    --without-cvs \
    --without-xz

make -j 8 && make install

########################
# pkg-config compile   #
########################
export LDFLAGS="-framework Foundation -framework Cocoa"
mkdir -p $BUILD/pkg-config && cd $BUILD/pkg-config
$SOURCE/pkg-config/augogen --prefix=${TOOLS} \
     --with-pc-path=${PREBUILT}/lib/pkgconfig \
     --with-internal-glib \
     --disable-shared \
     --enable-static

make -j 8 && make install
unset LDFLAGS

########################
# zlib compile         #
########################
mkdir -p $BUILD/zlib && cd $BUILD/zlib
$SOURCE/zlib/configure --prefix=$PREBUILT
make -j 8 && make install

rm ${PREBUILT}/lib/libz.so*
rm ${PREBUILT}/lib/libz.*

########################
# cmake compile        #
########################
mkdir -p $BUILD/cmake && cd $BUILD/cmake
$SOURCE/cmake/configure --prefix=$TOOLS \
    --system-zlib
make -j 8 && make install

########################
# mp3lame compile      #
########################
mkdir -p $BUILD/mp3lame && cd $BUILD/mp3lame
$SOURCE/mp3lame/configure --prefix=$PREBUILT \
    --disable-shared \
    --enable-static
make -j 8 && make install

########################
# x264 compile         #
########################
mkdir -p $BUILD/x264 && cd $BUILD/x264
$SOURCE/x264/configure --prefix=$PREBUILT \
    --enable-static \
    --enable-pic
make -j 8 && make install && make install-lib-static

########################
# x265 compile         #
########################

mkdir -p $BUILD/x265 && cd $BUILD/x265
cmake  -DCMAKE_INSTALL_PREFIX:PATH=${PREBUILT} \
      -DHIGH_BIT_DEPTH=ON \
      -DMAIN12=ON \
      -DENABLE_SHARED=NO \
      -DEXPORT_C_API=NO \
      -DENABLE_CLI=OFF \
      $SOURCE/x265/source
make -j 8 
mv libx265.a libx265_main12.a
make clean-generated && rm CMakeCache.txt

cmake  -DCMAKE_INSTALL_PREFIX:PATH=${PREBUILT} \
      -DMAIN10=ON \
      -DHIGH_BIT_DEPTH=ON \
      -DENABLE_SHARED=NO \
      -DEXPORT_C_API=NO \
      -DENABLE_CLI=OFF \
      $SOURCE/x265/source
make clean && make -j 8 

mv libx265.a libx265_main10.a
make clean-generated && rm CMakeCache.txt

cmake  -DCMAKE_INSTALL_PREFIX:PATH=${PREBUILT} \
      -DEXTRA_LIB="x265_main10.a;x265_main12.a" \
      -DEXTRA_LINK_FLAGS=-L. \
      -DLINKED_12BIT=ON \
      -DLINKED_10BIT=ON \
      -DENABLE_SHARED=OFF \
      -DENABLE_CLI=OFF \
      $SOURCE/x265/source
make clean && make -j 8 

mv libx265.a libx265_main.a
libtool -static -o libx265.a libx265_main.a libx265_main10.a libx265_main12.a 2>/dev/null
make install

########################
# vpx compile          #
########################

mkdir -p $BUILD/libvpx && cd $BUILD/libvpx
$SOURCE/libvpx/configure --prefix=${PREBUILT}
    --enable-vp8 \
    --enable-postproc \
    --enable-vp9-postproc \
    --enable-vp9-highbitdepth \
    --disable-examples \
    --disable-docs \
    --enable-multi-res-encoding \
    --disable-unit-tests \
    --enable-pic \
    --disable-shared
    
make -j 8 && make install

########################
# EXPAT compile        #
########################

mkdir -p $BUILD/expat && cd $BUILD/expat
cmake -DCMAKE_INSTALL_PREFIX:PATH=${PREBUILT} \
    -DEXPAT_BUILD_DOCS=OFF \
    -DEXPAT_BUILD_EXAMPLES=OFF \
    -DEXPAT_BUILD_PKGCONFIG=ON \
    -DEXPAT_BUILD_TESTS=OFF \
    -DEXPAT_BUILD_TOOLS=OFF \
    -DEXPAT_SHARED_LIBS=OFF \
    $SOURCE/libexpat/expat
    
make -j 8 && make install

########################
# libiconv compile     #
########################

mkdir -p $BUILD/libiconv && cd $BUILD/libiconv
$SOURCE/libiconv/configure --prefix=${PREBUILT} \
    --disable-shared \
    --enable-static
    
make -j 8 && make install

########################
# enca compile     #
########################

mkdir -p $BUILD/enca && cd $BUILD/enca
$SOURCE/enca/configure --prefix=${PREBUILT} \
    --disable-shared \
    --enable-static
    
make -j 8 && make install


