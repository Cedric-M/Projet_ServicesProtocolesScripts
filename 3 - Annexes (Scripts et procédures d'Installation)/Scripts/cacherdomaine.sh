echo "entrez le nom du site a rendre invisible pour les clients";
read sitename;
siteurl="www.$sitename.com.conf";


a2dissite $siteurl;


echo "le domaine '$sitename' est maintenent caché. Pour le rendre de nouveau visible, executez";
echo " 'afficherdomaine.sh";

