#!/bin/bash
#lire les variables
echo "entrez le nom du site"
read sitename;
#echo "entrez l'url du site"
#read siteurl;
siteurl="www.$sitename.com"

#Creer les dossiers du site
cp -n -r /var/www/html /var/www/$sitename/;

#Copier le fin du fichier de config du site par defaut vers le config du site a creer
sed "r/site1projet0/0$sitename/" </etc/apache2/sites-available/www.site1projet.com.conf > "/etc/apache2/sites-available/$siteurl.conf";

#Ajouter le site a la fin du fichier de configuration de bind
echo "zone  \"$siteurl\" { "           >> /etc/bind/named.conf.local;
echo "       type master;    "         >> /etc/bind/named.conf.local;
echo "       file \"$sitename.zone\ "   >> /etc/bind/named.conf.local;
echo "};"                              >> /etc/bind/named.conf.local;

serial=$(date "+%_y%_W%_u%_H%_M%_S");


#cree le fichier de zone
echo "$siteurl.  IN  SOA  $siteurl  admin@localhost  \(" >  /etc/bind/$sitename.zone;
echo "               $serial      ;serial"         >> /etc/bind/$sitename.zone;
echo "               28800            ;refresh"         >> /etc/bind/$sitename.zone;
echo "               7200             ;retry"           >> /etc/bind/$sitename.zone;
echo "               604800           ;expire"          >> /etc/bind/$sitename.zone;
echo "               86400            ;time to live"    >> /etc/bind/$sitename.zone;
echo "                                               \)" >> /etc/bind/$sitename.zone;
echo ";"                                                >> /etc/bind/$sitename.zone;
echo ";Name Servers"                                    >> /etc/bind/$sitename.zone;
echo "$siteurl.                     IN           NS           localhost" >> /etc/bind/$sitename.zone;
echo ";"                                                >> /etc/bind/$sitename.zone;

/etc/init.d/bind9 restart;

















echo "127.0.0.1	$siteurl">>/etc/hosts;
