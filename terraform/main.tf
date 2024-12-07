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
    cidr_blocks = ["0.0.0.0/0"] # Consider restricting to your IP
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "wordpress" {
  ami                    = "ami-0669b163befffbdfc" // Amazon Linux 2023 AMI ID for eu-central-1
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.wordpress_sg.id]

  user_data = templatefile("${path.module}/../scripts/install_wordpress.sh", {
    wordpress_version = var.wordpress_version
  })

  tags = {
    Name = "WordPressInstance"
  }
}
