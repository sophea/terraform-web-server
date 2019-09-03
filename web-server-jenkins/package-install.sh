#!/usr/bin/env bash

  apt-get update && apt-get install apache2 -y
  systemctl enable apache2
  systemctl start apache2
  chmod 777 /var/www/html/index.html

apt-get update && apt-get install openjdk-8-jdk wget curl -y
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
apt update && apt install jenkins -y

