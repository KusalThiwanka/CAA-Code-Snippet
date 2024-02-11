# Define the provider
provider "aws" {
  region = "us-east-1"
}

# Data source for Latest AMI id
data "aws_ami" "latest_amazon_linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# Use remote state to retrieve the data from 01-networking
data "terraform_remote_state" "public_subnet" {
  backend = "s3"
  config = {
    bucket = "acs730-lab2-kusal"
    key    = "dev/01-networking/terraform.tfstate"
    region = "us-east-1"
  }
}

# Data source for availability zones in us-east-1
data "aws_availability_zones" "available" {
  state = "available"
}

# Reference subnet provisioned by 01-Networking 
resource "aws_instance" "lab2" {
  ami                         = data.aws_ami.latest_amazon_linux.id
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.lab2.key_name
  subnet_id                   = data.terraform_remote_state.public_subnet.outputs.subnet_id
  associate_public_ip_address = true
  tags = merge(var.default_tags,
    {
      "Name" = "${var.prefix}-EC2"
    }
  )
}

# Attach EBS volume
resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.lab2.id
  instance_id = aws_instance.lab2.id
}

# Adding SSH key to Amazon EC2
resource "aws_key_pair" "lab2" {
  key_name   = "lab2"
  public_key = file("lab2-key-pair.pub")
}

# Create another EBS volume
resource "aws_ebs_volume" "lab2" {
  availability_zone = data.aws_availability_zones.available.names[0]
  size              = 40
  tags = merge(var.default_tags,
    {
      "Name" = "${var.prefix}-EBS"
    }
  )
}