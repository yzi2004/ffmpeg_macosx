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

########################
# autoconf compile     #
########################
if [ ! -e "${TOOLS}/bin/autoconf" ]; then
    mkdir -p $BUILD/autoconf && cd $BUILD/autoconf
    $SOURCE/autoconf/configure --prefix=$TOOLS || exit 1
    make -j 8  || exit 1
    make install
fi


########################
# automake compile     #
########################
if [ ! -e "${TOOLS}/bin/automake" ]; then
    mkdir -p $BUILD/automake && cd $BUILD/automake
    $SOURCE/automake/configure --prefix=$TOOLS || exit 1
    make -j 8 || exit 1
    make install
fi

########################
# libtool compile     #
########################
if [ ! -e "${TOOLS}/bin/glibtool" ]; then
    mkdir -p $BUILD/libtool && cd $BUILD/libtool
    $SOURCE/libtool/configure --prefix=$TOOLS \
        --program-prefix=g || exit 1
    make -j 8 || exit 1
    make install
fi
export LIBTOOL=`which glibtool`
export LIBTOOLIZE=`which glibtoolize`

########################
# yasm compile         #
########################
if [ ! -e "${TOOLS}/bin/yasm" ]; then
    mkdir -p $BUILD/yasm && cd $BUILD/yasm
    $SOURCE/yasm/configure --prefix=$TOOLS || exit 1
    make -j 8 || exit 1
    make install
fi

########################
# nasm compile         #
########################
if [ ! -e "${TOOLS}/bin/nasm" ]; then
    mkdir -p $BUILD/nasm && cd $BUILD/nasm
    $SOURCE/nasm/configure --prefix=$TOOLS || exit 1
    make -j 8 || exit 1
    make install
fi

########################
# gettext compile         #
########################
if [ ! -e "${TOOLS}/bin/gettext" ]; then
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
        --without-xz || exit 1

    make -j 8 || exit 1
    make install
fi

########################
# pkg-config compile   #
########################
if [ ! -e "${TOOLS}/bin/pkg-config" ]; then
    export LDFLAGS="-framework Foundation -framework Cocoa"
    mkdir -p $BUILD/pkg-config && cd $BUILD/pkg-config
    $SOURCE/pkg-config/autogen.sh --prefix=${TOOLS} \
         --with-pc-path=${PREBUILT}/lib/pkgconfig \
         --with-internal-glib \
         --disable-shared \
         --enable-static || exit 1

    make -j 8 || exit 1
    make install
    unset LDFLAGS
fi

########################
# zlib compile         #
########################
mkdir -p $BUILD/zlib && cd $BUILD/zlib
$SOURCE/zlib/configure --prefix=$PREBUILT || exit 1
make -j 8 || exit 1
make install

rm ${PREBUILT}/lib/libz.so*
rm ${PREBUILT}/lib/libz.*

########################
# cmake compile        #
########################
if [ ! -e "${TOOLS}/bin/cmake" ]; then
    mkdir -p $BUILD/cmake && cd $BUILD/cmake
    $SOURCE/cmake/configure --prefix=$TOOLS \
        --system-zlib || exit 1
    make -j 8 || exit 1
    make install
fi

########################
# mp3lame compile      #
########################
mkdir -p $BUILD/mp3lame && cd $BUILD/mp3lame
$SOURCE/mp3lame/configure --prefix=$PREBUILT \
    --disable-shared \
    --enable-static || exit 1
make -j 8 || exit 1
make install

########################
# x264 compile         #
########################
mkdir -p $BUILD/x264 && cd $BUILD/x264
$SOURCE/x264/configure --prefix=$PREBUILT \
    --enable-static \
    --enable-pic || exit 1
make -j 8 || exit 1
make install && make install-lib-static

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
      $SOURCE/x265/source || exit 1
make -j 8  || exit 1
mv libx265.a libx265_main12.a
make clean-generated && rm CMakeCache.txt

