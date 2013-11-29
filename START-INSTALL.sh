#!/bin/bash

sed -i 's/deb cdrom:/#deb cdrom:/g' /etc/apt/sources.list

apt-get update
apt-get install sudo
apt-get install unzip
apt-get install vim --force-yes
apt-get install java-common

mkdir /cedromsni
cd !$

wget https://github.com/querbes/querbes/archive/master.zip
unzip master.zip
mv querbes-master/ install/
cd install

dpkg -i source/oracle-java7-installer_7u25.deb
./ElasticSearch-Init.sh  