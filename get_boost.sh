#!/bin/sh

DOT_VERSION=1.59.0
UNDERSCORE_VERSION=1_59_0

[ -d boost-src ] && rm -rf boost-src
[ -d boost-src ] || mkdir -p boost-src
cd boost-src
wget -O boost_$UNDERSCORE_VERSION.tar.gz http://sourceforge.net/projects/boost/files/boost/$DOT_VERSION/boost_$UNDERSCORE_VERSION.tar.gz/download
tar xzvf boost_$UNDERSCORE_VERSION.tar.gz
mv boost_$UNDERSCORE_VERSION boost
cd boost

if [[ "$OSTYPE" == "darwin"* ]]; then
    sudo brew update
    ./bootstrap.sh --prefix=/usr/local/boost159 cxxflags="-arch i386 -arch x86_64" \
        address-model=32_64 threading=multi macos-version=10.10 stage
    ./b2 threading=multi link=static runtime-link=static \
        cxxflags="-stdlib=libstdc++" linkflags="-stdlib=libstdc++"
    find . -name \*.o -print0 | xargs -0 rm
    find . -name \*.a -print0 | xargs -0 rm
    ./b2 threading=multi link=static runtime-link=static \
        cxxflags="-stdlib=libc++" linkflags="-stdlib=libc++"
elif [[ "$OSTYPE" == "linux-gnu" ]]; then
    sudo apt-get update
    sudo apt-get install build-essential g++ python-dev autotools-dev libicu-dev libbz2-dev
    ./bootstrap.sh --prefix=/usr/local
    $user_configFile=`find $PWD -name user-config.jam`
    echo "using mpi ; " >> $user_configFile
    n=`cat /proc/cpuinfo | grep "cpu cores" | uniq | awk '{print $NF}'`
    sudo ./b2 --with=all -j $n install
    sudo sh -c 'echo "/usr/local/lib" >> /etc/ld.so.conf.d/local.conf'
    sudo ldconfig
fi
