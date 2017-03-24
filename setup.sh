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
