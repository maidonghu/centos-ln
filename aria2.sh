#!/bin/bash
sudo setenforce 0

sudo mkfs.ext4 -F /dev/disk/by-id/scsi-0DO_Volume_volume-nyc1-01
sudo mkdir -p /mnt/volume-nyc1-01
sudo mount -o discard,defaults /dev/disk/by-id/scsi-0DO_Volume_volume-nyc1-01 /mnt/volume-nyc1-01
echo /dev/disk/by-id/scsi-0DO_Volume_volume-nyc1-01 /mnt/volume-nyc1-01 ext4 defaults,nofail,discard 0 0 | sudo tee -a /etc/fstab

sudo yum install epel-release -y
sudo yum install -y c-ares  jemalloc gnutls-devel
wget https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-64bit-static.tar.xz
tar xfv ffmpeg-release-64bit-static.tar.xz
sudo mkdir -p /usr/local/bin/ffmpeg
cd ffmpeg-3*
sudo mv * /usr/local/bin/ffmpeg/
sudo ln -s /usr/local/bin/ffmpeg/ffmpeg /usr/bin/ffmpeg
#sudo rpm -ivh https://raw.githubusercontent.com/maidonghu/centos-ln/master/aria2-1.32.0-1.el7.centos.x86_64.rpm
sudo rpm -ivh https://raw.githubusercontent.com/maidonghu/centos-ln/master/aria2-1.33.1-2.el7.centos.x86_64.rpm

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

sudo curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
sudo chmod a+rx /usr/local/bin/youtube-dl
sudo yum install python -y

sudo wget https://raw.githubusercontent.com/maidonghu/myconf/master/gdrive -O /usr/local/bin/gdrive
sudo chmod a+rx /usr/local/bin/gdrive

echo "Please provied gdrive cert file"
sleep 30
mkdir .gdrive
mv token_v2.json ./.gdrive/token_v2.json
