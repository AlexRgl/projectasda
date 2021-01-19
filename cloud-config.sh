#!/bin/bash -x

USER=manuel              # user to add or configure for
PASSWORD=Passw0rd       # password in case we add the user

SCRIPT_LOG_DETAIL=/var/log/cloud-config-detail.log

exec 3>&1 4>&2                  #
trap 'exec 2>&4 1>&3' 0 1 2 3   # https://serverfault.com/questions/103501/how-can-i-fully-log-all-bash-scripts-actions
exec 1>$SCRIPT_LOG_DETAIL 2>&1  #
sudo hostnamectl set-hostname apache2
sudo sh -c 'echo root:Passw0rd | chpasswd'
sudo apt-get -y install apache2
sudo a2enmod ssl
sudo a2ensite default-ssl.conf
sudo systemctl restart apache2
sudo systemctl enable apache2
sudo sed -i 's|80|8080|g' /etc/apache2/ports.conf
sudo sed -i 's|443|8443|g' /etc/apache2/ports.conf
sudo sed -i 's|443|8443|g' /etc/apache2/sites-available/default-ssl.conf
sudo systemctl restart apache2
