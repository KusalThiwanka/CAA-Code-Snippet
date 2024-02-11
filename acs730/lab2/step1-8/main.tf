terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region  = var.region
  alias   = "northern-virginia"
  profile = "default"
}

resource "aws_instance" "lab2" {
  ami           = "ami-08e4e35cccc6189f4"
  instance_type = var.instance_type
  key_name      = aws_key_pair.lab2.key_name
  tags = var.tags
}

resource "aws_key_pair" "lab2" {
  key_name   = "lab2"
  public_key = file("lab2-key-pair.pub")
}

resource "aws_ebs_volume" "lab2" {
  availability_zone = var.availability_zone
  size              = var.volume_size
  tags = var.ebs_tags
}

resource "aws_volume_attachment" "lab2-ebs-att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.lab2.id
  instance_id = aws_instance.lab2.id
}

# resource "local_file" "lab2" {
#   content  = "Welcome to Lab 2. I'm Kusal Thiwanka\n"
#   filename = "${path.module}/lab2_step6.txt"
# }

# resource "tls_private_key" "lab2" {
#   algorithm = "RSA"
# }

# resource "local_file" "lab2" {
#   content  = tls_private_key.lab2.private_key_pem
#   filename = "lab2.pem"
# }

# resource "aws_key_pair" "lab2" {
#   key_name   = "lab2"
#   public_key = tls_private_key.lab2.public_key_openssh
# }