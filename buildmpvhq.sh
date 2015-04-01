#!/bin/bash

echo "Cloning mpvhq from github"

git clone https://github.com/haasn/mpvhq.git

echo "Configuring mpvhq"

cd mpvhq

python ./bootstrap.py

DEST_OS=win32 TARGET=x86_64-w64-mingw32.static ./waf configure

echo "Building mpvhq"

./waf build

echo "Moving files into new dated folder"
cd ~/mpvhq/build

cp mpv.com ~/mpvhq.com_`date +%d%b%Y`
cp mpv.exe ~/mpvhq.exe_`date +%d%b%Y`


