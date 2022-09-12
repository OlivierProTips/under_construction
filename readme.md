[https://www.github.com/OlivierProTips/vuln_server](https://www.github.com/OlivierProTips/vuln_server)

# Settings

## Server

```
sudo apt update && sudo apt -y upgrade
sudo apt install -y apache2 php
systemctl start apache2
systemctl enable apache2
```

## User password

```
thebigboss
```

## Root password

```
sudo su
echo "root:iamthebigboss" | chpasswd
```

## Remove user from sudo

```
sudo gpasswd -d theboss sudo
```

## Read htaccess

Set AllowOverride All in /etc/apache2/apache2.conf

```
<Directory /var/www/html/>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
</Directory>
```

```bash
sed -i '/<Directory \/var\/www\/>/,/<\/Directory>/ s/AllowOverride None/AllowOverride all/' /etc/apache2/apache2.conf
```

## ssh

```
sudo systemctl stop ssh
sudo systemctl disable ssh
```

## history

```
rm .bash_history
ln -s /dev/null .bash_history
```

## Privesc

```
mkdir backup
sudo vi /etc/crontab
*/1 * * * * root tar -zcf /home/theboss/backup/html.tgz /var/www/html/*
```