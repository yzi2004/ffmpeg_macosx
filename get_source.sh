#!/bin/bash

# turn the detached message off
git config --global advice.detachedHead false

BASE="/Volumes/dev/"
SOURCE="${BASE}/sources"
TOOLS="${BASE}/tools/bin"

mkdir ${SOURCE} && cd ${SOURCE}

echo '◆◆' Start download cmake
git clone https://github.com/Kitware/CMake.git cmake -b v3.25.1 --depth 1

echo '◆◆' Start download pkg-config
git clone --depth 1 https://gitlab.freedesktop.org/pkg-config/pkg-config.git pkg-config

echo '◆◆' Start download nasm
wget https://www.nasm.us/pub/nasm/releasebuilds/2.16.01/nasm-2.16.01.tar.bz2 -O nasm-2.16.01.tar.bz2
tar zxvf cmake-3.25.1.tar.gz && mv cmake-3.25.1 cmake && rm cmake-3.25.1.tar.gz

echo '◆◆' Start download yasm
wget http://www.tortall.net/projects/yasm/releases/yasm-1.3.0.tar.gz -O yasm-1.3.0.tar.gz

echo '◆◆' Start download zlib
wget https://zlib.net/zlib-1.2.13.tar.gz -O zlib-1.2.13.tar.gz

echo '◆◆' Start download expat
git clone https://github.com/libexpat/libexpat.git -b R_2_5_0 --depth 1

echo '◆◆' Start download libiconv
wget https://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.17.tar.gz -O libiconv-1.17.tar.gz

echo '◆◆' Start download gettext
wget https://ftp.gnu.org/gnu/gettext/gettext-0.21.1.tar.xz -O gettext-0.21.1.tar.xz

echo '◆◆' Start download mp3lame
wget https://sourceforge.net/projects/lame/files/lame/3.100/lame-3.100.tar.gz/download  -O lame-3.100.tar.gz

echo '◆◆' Start download x264
git clone --depth 1 https://code.videolan.org/videolan/x264.git

echo '◆◆' Start download x265
git clone https://bitbucket.org/multicoreware/x265_git.git x265 -b Release_3.4

echo '◆◆' Start download fdk-aac
git clone --depth 1 https://github.com/mstorsjo/fdk-aac.git -b v2.0.2 --depth 1

echo '◆◆' Start download vpx


echo '◆◆' Start download libpng

echo '◆◆' Start download enca

echo '◆◆' Start download freetype

echo '◆◆' Start download fribidi
git clone https://github.com/fribidi/fribidi.git -b v1.0.12 --depth 1 

echo '◆◆' Start download ffontconfig

echo '◆◆' Start download harfbuzz
git clone --depth 1 https://github.com/harfbuzz/harfbuzz.git -b 6.0.0

echo '◆◆' Start download libass
git clone --depth 1 https://github.com/libass/libass.git -b 0.17.0

echo '◆◆' Start download vidstab

echo '◆◆' Start download snappy

echo '◆◆' Start download openjpeg

echo '◆◆' Start download aom

echo '◆◆' Start download libwebp

echo '◆◆' Start download zimg

