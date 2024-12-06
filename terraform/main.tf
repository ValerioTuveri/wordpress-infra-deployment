resource "aws_instance" "example" {
  ami           = "ami-0669b163befffbdfc" // Amazon Linux 2023 AMI ID for eu-central-1
  instance_type = "t2.micro"

  tags = {
    Name = "ExampleInstance"
  }
}