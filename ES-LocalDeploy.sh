#!/bin/bash
echo "###########################"
echo "# DEBUT DE L'INSTALLATION #"
echo "###########################"

mkdir /cedromsni
cd /cedromsni

echo "# DOWNLOAD SUR GITHUB DU SCRIPT D'INSTALLATION #"
wget https://github.com/querbes/querbes/archive/master.tar.gz
tar -zxvf master.tar.gz
mv querbes-master/ install/
cd install

echo "# CONFIG DU SERVER LINUX #"
chmod +x Server-Init.sh
./Server-Init.sh

echo "# CONFIG DE NGINX (PROXY) #"
chmod +x Nginx-Init.sh
./Nginx-Init.sh $1

echo "# CONFIG DES NOEUDS ELASTICSEARCH #"
chmod +x ElasticSearch-Init.sh
# ElasticSearch-Init.sh SiteName HeapSizeNode_A HeapSizeNode_B HeapSizeNode_M #
./ElasticSearch-Init.sh $2 $3 $4 $5
###############################################################################

echo "###########################"
echo "# INSTALLATION TERMINEE ! #"
echo "###########################"