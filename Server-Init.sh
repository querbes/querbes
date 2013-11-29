#!/bin/bash

sed -i 's/deb cdrom:/#deb cdrom:/g' /etc/apt/sources.list

apt-get update
apt-get install sudo
apt-get install unzip
apt-get -y install vim
apt-get install java-common

dpkg -i source/oracle-java7-installer_7u25.deb