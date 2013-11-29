#!/bin/bash

echo "DEBUT DE L'INSTALLATION"

mkdir /cedromsni
cd /cedromsni

wget https://github.com/querbes/querbes/archive/master.tar.gz
tar -zxvf master.tar.gz
mv querbes-master/ install/
cd install

chmod +x Server-Init.sh
chmod +x ElasticSearch-Init.sh
./Server-Init.sh
#ElasticSearch-Init.sh SiteName HeapSizeNode_A HeapSizeNode_B HeapSizeNode_M
./ElasticSearch-Init.sh 'Querbes' '500m' '400m' '128m'


echo "INSTALLATION TERMINEE !"