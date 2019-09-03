#!/usr/bin/env bash

  apt-get update && apt-get install apache2 openjdk-8-jdk-headless -y
  systemctl enable apache2
  systemctl start apache2
  chmod 777 /var/www/html/index.html