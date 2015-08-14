#!/bin/sh

# Install R Language
os_version=`./os_platform.sh`

if [[ $os_version == *"RedHat"* ]] 
then
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
    sudo apt-get update
    sudo apt-get install r-base r-base-dev
elif [[ $os_version == *"centos"* ]]
then
    sudo yum install -y epel-release
    sudo yum update -y
    sudo yum install -y R
fi
