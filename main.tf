# Specify the AWS provider
provider "aws" {
  region = "us-east-1"  # Change this if needed
}

# Create a security group allowing SSH access
resource "aws_security_group" "ec2_sg" {
  name        = "ec2_security_group"
  description = "Allow SSH inbound traffic"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow SSH from anywhere (for testing)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create an EC2 instance
resource "aws_instance" "my_ec2" {
  ami           = "ami-052064a798f08f0d3"  # Amazon Linux 2 AMI (us-east-1)
  instance_type = "t3.micro"
  key_name      = "MyNewKeyPair"           # Must exist in AWS
  security_groups = [aws_security_group.ec2_sg.name]

  tags = {
    Name = "TerraformEC2Lab"
  }
}
