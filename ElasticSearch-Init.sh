#!/bin/bash


################ Parameters ##################
if [ -n $1 ]
then
	SITE=$1
else
	SITE='Dev'
fi

if [ -n $2 ]
then
	MEMSIZE_A=$2
else
	MEMSIZE_A='512m'
fi
if [ -n $3 ]
then
	MEMSIZE_B=$3
else
	MEMSIZE_B='512m'
fi
if [ -n $4 ]
then
	MEMSIZE_M=$4
else
	MEMSIZE_M='256m'
fi
################ Constantes ##################

#Cleanup
userdel elasticsearch
groupdel elasticsearch
rm -r /etc/elasticsearch*
rm -r /usr/share/elasticsearch*
rm /etc/init.d/elasticsearch*
rm /etc/default/elasticsearch*

#Adresse IP de la machine courante
HOST=`hostname`
IPCONF=`ifconfig eth0 | awk '/inet addr/ {split ($2,A,":"); print A[2]}'`
sed -i 's/{IP_ADDRESS}/'$IPCONF'/g' configs/elasticsearch_*.yml
sed -i 's/{HOSTNAME}/'$HOST'/g' configs/elasticsearch_*.yml
sed -i 's/{SITENAME}/'$SITE'/g' configs/elasticsearch_*.yml

#Memoire souhaitée pour les noeuds a,b et m
sed -i 's/{CEDROM-HEAP_SIZE}/'$MEMSIZE_A'/g' scripts/default/elasticsearch_a
sed -i 's/{CEDROM-HEAP_SIZE}/'$MEMSIZE_B'/g' scripts/default/elasticsearch_b
sed -i 's/{CEDROM-HEAP_SIZE}/'$MEMSIZE_M'/g' scripts/default/elasticsearch_m

#Creation des utilisateurs
groupadd elasticsearch
useradd -g elasticsearch elasticsearch

#Creation des répertoires
mkdir /etc/elasticsearch_a
mkdir /etc/elasticsearch_b
mkdir /etc/elasticsearch_m
mkdir /usr/share/elasticsearch_a
mkdir /usr/share/elasticsearch_b
mkdir /usr/share/elasticsearch_m

#Copie du code source d'ElasticSearch
tar -zxvf source/elasticsearch-0.90.7.tar.gz
cp -R elasticsearch-0.90.7/* /usr/share/elasticsearch_a/
cp -R elasticsearch-0.90.7/* /usr/share/elasticsearch_b/
cp -R elasticsearch-0.90.7/* /usr/share/elasticsearch_m/

#Copie des scripts de démarrage
cp scripts/initd/elasticsearch_* /etc/init.d/
cp scripts/default/elasticsearch_* /etc/default/

#Copie des fichiers de config
cp configs/elasticsearch_a.yml /etc/elasticsearch_a/elasticsearch.yml
cp configs/elasticsearch_b.yml /etc/elasticsearch_b/elasticsearch.yml
cp configs/elasticsearch_m.yml /etc/elasticsearch_m/elasticsearch.yml
cp configs/logging_a.yml /etc/elasticsearch_a/logging.yml
cp configs/logging_b.yml /etc/elasticsearch_b/logging.yml
cp configs/logging_m.yml /etc/elasticsearch_m/logging.yml

#Démarrage des noeuds ElasticSearch
/etc/init.d/elasticsearch_a start
/etc/init.d/elasticsearch_b start
/etc/init.d/elasticsearch_m start

#installation des plugins sur le noeud master
/usr/share/elasticsearch_m/bin/plugin -install mobz/elasticsearch-head
/usr/share/elasticsearch_m/bin/plugin -install lukas-vlcek/bigdesk
/usr/share/elasticsearch_m/bin/plugin -install lmenezes/elasticsearch-kopf

