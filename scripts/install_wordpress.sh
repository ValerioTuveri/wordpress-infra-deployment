#!/bin/bash
yum update -y
yum install nginx -y

# Start Nginx and PHP-FPM
systemctl start nginx
systemctl enable nginx

# Install WordPress
wget https://wordpress.org/${wordpress_version}.tar.gz
tar -xzvf ${wordpress_version}.tar.gz
mv wordpress/* /usr/share/nginx/html/

chown -R nginx:nginx /usr/share/nginx/html/
systemctl restart nginx
