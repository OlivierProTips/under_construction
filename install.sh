#!/bin/bash

# Launch script as root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

# Define flags
flag_user="074f85a4-9fa6-4024-ab2c-55128a967fb6"
flag_root="95640ca7-1734-43b1-af4b-86b36d9d9fa6"

# Install apache and php without prompting
# Disable ssh
export DEBIAN_FRONTEND=noninteractive
apt update && apt -y upgrade
apt install -y apache2 php
systemctl start apache2
systemctl enable apache2
systemctl stop ssh
systemctl disable ssh

# Add a password to root user
echo "root:iamthebigboss" | chpasswd

# Remove theboss from sudoers
gpasswd -d theboss sudo

# Set AllowOverride to All to allow htaccess basic auth
sed -i '/<Directory \/var\/www\/>/,/<\/Directory>/ s/AllowOverride None/AllowOverride all/' /etc/apache2/apache2.conf

# Redirect theboss history to /dev/null
theboss_folder="/home/theboss"
theboss_history="${theboss_folder}/.bash_history"
if [[ -f ${theboss_history} ]]; then
    rm ${theboss_history}
fi
ln -s /dev/null ${theboss_history}

# Remove rights for others
chmod o-rx ${theboss_folder}

# Create backup folder for privesc
theboss_backup="${theboss_folder}/backup"
mkdir ${theboss_backup}
chown theboss:theboss ${theboss_backup}

# Remove unused ssh folder
rm -rf ${theboss_folder}/.ssh

# Allow all users to write in /var/www/html (privesc)
cp -r html/* /var/www/html/
chmod 777 /var/www/html

# Add privesc exploit (tar wildcards)
echo "*/1 * * * * root cd /var/www/html && tar -zcf /home/theboss/backup/html.tgz *" >> /etc/crontab

# Write flags
echo ${flag_user} > ${theboss_folder}/user.txt
echo ${flag_root} > /root/root.txt
chown theboss:theboss ${theboss_folder}/user.txt
chmod o-r ${theboss_folder}/user.txt

reboot