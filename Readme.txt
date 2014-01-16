
#########################################################
# DESCRIPTION
#########################################################
# Script d'installation via SSH sur Debian, de Java, Nginx et 3 noeuds ElasticSearch (1 master, 2 data)

#########################################################
# UTILISATION
#########################################################
# ./ES-RemoteDeploy.sh root 192.168.1.1 'MyPa$sw0rd' 'Collogix' '30g' '30g' '1g'

#########################################################
#  Detail
#########################################################
#  1/ Java
# -----------------
# - Installation de la version 1.7u25
#
#  2/ Nginx
# -----------------
# - Installation d'un proxy pour protéger ElasticSearch
#
#  3/ ElasticSearch
# -----------------
# - Installation de 3 instances sur un serveur (1 noeud master, 2 noeuds données)
# - Installation automatique des fichiers de démarrages (service)
# - Configuration automatique des fichiers .yml
# - Installation automatique des fichiers plugins Head,Bigdesk,Kopf
