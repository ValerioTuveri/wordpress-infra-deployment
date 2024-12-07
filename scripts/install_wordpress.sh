#!/bin/bash
yum update -y
amazon-linux-extras install -y nginx1
yum install -y php php-mysqlnd php-fpm

# Start Nginx and PHP-FPM
systemctl start nginx
systemctl enable nginx

# Install WordPress
wget https://wordpress.org/latest.tar.gz
tar -xzvf latest.tar.gz
mv wordpress/* /usr/share/nginx/html/

chown -R nginx:nginx /usr/share/nginx/html/
systemctl restart nginx
