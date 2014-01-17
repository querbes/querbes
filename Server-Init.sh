#!/bin/bash

sed -i 's/deb cdrom:/#deb cdrom:/g' /etc/apt/sources.list


#################################################################
# OPTIMISATION POUR DISQUE SSD                                  #
#---------------------------------------------------------------#
# On change le mode du I/O Scheduler de CFQ à NOOP              #
#################################################################
echo noop | sudo tee /sys/block/sda/queue/scheduler
sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="quiet"/GRUB_CMDLINE_LINUX_DEFAULT="quiet elevator=noop"/g' /etc/default/grub
sudo update-grub

#################################################################
# GESTIONNAIRE D'APPLICATIONS                                   #
#---------------------------------------------------------------#
apt-get update

#################################################################
# INSTALLATION D'UTILITAIRES                                    #
#---------------------------------------------------------------#
apt-get install sudo unzip java-common
apt-get -y install vim

#################################################################
# INSTALLATION DE Nginx                                         #
#---------------------------------------------------------------#
apt-get -y install nginx apache2-utils iptables-persistent

#################################################################
# INSTALLATION DE JAVA 1.7u25                                   #
#---------------------------------------------------------------#
dpkg -i source/oracle-java7-installer_7u25.deb



