#!/bin/bash
sudo setenforce 0

sudo mkfs.ext4 -F /dev/disk/by-id/scsi-0DO_Volume_volume-nyc1-01
sudo mkdir -p /mnt/volume-nyc1-01
sudo mount -o discard,defaults /dev/disk/by-id/scsi-0DO_Volume_volume-nyc1-01 /mnt/volume-nyc1-01
echo /dev/disk/by-id/scsi-0DO_Volume_volume-nyc1-01 /mnt/volume-nyc1-01 ext4 defaults,nofail,discard 0 0 | sudo tee -a /etc/fstab

sudo yum install epel-release -y
sudo yum localinstall --nogpgcheck -y https://download1.rpmfusion.org/free/el/rpmfusion-free-release-7.noarch.rpm https://download1.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-7.noarch.rpm
sudo yum install -y ffmpeg jemalloc
sudo yum install -y c-ares
sudo rpm -ivh https://raw.githubusercontent.com/maidonghu/centos-ln/master/aria2-1.31.0-2.el7.centos.x86_64.rpm

cd /mnt/volume-nyc1-01
sudo mkdir -p Downloads
cd Downloads
sudo touch aria2.log
sudo touch aria2.session
cd ~

wget https://raw.githubusercontent.com/maidonghu/ubuntu16.04-DO/master/aria2.conf
sudo mv aria2.conf /usr/local/etc/aria2.conf
sudo aria2c --conf-path=/usr/local/etc/aria2.conf

sudo firewall-cmd --zone=public --add-port=6800/tcp --permanent
sudo firewall-cmd --reload
