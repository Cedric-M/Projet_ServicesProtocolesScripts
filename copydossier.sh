#!/bin/bash
#ce script va copier un dossier vers une destination si il y a un fichier ".client.visible" dedans. De cette maniere-la, on va pouvoir cacher des dossiers aux clients en omettent ce fichier-la

while read -r dossiersource; do
dossierdestination="/var/www/$dossiersource";
if [ -e "$dossiersource/.client.visible" ]; then
    #Si le fichier ".client.visible" dans le dossier source existe, on peut la copier
	#cp -r dossiersource dossierdestination;
	echo "SHOWN for client:'$dossierdestination' from '$dossiersource'";
else
    #Si le fichier ".client.visible" dans le dossier source n'existe pas, on ne le copie pas. Comme on est paranoiaque, on
    # efface sur la destination; on met le message d'erreur sur silencieux avec 2>/dev/null
    #rm "$destination path" 2> /dev/null;
	echo "HIDDEN for client:'$dossierdestination' from '$dossiersource'";
fi
done

apache2ctl restart;

#a invoquer avec "find -d -s $dossiersource -type d | copydossier.sh"

