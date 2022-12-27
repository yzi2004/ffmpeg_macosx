#! bin/bash

BASE="/Volumes/dev/"
SOURCE="${BASE}/sources"
TOOLS="${BASE}/bin"

mkdir ${SOURCE}
mkdir ${TOOLS}
export PATH=${TOOLS}/bin:$PATH

export CC=clang 
export PKG_CONFIG_PATH="${SOURCE}/lib/pkgconfig"
