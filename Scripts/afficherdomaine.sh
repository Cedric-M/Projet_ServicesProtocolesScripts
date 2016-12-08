echo "Entrez le nom du site a rendre visible pour les clients";
read sitename;
siteurl="www.$sitename.com.conf";

a2ensite $siteurl;


echo "le domaine '$sitename' est maintenent visible. Pour le cacher, executez";
echo " 'cacherdomaine.sh";


