adduser mike
passwd mike
gpasswd -a mike wheel
 create ssh key file for mike
su - mike
mkdir .ssh
chmod 700 .ssh
chmod 600 .ssh/authorized_keys
exit
