resource "aws_security_group" "wordpress_sg" {
  name        = "wordpress_sg"
  description = "Security group for WordPress instance"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Consider restricting to your IP
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "wordpress" {
  ami           = "ami-0669b163befffbdfc" // Amazon Linux 2023 AMI ID for eu-central-1
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.wordpress_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              # Install Nginx
              amazon-linux-extras install nginx1 -y
              systemctl start nginx
              systemctl enable nginx

              # Install PHP and required extensions
              amazon-linux-extras install php8.0 -y
              yum install -y php-mysqlnd php-fpm

              # Download and install WordPress
              WORDPRESS_VERSION="${var.wordpress_version}"
              if [ "$WORDPRESS_VERSION" = "latest" ]; then
                wget https://wordpress.org/latest.tar.gz
              else
                wget https://wordpress.org/wordpress-$WORDPRESS_VERSION.tar.gz
              fi
              tar -xzf wordpress-${WORDPRESS_VERSION}.tar.gz
              cp -r wordpress/* /usr/share/nginx/html/
              chown -R nginx:nginx /usr/share/nginx/html/
              chmod -R 755 /usr/share/nginx/html/

              # Configure PHP
              sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/' /etc/php.ini

              # Start PHP-FPM
              systemctl start php-fpm
              systemctl enable php-fpm
              EOF


  tags = {
    Name = "WordPressInstance"
  }
}