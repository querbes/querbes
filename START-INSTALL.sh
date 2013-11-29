#!/bin/bash

echo "DEBUT DE L'INSTALLATION"

mkdir /cedromsni
cd /cedromsni

wget https://github.com/querbes/querbes/archive/master.tar.gz
tar -zxvf master.tar.gz
mv querbes-master/ install/
cd install

./Server-Init.sh  
./ElasticSearch-Init.sh  

echo "INSTALLATION TERMINEE !"