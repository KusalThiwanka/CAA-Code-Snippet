# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

# Data source for AMI id
data "aws_ami" "latest_amazon_linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# Reference subnet provisioned by Networking 
data "terraform_remote_state" "public_subnet" {
  backend = "s3"
  config = {
    bucket = "kusal-lab3"
    key    = "networking/terraform.tfstate"
    region = "us-east-1"
  }
}

# Data source for availability zones in us-east-1
data "aws_availability_zones" "available" {
  state = "available"
  filter {
    name   = "zone-name"
    values = ["us-east-1b"]
  }
}

# Define tags locally
locals {
  default_tags = merge(var.default_tags, { "env" = var.env })
}

# Adding SSH key to Amazon EC2
resource "aws_key_pair" "lab3" {
  key_name   = "lab3"
  public_key = file("lab3.pub")
}


resource "aws_instance" "lab3_ec2" {
  ami                         = data.aws_ami.latest_amazon_linux.id
  instance_type               = lookup(var.instance_type, var.env)
  key_name                    = aws_key_pair.lab3.key_name
  subnet_id                   = data.terraform_remote_state.public_subnet.outputs.subnet_id
  security_groups             = [aws_security_group.lab3_ec2_sg.id]
  associate_public_ip_address = true
  user_data                   = file("${path.module}/install_httpd.sh")
  root_block_device {
    encrypted = var.env == "prod" ? true : false
  }
  tags = merge(local.default_tags, {
    "Name" = "${var.prefix}-Amazon-Linux"
    }
  )
}

# Create EBS volume
resource "aws_ebs_volume" "web_ebs" {
  count             = var.env == "prod" ? 1 : 0
  availability_zone = data.aws_availability_zones.available.names[0]
  size              = 40
  tags = merge(var.default_tags,
    {
      "Name" = "${var.prefix}-EBS"
    }
  )
}

# Attach EBS volume
resource "aws_volume_attachment" "ebs_att" {
  count       = var.env == "prod" ? 1 : 0
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.web_ebs[count.index].id
  instance_id = aws_instance.lab3_ec2.id
}

# Create a security group for the EC2 instance
resource "aws_security_group" "lab3_ec2_sg" {
  name        = "lab3-ec2-sg"
  description = "Security group for Lab3 EC2 instance"
  vpc_id      = data.terraform_remote_state.public_subnet.outputs.vpc_id
  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    description      = "Allow HTTP for everywhere"
  }
  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    description      = "Allow SSH for everywhere"
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    description      = "Allow egress to everywhere"
  }
}