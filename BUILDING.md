Compiling for Windows
=====================

Compiling for Windows is supported with MinGW-w64. This can be used to produce
both 32-bit and 64-bit executables, and it works for building on Windows and
cross-compiling from Linux and Cygwin. MinGW-w64 is available from:
http://mingw-w64.sourceforge.net.

While building a complete MinGW-w64 toolchain yourself is possible, there are a
few build environments and scripts to help ease the process, such as MSYS2 and
MXE. Note that MinGW environments included in Linux distributions are often
broken, outdated and useless, and usually don't use MinGW-w64.

**Warning**: the original MinGW (http://www.mingw.org) is unsupported.

Cross-compilation
=================

When cross-compiling, you have to run mpv's configure with these arguments:

```bash
DEST_OS=win32 TARGET=i686-w64-mingw32 ./waf configure
```

[MXE](http://mxe.cc) makes it very easy to bootstrap a complete MingGW-w64
environment from a Linux machine. See a working example below.

Alternatively, you can try [mingw-w64-cmake](https://github.com/lachs0r/mingw-w64-cmake),
which bootstraps a MinGW-w64 environment and builds mpv and dependencies.

Example with MXE
----------------

```bash
# Before starting, make sure you install MXE prerequisites. MXE will download
# and build all target dependencies, but no host dependencies. For example,
# you need a working compiler, or MXE can't build the crosscompiler.
#
# Refer to
#
#    http://mxe.cc/#requirements
#
# Scroll down for disto/OS-specific instructions to install them.

# Download MXE. Note that compiling the required packages requires about 1.4 GB
# or more!

cd /opt
git clone https://github.com/mxe/mxe mxe
cd mxe

# Set build options.

# The JOBS environment variable controls threads to use when building. DO NOT
# use the regular `make -j4` option with MXE as it will slow down the build.
# Alternatively, you can set this in the make command by appending "JOBS=4"
# to the end of command:
echo "JOBS := 4" >> settings.mk

# The MXE_TARGET environment variable builds MinGW-w64 for 32 bit targets.
# Alternatively, you can specify this in the make command by appending
# "MXE_TARGETS=i686-w64-mingw32" to the end of command:
echo "MXE_TARGETS := i686-w64-mingw32.static" >> settings.mk

# If you want to build 64 bit version, use this:
# echo "MXE_TARGETS := x86_64-w64-mingw32.static" >> settings.mk

# Build required packages. The following provide a minimum required to build
# a reasonable mpv binary (though not an absolute minimum).

make gcc ffmpeg libass jpeg pthreads lua librtmp lcms

# Add MXE binaries to $PATH
export PATH=/opt/mxe/usr/bin/:$PATH

# Build mpv. The target will be used to automatically select the name of the
# build tools involved (e.g. it will use i686-w64-mingw32.static-gcc).

cd ..
git clone https://github.com/mpv-player/mpv.git
cd mpv
python ./bootstrap.py
DEST_OS=win32 TARGET=i686-w64-mingw32.static ./waf configure
# Or, if 64 bit version,
# DEST_OS=win32 TARGET=x86_64-w64-mingw32.static ./waf configure
./waf build
```
