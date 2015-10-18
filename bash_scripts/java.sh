#!/bin/bash

# This script attempts to install JAVA SDK 1.8.0_51
#
FILENAME=jdk-8u51-linux-x64.tar.gz
JAVA_VERSION=1.8.0_51

cd /opt

if [ ! -f /opt/$FILENAME ]; then
    sudo wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u51-b16/$FILENAME"
fi

if [ ! -d /opt/jdk$JAVA_VERSION ]; then
    sudo tar xzf $FILENAME
fi

cd /opt/jdk$JAVA_VERSION

sudo alternatives --install /usr/bin/java java /opt/jdk$JAVA_VERSION/bin/java 2

# setup javac and jar commands
#
sudo alternatives --install /usr/bin/jar jar /opt/jdk$JAVA_VERSION/bin/jar 2
sudo alternatives --install /usr/bin/javac javac /opt/jdk$JAVA_VERSION/bin/javac 2
sudo alternatives --set jar /opt/jdk$JAVA_VERSION/bin/jar
sudo alternatives --set javac /opt/jdk$JAVA_VERSION/bin/javac

sudo alternatives --config java

# After installing Java 1.8 we setup the environment variables
#
JAVA_VERSION=1.8.0_51
JAVA_HOME=/usr/jdk$JAVA_VERSION
PATH=$JAVA_HOME/bin:$PATH
export PATH JAVA_HOME
export CLASSPATH=.

# display the version information
java -version

# cleanup file
sudo rm $FILENAME
