#!/bin/bash

sed -i 's/deb cdrom:/#deb cdrom:/g' /etc/apt/sources.list

apt-get update

#################################################################
# INSTALLATION D'UTILITAIRES                                    #
#---------------------------------------------------------------#
apt-get install sudo unzip java-common
apt-get -y install vim

#################################################################
# INSTALLATION DE Nginx                                         #
#---------------------------------------------------------------#
apt-get install nginx-common apache2-utils iptables-persistent

#################################################################
# INSTALLATION DE JAVA 1.7u25                                   #
#---------------------------------------------------------------#
dpkg -i source/oracle-java7-installer_7u25.deb


