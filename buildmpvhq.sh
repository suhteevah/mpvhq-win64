#!/bin/bash

echo "Cloning mpvhq from github"

cd /home/sativa/mpvhq

git pull

echo "Configuring mpvhq"

python ./bootstrap.py

export PATH=/opt/mxe/usr/bin/:$PATH
DEST_OS=win32 TARGET=x86_64-w64-mingw32.static ./waf configure

echo "Building mpvhq"

./waf build

echo "Moving files into home"
cd /home/sativa/mpvhq/build

cp mpv.com /home/sativa/mpv.com
cp mpv.exe /home/sativa/mpv.exe

cd /home/sativa/

upx mpv.exe
upx mpv.com

echo "Finished"
