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
if [ -e ./.ssh/authorized_keys ]; then
cat ./.ssh/authorized_keys >> /home/mike/.ssh/authorized_keys
else 
cat /authorized_keys >> /home/mike/.ssh/authorized_keys
fi

chown mike:mike /home/mike -R
echo 'mike ALL=(ALL) NOPASSWD: ALL' | tee -a /etc/sudoers

yum update -y
timedatectl set-timezone America/Vancouver
yum install ntp -y
systemctl enable ntpd
systemctl start ntpd

sed -i 's/#Port 22/Port 50009/' /etc/ssh/sshd_config
sed -i 's/Port 22/Port 50009/' /etc/ssh/sshd_config 
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
sed -i 's/#PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
systemctl restart sshd

yum install sendmail -y
systemctl enable sendmail
systemctl start sendmail

yum install epel-release -y
wget wget https://raw.githubusercontent.com/maidonghu/centos-ln/master/shadowsocks-libev-3.1.0-1.4.git10a2d3e.el7.centos.x86_64.rpm
yum install mbedtls libsodium libev c-ares -y
rpm -ivh shadowsocks-libev-3.1.0-1.4.git10a2d3e.el7.centos.x86_64.rpm

yum install -y firewalld
systemctl enable firewalld
systemctl start firewalld
firewall-cmd --zone=public --add-port=50009/tcp --permanent
firewall-cmd --zone=public --add-service=http --permanent
firewall-cmd --zone=public --add-service=https --permanent
firewall-cmd --zone=public --add-port=53214/tcp --permanent
firewall-cmd --reload

echo never > /sys/kernel/mm/transparent_hugepage/enabled
echo 'echo never > /sys/kernel/mm/transparent_hugepage/enabled' | tee -a /etc/rc.local
chmod +x /etc/rc.local
chmod +x /etc/rc.d/rc.local

echo 'Please logoff and login again with SSH with mike!' 
sleep 5
poweroff
