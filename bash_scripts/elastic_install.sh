#!/bin/sh

VERSION=jdk1.8.0_74
cd /tmp
rm -f *.rpm
wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u74-b02/jdk-8u74-linux-x64.rpm"
sudo rpm -ivh jdk-8u74-linux-x64.rpm

sudo alternatives --install /usr/bin/java java /usr/java/${VERSION}/jre/bin/java 40000
sudo alternatives --install /usr/bin/javac javac /usr/java/${VERSION}/bin/javac 40000
sudo alternatives --set java /usr/java/${VERSION}/jre/bin/java
sudo alternatives --set javac /usr/java/${VERSION}/bin/javac

sudo rpm --import http://packages.elastic.co/GPG-KEY-elasticsearch

echo '[elasticsearch-2.x]
name=Elasticsearch repository for 2.x packages
baseurl=http://packages.elastic.co/elasticsearch/2.x/centos
gpgcheck=1
gpgkey=http://packages.elastic.co/GPG-KEY-elasticsearch
enabled=1
' | sudo tee /etc/yum.repos.d/elasticsearch.repo

sudo yum -y install elasticsearch

# make sure to edit /etc/elasticsearch/elasticsearch.yml
# To restrict outsiders from reading your data / shutdown your ES cluster through HTTP API,
# find the line that specifies network.host, uncomment it, and replace it with the value "localhost"
# i.e. network.host: localhost
# save the file and exit
# 

# start elastic search
#sudo systemctl start elasticsearch

# enable elastic search on boot
sudo systemctl enable elasticsearch
