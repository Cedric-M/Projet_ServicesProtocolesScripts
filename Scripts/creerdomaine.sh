#lire les variables
echo "entrez le nom du site"
read sitename;
echo "entrez l'url du site"
read siteurl;

#Creer les dossiers du site
#cp -r /var/www/html /var/www/$sitename/;
#mkdir /home/user/git/Projet_ServicesProtocolesScripts/website/$sitename/;
cp -r /var/www/html /home/user/git/Projet_ServicesProtocolesScripts/website/$sitename/;

#Copier le fin du fichier de config du site par defaut vers le config du site a creer
head -n 7  /etc/apache2/sites-enabled/000-default.conf >  "/etc/apache2/sites-enabled/$sitename";

#Ajouter tout l'info nessesaire
echo "	ServerName $siteurl" >> "/etc/apache2/sites-enabled/$sitename";
echo "	ServerAdmin admin@localhost" >> "/etc/apache2/sites-enabled/$sitename";
echo "	DocumentRoot /var/www/$sitename" >> "/etc/apache2/sites-enabled/$sitename";
tail -n 18 /etc/apache2/sites-enabled/000-default.conf >> "/etc/apache2/sites-enabled/$sitename";


#Ajouter le site a la fin du fichier de configuration de bind
echo "zone  \"$siteurl\" { "           >> /etc/bind/named.conf.local;
echo "       type master;    "         >> /etc/bind/named.conf.local;
echo "       file \"$siteurl.zone\ "   >> /etc/bind/named.conf.local;
echo "};"                              >> /etc/bind/named.conf.local;

/etc/init.d/bind9 restart

#copy le dossier de depart
cd ../website;
echo "./$sitename" | sh ../Scripts/copydossier.sh;

echo "Veuillez rajouter un fichier .client.visible dans tout les dossiers qui sont sense etre";
echo " visible au client. Votre site sera mise en service ce soir-meme!"
