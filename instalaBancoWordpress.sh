#!/bin/bash

### Instalar banco de dados

sudo apt update

sudo apt install mysql-server

### Configurar o banco

sudo mysql<<EOF

CREATE DATABASE wordpress;

CREATE USER 'wordpress'@'localhost' IDENTIFIED BY 'wordpress';

GRANT ALL ON wordpress.* TO 'wordpress'@'localhost';

FLUSH PRIVILEGES;

EOF
