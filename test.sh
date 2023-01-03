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


cat << EOF > libmp3lame.pc 
> prefix=aaaa
> exec_prefix=\${prefix}
> libdir=\${exec_prefix}/lib
> includedir=\${prefix}/include
> 
>  Name: libmp3lame
>  Description: lame mp3 encoder library
>  Version: 3.100
> 
>  Requires:
>  Libs: -L\${libdir} -lmp3lame
>  Cflags: -I\${includedir}
>  EOF
