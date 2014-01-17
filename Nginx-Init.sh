#!/bin/bash

################ Parameters ##################
if [ -n $1 ]
then
	PASSWORD=$1
else
	PASSWORD='cedromsni'
fi


#################################################################
# Config IPTables                                               #
#---------------------------------------------------------------#
# On autorise les requêtes http sur les port 9200, 9201 et 9202 #
# mais on redirige tout vers NGinx sur le port 8080             #
#################################################################

# 1/ creer les règles
iptables -A INPUT -i eth0 -p tcp --dport 9200 -j ACCEPT
iptables -A INPUT -i eth0 -p tcp --dport 9201 -j ACCEPT
iptables -A INPUT -i eth0 -p tcp --dport 9202 -j ACCEPT
iptables -A INPUT -i eth0 -p tcp --dport 8080 -j ACCEPT
iptables -A PREROUTING -t nat -i eth0 -p tcp --dport 9200 -j REDIRECT --to-port 8080
iptables -A PREROUTING -t nat -i eth0 -p tcp --dport 9201 -j REDIRECT --to-port 8080
iptables -A PREROUTING -t nat -i eth0 -p tcp --dport 9202 -j REDIRECT --to-port 8080

# 2/ Sauvegarder les règles
iptables-save > /etc/iptables/rules.v4


#################################################################
#  Config Nginx                                                 #
#---------------------------------------------------------------#
# On autorise les requetes GET et HEAD sur le HTTP 8080         #
# mais on demande un mot de passe pour les POST, PUT et DELETE  #
#################################################################

# 1/ creer le mot de passe
htpasswd -cb /etc/nginx/htpasswd_file elasticsearch_admin $PASSWORD
chown root:nogroup /etc/nginx/htpasswd_file
chmod 640 /etc/nginx/htpasswd_file

# 2/ Copier le fichier nginx.conf
cp configs/nginx.conf /etc/nginx/nginx.conf

# 3/ Démarrage automatique au boot
sudo /usr/sbin/update-rc.d -f nginx defaults


