#!/bin/bash


#################################################################
# GESTIONNAIRE D'APPLICATIONS (APT)                             #
#---------------------------------------------------------------#
sed -i 's/deb cdrom:/#deb cdrom:/g' /etc/apt/sources.list
apt-get update

#################################################################
# INSTALLATION D'UTILITAIRES                                    #
#---------------------------------------------------------------#
apt-get -y install sudo unzip java-common vim

#################################################################
# INSTALLATION DE Nginx                                         #
#---------------------------------------------------------------#
apt-get -y install nginx apache2-utils iptables-persistent

#################################################################
# INSTALLATION DE JAVA 1.7u25                                   #
#---------------------------------------------------------------#
dpkg -i source/oracle-java7-installer_7u25.deb

#################################################################
# OPTIMISATION POUR DISQUE SSD                                  #
#---------------------------------------------------------------#
# On change le mode du I/O Scheduler de CFQ à NOOP              #
#################################################################
echo noop | sudo tee /sys/block/sda/queue/scheduler
sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="quiet"/GRUB_CMDLINE_LINUX_DEFAULT="quiet elevator=noop"/g' /etc/default/grub
sudo update-grub

