#!/bin/bash

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

#installation des plugins 
/usr/share/elasticsearch_a/bin/plugin -install mobz/elasticsearch-head
/usr/share/elasticsearch_b/bin/plugin -install mobz/elasticsearch-head
/usr/share/elasticsearch_m/bin/plugin -install mobz/elasticsearch-head
/usr/share/elasticsearch_a/bin/plugin -install lukas-vlcek/bigdesk
/usr/share/elasticsearch_b/bin/plugin -install lukas-vlcek/bigdesk
/usr/share/elasticsearch_m/bin/plugin -install lukas-vlcek/bigdesk
/usr/share/elasticsearch_a/bin/plugin -install lmenezes/elasticsearch-kopf
/usr/share/elasticsearch_b/bin/plugin -install lmenezes/elasticsearch-kopf
/usr/share/elasticsearch_m/bin/plugin -install lmenezes/elasticsearch-kopf

