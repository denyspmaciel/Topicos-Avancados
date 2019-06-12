#!/bin/bash

# Descobrindo Ip Public da Instancia:

IP_Public="$(curl http://169.254.169.254/latest/meta-data/public-ipv4)"

# Intalando as dependências necessárias:

sudo apt -y update

sudo apt -y install php-curl php-gd php-mbstring php-xml php-xmlrpc php libapache2-mod-php apache2

#sudo apt -y install mysql-server php-mysql

#Criando o Banco de Dados do WordPress:

#sudo mysql<<EOF

#CREATE DATABASE wordpress;

#CREATE USER 'wordpress'@'localhost' IDENTIFIED BY 'wordpress';

#GRANT ALL ON wordpress.* TO 'wordpress'@'localhost';

#FLUSH PRIVILEGES;
#EOF

# Baixando e Configurando o WordPress:

wget https://wordpress.org/latest.tar.gz

sudo mv latest.tar.gz /var/www/

cd /var/www/

sudo tar xpf latest.tar.gz

cd

sudo chown -R www-data:www-data /var/www/wordpress

sudo cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/wordpress.conf


sudo sed -i '10s/^/        ServerName '$IP_Public'/' /etc/apache2/sites-available/wordpress.conf

sudo sed -i '12s/html/wordpress/' /etc/apache2/sites-available/wordpress.conf

sudo a2ensite wordpress.conf

sudo systemctl reload apache2
