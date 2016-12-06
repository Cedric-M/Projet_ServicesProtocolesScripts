#lire les variables
echo "entrez le nom du site"
read sitename
echo "entrez l'url du site"
read siteurl

#Creer le dossier du site
cp -r /var/www/html /var/www/$sitename


#Copier le fin du fichier de config du site par defaut vers le config du site a creer
tail -n 18 /etc/apache2/sites-enabled/000-default.conf > /etc/apache2/sites-enabled/$sitename

#Ajouter tout l'info nessesaire
"	ServerName $siteurl"             >> /etc/apache2/sites-enabled/$sitename
"	ServerAdmin admin@$siteurl"      >> /etc/apache2/sites-enabled/$sitename
"	DocumentRoot /var/www/$sitename" >> /etc/apache2/sites-enabled/$sitename


#Ajouter le site a la fin du fichier de configuration de bind
echo "zone  \"$siteurl\" { "           >> /etc/bind/named.conf
echo "       type master;    "         >> /etc/bind/named.conf
echo "       file \"$siteurl.zone\ ";" >> /etc/bind/named.conf
echo "};"                              >> /etc/bind/named.conf