cmake  -DCMAKE_INSTALL_PREFIX:PATH=${PREBUILT} \
      -DMAIN10=ON \
      -DHIGH_BIT_DEPTH=ON \
      -DENABLE_SHARED=NO \
      -DEXPORT_C_API=NO \
      -DENABLE_CLI=OFF \
      $SOURCE/x265/source || exit 1
make clean 
make -j 8  || exit 1

mv libx265.a libx265_main10.a
make clean-generated && rm CMakeCache.txt

cmake  -DCMAKE_INSTALL_PREFIX:PATH=${PREBUILT} \
      -DEXTRA_LIB="x265_main10.a;x265_main12.a" \
      -DEXTRA_LINK_FLAGS=-L. \
      -DLINKED_12BIT=ON \
      -DLINKED_10BIT=ON \
      -DENABLE_SHARED=OFF \
      -DENABLE_CLI=OFF \
      $SOURCE/x265/source || exit 1
make clean 
make -j 8 || exit 1

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
    --disable-shared || exit 1
    
make -j 8 || exit 1
make install

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
    $SOURCE/libexpat/expat || exit 1
    
make -j 8 || exit 1
make install

########################
# libiconv compile     #
########################

mkdir -p $BUILD/libiconv && cd $BUILD/libiconv
$SOURCE/libiconv/configure --prefix=${PREBUILT} \
    --disable-shared \
    --enable-static || exit 1
    
make -j 8 || exit 1 
make install

########################
# enca compile     #
########################

mkdir -p $BUILD/enca && cd $BUILD/enca
$SOURCE/enca/configure --prefix=${PREBUILT} \
    --disable-shared \
    --enable-static || exit 1
    
make -j 8 || exit 1
make install

########################
# fdk-aac compile     #
########################
mkdir -p $BUILD/fdk-aac && cd $BUILD/fdk-aac
cmake  -DCMAKE_INSTALL_PREFIX=${PREBUILT} \
     -DBUILD_SHARED_LIBS=off \
     $SOURCE/fdk-aac || exit 1
    
make -j 8 || exit 1
make install

########################
# brotli compile          #
########################
mkdir -p $BUILD/brotli && cd $BUILD/brotli
export LDFLAGS="-static"
cmake  -DCMAKE_INSTALL_PREFIX=${PREBUILT} \
      -DBUILD_TESTING=off \
     $SOURCE/brotli || exit 1
make -j 8 || exit 1
make install
unset LDFLAGS

########################
# aom compile          #
########################
mkdir -p $BUILD/aom && cd $BUILD/aom
cmake  -DCMAKE_INSTALL_PREFIX=${PREBUILT} \
      -DENABLE_TESTS=0 \
      -DLIBTYPE=STATIC \
      -DAOM_TARGET_CPU=ARM64 \
      -DCONFIG_RUNTIME_CPU_DETECT=0 \
     $SOURCE/aom || exit 1

make -j 8 || exit 1
make install

########################
# freetype + harfbuzz  #
########################
mkdir -p $BUILD/freetype && cd $BUILD/freetype
meson setup --prefix=${PREBUILT} \
     --buildtype=release \
     --default-library=static \
     -Dharfbuzz=disabled \
     -Dbrotli=disabled \
     --wrap-mode=nofallback \
     $SOURCE/freetype  || exit 1
     
ninja || exit 1
meson install 

mkdir -p $BUILD/harfbuzz &&  cd $BUILD/harfbuzz
meson setup --prefix=${PREBUILT} \
    --buildtype=release \
    --default-library=static \
    -Dfreetype=enabled \
    -Dgdi=enabled \
    -Dtests=disabled \
    -Ddocs=disabled \
    --wrap-mode=nofallback \
    $SOURCE/harfbuzz  || exit 1
ninja || exit 1
meson install 

mkdir -p $BUILD/freetype_with_harfbuzz &&  cd $BUILD/freetype_with_harfbuzz
meson setup --prefix=${PREBUILT} \
     --buildtype=release \
     --default-library=static \
     --wrap-mode=nofallback \
     $SOURCES_PATH/freetype  || exit 1
ninja || exit 1
meson install 
