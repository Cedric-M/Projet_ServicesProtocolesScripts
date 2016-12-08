echo "entrez le nom du site a rendre invisible pour les clients";
read sitename;
siteurl="www.$sitename.com";

rm -r "/etc/apache2/sites-enabled/$siteurl";

echo "le domaine '$sitename' est maintenent en caché. Pour le rendre de nouveau visible, executez";
echo " 'affichierdomaine.sh";
