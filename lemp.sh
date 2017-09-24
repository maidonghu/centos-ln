#!/bin/bash
sudo setenforce 0

sudo touch /etc/yum.repos.d/MariaDB.repo
echo '# MariaDB 10.2 CentOS repository list - created 2017-04-02 05:25 UTC
# http://downloads.mariadb.org/mariadb/repositories/
[mariadb]
name = MariaDB
baseurl = http://yum.mariadb.org/10.2/centos7-amd64
gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB
gpgcheck=1' | sudo tee /etc/yum.repos.d/MariaDB.repo

sudo yum install -y MariaDB-server MariaDB-client
sudo systemctl enable mariadb
sudo systemctl start mariadb
sudo mv /mysql_secure_installation.sql ./
sudo mysql -sfu root < "mysql_secure_installation.sql"
sudo rm -f mysql_secure_installation.sql
sudo wget -O /etc/my.cnf.d/server.cnf https://raw.githubusercontent.com/maidonghu/centos-ln/master/server.cnf
sudo systemctl restart mariadb

sudo yum install epel-release -y
wget http://mirrors.mediatemple.net/remi/enterprise/remi-release-7.rpm
sudo rpm -ivh remi-release-7.rpm
sudo yum --enablerepo=remi install redis -y
sudo systemctl enable redis
sudo mkdir -p /var/run/redis
sudo chmod 777 -R /var/run/redis
sudo mv /redis.conf /etc/
echo 'vm.overcommit_memory = 1' | sudo tee -a /etc/sysctl.conf
sudo sysctl vm.overcommit_memory=1


#wget http://mirrors.mediatemple.net/remi/enterprise/remi-release-7.rpm
#sudo rpm -ivh remi-release-7.rpm
sudo yum --enablerepo=remi,remi-php71 install php php-mysqlnd php-gd php-xml php-redis php-xmlrpc php-mbstring php-mcrypt php-fpm php-opcache php-apcu -y
sudo systemctl enable php-fpm

#sudo touch /etc/yum.repos.d/nginx.repo
#echo '[nginx]
#name=nginx repo
#baseurl=http://nginx.org/packages/mainline/centos/7/$basearch/
#gpgcheck=0
#enabled=1' | sudo tee /etc/yum.repos.d/nginx.repo
#sudo yum install nginx -y
sudo rpm -ivh https://raw.githubusercontent.com/maidonghu/centos-ln/master/nginx-1.13.1-1.el7.centos.ngx.x86_64.rpm

#sudo yum install https://repo.aerisnetwork.com/stable/centos/7/x86_64/aeris-release-1.0-4.el7.noarch.rpm -y
#sudo yum install nginx-more -y
#cd /etc/yum.repos.d
#sudo wget https://repo.codeit.guru/codeit.mainline.el`rpm -q --qf "%{VERSION}" $(rpm -q --whatprovides redhat-release)`.repo
#sudo yum install nginx -y

sudo systemctl disable httpd
sudo systemctl stop httpd
sudo systemctl enable nginx

cd /var/www/
sudo wget https://wordpress.org/latest.zip
sudo unzip latest.zip
sudo cp -rp wordpress/* html/
sudo chmod 777 html html/wp-content

sudo tuned-adm profile throughput-performance

cd /var/www/html/wp-content/plugins/
sudo wget https://downloads.wordpress.org/plugin/updraftplus.1.13.1.zip
sudo unzip updraftplus.1.13.1.zip
sudo mv /wp-config.php /var/www/html/
sudo mkdir -p /etc/nginx/ssl/blog.mikecloud.info
sudo mv /fullchain1.pem /etc/nginx/ssl/blog.mikecloud.info/
sudo mv /privkey1.pem /etc/nginx/ssl/blog.mikecloud.info/
sudo mkdir  -p /etc/nginx/ssl/blog.mikecloud.info_ecc
sudo mv /fullchain.cer /etc/nginx/ssl/blog.mikecloud.info_ecc/
sudo mv /blog.mikecloud.info.key /etc/nginx/ssl/blog.mikecloud.info_ecc/

sudo mv /www.conf /etc/php-fpm.d/
sudo systemctl restart php-fpm
sudo systemctl restart redis
sudo chown -R apache:apache /var/www/html/wp-content
sudo wget -O /etc/nginx/nginx.conf https://raw.githubusercontent.com/maidonghu/centos-ln/master/nginx.conf
sudo wget -O /etc/nginx/conf.d/http.conf https://raw.githubusercontent.com/maidonghu/centos-ln/master/http.conf
sudo systemctl restart nginx
