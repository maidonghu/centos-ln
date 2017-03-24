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
echo "[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/mainline/centos/7/$basearch/
gpgcheck=0
enabled=1" | sudo tee /etc/yum.repos.d/nginx.repo
