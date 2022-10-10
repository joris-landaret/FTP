#!/bin/bash

cd /home/sarlas/FTP/job09
cat Shell_Userlist.csv | while read varligne
do

pass=`echo $varligne |cut -d ',' -f4`
user=`echo $varligne |cut -d ',' -f2`
user=`echo ${user,,}`
role=`echo $varligne |cut -d ',' -f5`
echo $role

if [ ${role:0:5} = "Admin" ]
then

echo "creation de l'utilisateur : $user"
password=$(perl -e 'print crypt($ARGV[0], "pass")' $pass) 
sudo useradd -m -p $password $user
             
echo "changement du role de : $user"
sudo usermod -aG sudo $user
sudo groupadd ftpgroup
sudo adduser $user ftpgroup

else

echo "creation de l'utilisateur : $user"
password=$(perl -e 'print crypt($ARGV[0], "pass")' $pass)       
sudo useradd -m -p "$password" "$user"

fi

done < <(tail -n +2 Shell_Userlist.csv)
