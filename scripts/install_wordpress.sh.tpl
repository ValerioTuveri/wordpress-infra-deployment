#!/bin/bash

set -e

sudo yum update -y
sudo yum install -y httpd php php-mysqlnd

# Install WordPress
WORDPRESS_VERSION="${wordpress_version}"  # Passed from Terraform
echo "Installing WordPress version: $WORDPRESS_VERSION"
if [ "$WORDPRESS_VERSION" = "latest" ]; then
  wget https://wordpress.org/latest.tar.gz
else
  wget https://wordpress.org/wordpress-$WORDPRESS_VERSION.tar.gz
fi
tar -xzf wordpress-$WORDPRESS_VERSION.tar.gz
cp -r wordpress/* /var/www/html/

# Set file permissions
sudo chown -R apache:apache /var/www/html/wordpress
sudo chmod -R 755 /var/www/html/wordpress

# Start Apache
sudo systemctl start httpd
sudo systemctl enable httpd