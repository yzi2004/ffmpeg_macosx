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
if [ $1 == "rebuild*" ]; then
    rm -rf $PREBUILT
fi

if [ $1 == "rebuild_all*" ]; then
    rm -rf $TOOLS
fi
