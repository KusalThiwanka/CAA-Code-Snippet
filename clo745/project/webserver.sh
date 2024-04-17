#!/bin/bash
sudo yum update -y
sudo yum install httpd -y
sudo yum install php -y
sudo systemctl start httpd
sudo systemctl enable httpd
sudo wget -P /var/www/html/ https://raw.githubusercontent.com/KusalThiwanka/CAA-Code-Snippet/master/clo745/project/index.php
sudo systemctl restart httpd