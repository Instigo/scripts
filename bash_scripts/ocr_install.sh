#!/bin/sh

sudo apt-get install -y autoconf automake libtool 
sudo apt-get install -y libpng12-dev 
sudo apt-get install -y libjpeg62-dev 
sudo apt-get install -y g++ 
sudo apt-get install -y libtiff4-dev 
sudo apt-get install -y libopencv-dev libtesseract-dev 
sudo apt-get install -y git 
sudo apt-get install -y cmake 
sudo apt-get install -y build-essential 
sudo apt-get install -y libleptonica-dev 
sudo apt-get install -y liblog4cplus-dev 
sudo apt-get install -y libcurl3-dev 
sudo apt-get install -y python2.7-dev 
sudo apt-get install -y tk8.5 tcl8.5 tck8.5-dev tcl8.5-dev
sudo apt-get build-dep python-imaging --fix-missing
sudo apt-get install -y imagemagick
sudo apt-get install -y zlib1g-dev
sudo apt-get install -y libicu-dev
sudo apt-get install -y libpango1.0-dev
sudo apt-get install -y libcairo2-dev
sudo apt-get install -y autotools-dev
sudo apt-get install -y automake
sudo apt-get install -y libtool
cd /tmp

$LEPTONICA_VERSION='1.73'
wget http://www.leptonica.org/source/leptonica-${LEPTONICA_VERSION}.tar.gz
tar -zxvf leptonica-${LEPTONICA_VERSION}.tar.gz
cd leptonica-1.70/
sudo ./autobuild
sudo ./configure
sudo make && sudo make install
sudo ldconfig

# Build Tesseract
cd /tmp
wget https://tesseract-ocr.googlecode.com/files/tesseract-ocr-3.02.02.tar.gz
tar -zxvf tesseract-ocr-3.02.02.tar.gz
cd tesseract-ocr
sudo ./autogen.sh
sudo LDFLAGS="-L/usr/local/lib" CFLAGS="-I/usr/local/include" ./configure
sudo make && sudo make install
sudo ldconfig
