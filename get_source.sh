#!/bin/bash

# turn the detached message off
git config --global advice.detachedHead false

BASE="/Volumes/dev/"
SOURCE="${BASE}/sources"
TOOLS="${BASE}/tools/bin"

rm -rf ${SOURCE} 
mkdir ${SOURCE} && cd ${SOURCE}

echo '◆◆' Start download cmake
git clone https://github.com/Kitware/CMake.git cmake -b v3.25.1 --depth 1

echo '◆◆' Start download pkg-config
git clone --depth 1 https://gitlab.freedesktop.org/pkg-config/pkg-config.git pkg-config

echo '◆◆' Start download nasm
curl -# https://www.nasm.us/pub/nasm/releasebuilds/2.16.01/nasm-2.16.01.tar.bz2 > nasm-2.16.01.tar.bz2 
tar jxvf nasm-2.16.01.tar.bz2 && mv nasm-2.16.01 nasm && rm nasm-2.16.01.tar.bz2

echo '◆◆' Start download yasm
curl -# http://www.tortall.net/projects/yasm/releases/yasm-1.3.0.tar.gz > yasm-1.3.0.tar.gz
tar zxvf yasm-1.3.0.tar.gz && mv yasm-1.3.0 yasm && rm yasm-1.3.0.tar.gz

echo '◆◆' Start download zlib
curl -# https://zlib.net/zlib-1.2.13.tar.gz > zlib-1.2.13.tar.gz
tar zxvf zlib-1.2.13.tar.gz && mv zlib-1.2.13 zlib && rm zlib-1.2.13.tar.gz

echo '◆◆' Start download expat
git clone https://github.com/libexpat/libexpat.git -b R_2_5_0 --depth 1

echo '◆◆' Start download libiconv
curl https://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.17.tar.gz > libiconv-1.17.tar.gz
tar zxvf libiconv-1.17.tar.gz && mv libiconv-1.17 libiconv && rm libiconv-1.17.tar.gz

echo '◆◆' Start download gettext
curl https://ftp.gnu.org/gnu/gettext/gettext-0.21.1.tar.xz > gettext-0.21.1.tar.xz
tar zxvf gettext-0.21.1.tar.xz && mv gettext-0.21.1 gettext && rm gettext-0.21.1.tar.xz

echo '◆◆' Start download mp3lame
curl -# -L https://sourceforge.net/projects/lame/files/lame/3.100/lame-3.100.tar.gz/download > lame-3.100.tar.gz
tar zxvf lame-3.100.tar.gz && mv lame-3.100 mp3lame && rm lame-3.100.tar.gz

echo '◆◆' Start download x264
git clone --depth 1 https://code.videolan.org/videolan/x264.git

echo '◆◆' Start download x265
git clone https://bitbucket.org/multicoreware/x265_git.git x265 -b Release_3.4

echo '◆◆' Start download fdk-aac
git clone --depth 1 https://github.com/mstorsjo/fdk-aac.git -b v2.0.2 --depth 1

echo '◆◆' Start download vpx
git clone --depth 1 https://chromium.googlesource.com/webm/libvpx -b v1.12.0

echo '◆◆' Start download libpng
curl -# -L http://prdownloads.sourceforge.net/libpng/libpng-1.6.39.tar.gz?download > libpng-1.6.39.tar.gz
tar zxvf libpng-1.6.39.tar.gz && mv libpng-1.6.39 libpng && rm libpng-1.6.39.tar.gz

echo '◆◆' Start download enca
curl -# https://dl.cihar.com/enca/enca-1.19.tar.gz > enca-1.19.tar.gz
tar zxvf enca-1.19.tar.gz && mv enca-1.19 enca && rm enca-1.19.tar.gz

echo '◆◆' Start download freetype
curl -# https://download.savannah.gnu.org/releases/freetype/freetype-2.12.1.tar.gz > freetype-2.12.1.tar.gz
tar zxvf freetype-2.12.1.tar.gz && mv freetype-2.12.1 freetype && rm freetype-2.12.1.tar.gz

echo '◆◆' Start download fribidi
git clone https://github.com/fribidi/fribidi.git -b v1.0.12 --depth 1 

echo '◆◆' Start download fontconfig
curl -#  https://www.freedesktop.org/software/fontconfig/release/fontconfig-2.14.1.tar.gz > fontconfig-2.14.1.tar.gz
tar zxvf fontconfig-2.14.1.tar.gz && mv fontconfig-2.14.1 fontconfig && rm fontconfig-2.14.1.tar.gz

echo '◆◆' Start download harfbuzz
git clone --depth 1 https://github.com/harfbuzz/harfbuzz.git -b 6.0.0

echo '◆◆' Start download libass
git clone --depth 1 https://github.com/libass/libass.git -b 0.17.0

echo '◆◆' Start download vidstab
git clone --depth 1 https://github.com/georgmartius/vid.stab.git -b v1.1.0

echo '◆◆' Start download snappy
git clone --deptn 1 https://github.com/google/snappy.git -b 1.1.9

echo '◆◆' Start download openjpeg
git clone --depth 1 https://github.com/uclouvain/openjpeg.git -b v2.5.0

echo '◆◆' Start download aom
git clone --depth 1 https://aomedia.googlesource.com/aom -b v3.5.0

echo '◆◆' Start download libwebp
git clone --depth 1  https://chromium.googlesource.com/webm/libwebp -b v1.2.4

echo '◆◆' Start download zimg
git clone --depth 1 https://github.com/sekrit-twc/zimg.git -b release-3.0.4
