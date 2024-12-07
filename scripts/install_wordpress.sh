#!/bin/bash

sudo yum update -y
sudo yum install -y httpd php php-mysqlnd

# Download specific WordPress version
wget https://wordpress.org/wordpress-latest.tar.gz
tar -xzf wordpress-latest.tar.gz
sudo mv wordpress /var/www/html/

# Set file permissions
sudo chown -R apache:apache /var/www/html/wordpress
sudo chmod -R 755 /var/www/html/wordpress

# Start Apache
sudo systemctl start httpd
sudo systemctl enable httpd