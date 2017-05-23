service apache2 start
service mysql start
./create_mysql_admin_user.sh
./create_db.sh king_of_the_hill
./import_sql.sh Ndf2roF6TT1nN32pzgxvQbabPdHF1Rg3XK5QNUIEIgC6hXwkuV script.sql
chown www-data /var/www/html/img/
chown www-data /var/www/html/uploads/
chmod +x /var/www/bin/image-helper
rm /*.sh
