#!/bin/bash
# Add a virtual domain to sympa mailing list manager, installed from source.
# Usage : sympa_add_virtualdomain.sh domain_name
# 

mkdir -m755 /usr/local/etc/$1
touch /usr/local/etc/$1/robot.conf
chown -R sympa:sympa /usr/local/etc/$1
mkdir -m 750 /usr/local/var/lib/sympa/list_data/$1
chown sympa:sympa /usr/local/var/lib/sympa/list_data/$1

echo "wwsympa_url http://list.$1/sympa" >> /usr/local/etc/$1/robot.conf
echo "http_host list.$1/sympa" >> /usr/local/etc/$1/robot.conf

systemctl restart  wwsympa.service  sympa.service  apache2.service
