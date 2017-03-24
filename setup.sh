#!/bin/bash
read -s -p "Enter Root Password: "  pswd
echo -e "$pswd\n$pswd" | passwd
adduser mike
read -s -p "Enter mike's new Password: "  pswd
echo -e "$pswd\n$pswd" | passwd mike
unset pswd
gpasswd -a mike wheel

mkdir /home/mike/.ssh
yum install wget unzip -y
wget https://raw.githubusercontent.com/maidonghu/ubuntu16.04-LN/master/authorized_keys
cat ./authorized_keys >> /home/mike/.ssh/authorized_keys
chown mike:mike /home/mike -R

yum update -y
timedatectl set-timezone America/Vancouver
yum install ntp -y
systemctl enable ntpd
systemctl start ntpd

sed -i 's/#Port 22/Port 50009/' /etc/ssh/sshd_config
systemctl restart sshd

sudo systemctl enable firewalld
sudo systemctl start firewalld
sudo firewall-cmd --zone=public --add-port=50009/tcp --permanent
sudo firewall-cmd --zone=public --add-service=http --permanent
sudo firewall-cmd --zone=public --add-service=https --permanent
sudo firewall-cmd --reload

