#!/bin/bash
sudo setenforce 0

sudo yum install  mariadb-server -y
sudo systemctl enable mariadb
sudo systemctl start mariadb

sudo yum install epel-release -y
sudo rpm -ivh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
sudo yum --enablerepo=remi,remi-php70 install php php-mysqlnd php-gd php-xml php-xmlrpc php-mbstring php-mcrypt php-fpm php-opcache php-apcu -y
sudo systemctl enable php-fpm
sudo systemctl restart php-fpm

sudo touch /etc/yum.repos.d/nginx.repo
echo '[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/mainline/centos/7/$basearch/
gpgcheck=0
enabled=1' | sudo tee /etc/yum.repos.d/nginx.repo
sudo yum install nginx -y

sudo systemctl disable httpd
sudo systemctl stop httpd
sudo systemctl enable nginx
sudo systemctl start nginx

sudo mysql -sfu root < "mysql_secure_installation.sql"
sudo mysql -sfu root < "wordpress.sql"
rm -f mysql_secure_installation.sql
rm -f wordpress.sql
get /etc/my.cnf.d/server.cnf
sudo systemctl restart mariadb

cd /var/www/
sudo wget https://wordpress.org/latest.zip
sudo unzip latest.zip
sudo cp -rp wordpress/* html/
chmod 777 html html/wp-content
