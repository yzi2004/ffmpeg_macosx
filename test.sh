#!/bin/bash

#!/bin/bash

BASE="/Volumes/dev/ffmpeg"
SOURCE="${BASE}/sources"
BUILD="${BASE}/build"
TOOLS="${BASE}/tools"
PREBUILT="${BASE}/prebuilt"

export PATH=${TOOLS}/bin:$PATH
export CC=clang 
export PKG_CONFIG_PATH="${PREBUILT}/lib/pkgconfig"


$SOURCE/ffmpeg/configure --prefix=${PREBUILT} \
   --extra-cflags="-fno-stack-check" \
   --arch=arm64 \
   --cc=/usr/bin/clang \
   --enable-gpl \
   --enable-version3 \
   --pkg-config-flags=--static \
   --disable-ffplay \
   --enable-postproc \
   --enable-nonfree \
   --enable-runtime-cpudetect

make -j 8
