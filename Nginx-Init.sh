#!/bin/bash

################ Parameters ##################
if [ -n $1 ]
then
	PASSWORD=$1
else
	PASSWORD='cedromsni'
fi

###################
#  Config Nginx  ##
###################

# 1/ creer le mot de passe
htpasswd -cb /etc/nginx/htpasswd_file elasticsearch_admin $PASSWORD
chown root:nobody /etc/nginx/htpasswd_file
chmod 640 /etc/nginx/htpasswd_file

# 2/ Copier le fichier nginx.conf
cp configs/nginx.conf /etc/nginx/nginx.conf




###################
# Config IPTables #
###################

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