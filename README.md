### Attention, dirty code!  
Code basé sur dépôt: https://github.com/ppepos/drunken-shame/tree/master/containers/web1, lui-même basé sur https://hub.docker.com/r/tutum/lamp/.
    
### King of the hill par Ettic dans le cadre d'un évènement pré-Northsec  
Les gens doivent essayer d'avoir leur logo affiché le plus longtemps possible sur la page d'accueil. Un script permet de calculer le pointage dans `scores/`.
    
### Installation  
`ssh url`  
  
Setup pour downloader installer docker  
Référence: https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-16-04  
`sudo apt-get update`  
`sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D`  
`sudo apt-add-repository 'deb https://apt.dockerproject.org/repo ubuntu-xenial main'`  
`sudo apt-get update`  
`apt-cache policy docker-engine`  
`sudo apt-get install -y docker-engine`    

Transférer les fichiers de local au serveur  
Depuis l'ordinateur: `scp -r ~/king_of_the_hill/* url:/home`  
  
Builder le docker  
`cd /home`  
`docker build -t king .`  
`docker run exec -it -p 80:80s -p 3306:3306 king`  
`./run.sh`  
populer la bd via script.sql  
`rm script.sql`


### Solution attendue
1) Afficher robots.txt -> mène à une page qui permet d'uploader un logo.png  
2) Bypasser les protections js et php pour uploader un shell  
3) Reverser le binaire image-helper pour obtenir les creds de la db (les creds sont en clear text)  
4) Ajouter une row dans la table_images pour que le binaire image-helper aille chercher le path du logo de l'uni  
5) Pwner le binaire image-helper pour avoir accès à modifier le index.php pour qu'il pointe sur le logo de l'uni  
  
NB: Il était possible d'uploader un .htaccess et de "briser" le challenge.
