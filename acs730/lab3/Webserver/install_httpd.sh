#!/bin/bash
yum -y update
yum -y install httpd
echo "<h1>Welcome to  ACS730 Lab3" > /var/www/html/index.html
sudo systemctl start httpd
sudo systemctl enable httpd