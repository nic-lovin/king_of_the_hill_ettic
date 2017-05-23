FROM ubuntu:16.04
MAINTAINER Fernando Mayo <fernando@tutum.co>, Feng Honglin <hfeng@tutum.co>

# Install packages
RUN apt-get update 
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install supervisor 
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install git 
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install apache2 
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install libapache2-mod-php
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install mysql-server 
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install php-mysql 
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install pwgen 
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install php-apcu
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install openssh-server
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install vim
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install libmysqlclient-dev
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install acl
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install gcc
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install make

# Add image configuration and scripts
ADD start-apache2.sh /start-apache2.sh
ADD start-mysqld.sh /start-mysqld.sh
ADD script.sql /script.sql
ADD run.sh /run.sh
RUN chmod 755 /*.sh
ADD my.cnf /etc/mysql/conf.d/my.cnf
ADD supervisord-apache2.conf /etc/supervisor/conf.d/supervisord-apache2.conf
ADD supervisord-mysqld.conf /etc/supervisor/conf.d/supervisord-mysqld.conf

# Remove pre-installed database
# RUN rm -rf /var/lib/mysql/*

# Add MySQL utils
ADD create_mysql_admin_user.sh /create_mysql_admin_user.sh
ADD import_sql.sh /import_sql.sh
ADD create_db.sh /create_db.sh
RUN chmod 755 /*.sh

# config to enable .htaccess
ADD apache_default /etc/apache2/sites-available/000-default.conf
# RUN a2enmod rewrite

# Configure /app folder with sample app
RUN rm -r /var/www/html
ADD html/ /var/www/html
RUN ls -R /var/www

# Configure users & binary
RUN useradd -m TheKing
ADD bin/ /var/www/bin
RUN make /var/www/bin
RUN chmod u+s /var/www/bin/image-helper
RUN chown TheKing /var/www/html/index.php
RUN setfacl -m u:TheKing:rwx /var/www/html/index.php
RUN chmod u+s /var/www/html/index.php
RUN setfacl -m u:TheKing:rwx /var/www/bin/logo.txt
RUN chmod u+s /var/www/bin/logo.txt
RUN DEBIAN_FRONTEND=noninteractive apt-get -y autoremove make
RUN DEBIAN_FRONTEND=noninteractive apt-get -y autoremove gcc
RUN rm /var/www/bin/image-helper.c
RUN rm /var/www/bin/Makefile


EXPOSE 80 3306
# CMD ["/run.sh"]
