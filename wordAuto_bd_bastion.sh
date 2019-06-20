#!/bin/bash

#Esse script necessecita do IP do banco de dados
#O mesmo deve ser exportado com no IPBD
ip_banco="${IPBD}"
usuario="${USER}"
senha="${PASS}"

#INSTALA O O QUE É NECESSÁRIO
sudo apt -y update
sudo apt -y install php-curl php-gd php-mbstring php-xml php-xmlrpc apache2 php libapache2-mod-php php-mysql

#ALGUMAS MODIFICAÇÕES NO APACHE2

sudo sed -i "s/Options Indexes FollowSymLinks/Options FollowSymLinks/" /etc/apache2/apache2.conf
sudo a2dissite 000-default.conf
sudo systemctl stop apache2.service
sudo systemctl start apache2.service
sudo systemctl enable apache2.service

#BAIXANDO WORDPRESS

wget https://wordpress.org/latest.tar.gz
tar -zxvf latest.tar.gz
sudo mv wordpress /var/www/html/wordpress

#SETANDO PERMIÇÕES NECESSÁRIAS
sudo chown -R www-data:www-data /var/www/html/wordpress/
sudo chmod -R 755 /var/www/html/wordpress/

cat <<EOF > /etc/apache2/sites-available/wordpress.conf
<VirtualHost *:80>
   ServerAdmin admin@example.com
   DocumentRoot /var/www/html/wordpress/
   ServerName example.com
   ServerAlias www.example.com
   <Directory /var/www/html/wordpress/> 
        Options +FollowSymlinks
        AllowOverride All
        Require all granted
   </Directory>
   ErrorLog ${APACHE_LOG_DIR}/error.log
   CustomLog ${APACHE_LOG_DIR}/access.log combined 
</VirtualHost>
EOF

#ATIVA O SITE DO WORDPRESS.CONF

sudo a2ensite wordpress.conf
sudo a2enmod rewrite
sudo systemctl restart apache2

#CONFIGURANDO BD DO WORDPRESS

sudo mv /var/www/html/wordpress/wp-config-sample.php /var/www/html/wordpress/wp-config.php

sudo sed -i "s/database_name_here/wordpress/g" /var/www/html/wordpress/wp-config.php
sudo sed -i "s/username_here/wp_admin/g" /var/www/html/wordpress/wp-config.php 
sudo sed -i "s/password_here/root/g" /var/www/html/wordpress/wp-config.php
sudo sed -i "s/localhost/$ip_banco/g" /var/www/html/wordpress/wp-config.php#!/bin/bash

#Esse script necessecita do IP do banco de dados
#O mesmo deve ser exportado com no IPBD
ip_banco="${IPBD}"

#INSTALA O O QUE É NECESSÁRIO
sudo apt -y update
sudo apt -y install php-curl php-gd php-mbstring php-xml php-xmlrpc apache2 php libapache2-mod-php php-mysql

#ALGUMAS MODIFICAÇÕES NO APACHE2

sudo sed -i "s/Options Indexes FollowSymLinks/Options FollowSymLinks/" /etc/apache2/apache2.conf
sudo a2dissite 000-default.conf
sudo systemctl stop apache2.service
sudo systemctl start apache2.service
sudo systemctl enable apache2.service

#BAIXANDO WORDPRESS

wget https://wordpress.org/latest.tar.gz
tar -zxvf latest.tar.gz
sudo mv wordpress /var/www/html/wordpress

#SETANDO PERMIÇÕES NECESSÁRIAS
sudo chown -R www-data:www-data /var/www/html/wordpress/
sudo chmod -R 755 /var/www/html/wordpress/

cat <<EOF > /etc/apache2/sites-available/wordpress.conf
<VirtualHost *:80>
   ServerAdmin admin@example.com
   DocumentRoot /var/www/html/wordpress/
   ServerName example.com
   ServerAlias www.example.com
   <Directory /var/www/html/wordpress/> 
        Options +FollowSymlinks
        AllowOverride All
        Require all granted
   </Directory>
   ErrorLog ${APACHE_LOG_DIR}/error.log
   CustomLog ${APACHE_LOG_DIR}/access.log combined 
</VirtualHost>
EOF

#ATIVA O SITE DO WORDPRESS.CONF

sudo a2ensite wordpress.conf
sudo a2enmod rewrite
sudo systemctl restart apache2

#CONFIGURANDO BD DO WORDPRESS

sudo mv /var/www/html/wordpress/wp-config-sample.php /var/www/html/wordpress/wp-config.php

sudo sed -i "s/database_name_here/wordpress/g" /var/www/html/wordpress/wp-config.php
sudo sed -i "s/username_here/wp_admin/g" /var/www/html/wordpress/wp-config.php 
sudo sed -i "s/password_here/root/g" /var/www/html/wordpress/wp-config.php
sudo sed -i "s/localhost/$ip_banco/g" /var/www/html/wordpress/wp-config.php

sudo sed -i "s/\$language = ''/\$language = 'pt_BR'/" /var/www/html/wordpress/wp-admin/install.php
sudo sed -i "359s/.*/\t\t\$weblog_title = 'Deninho';/" /var/www/html/wordpress/wp-admin/install.php
sudo sed -i "360s/.*/\t\t\$user_name = $usuario;/" /var/www/html/wordpress/wp-admin/install.php
sudo sed -i "361s/.*/\t\t\$admin_password = $senha;/" /var/www/html/wordpress/wp-admin/install.php
sudo sed -i "362s/.*/\t\t\$admin_password_check = $senha;/" /var/www/html/wordpress/wp-admin/install.php
sudo sed -i "363s/.*/\t\t\$admin_email = 'admin@email.com';/" /var/www/html/wordpress/wp-admin/install.php
sudo sed -i "364s/.*/\t\t\$public = 'blog_public';/" /var/www/html/wordpress/wp-admin/install.php
