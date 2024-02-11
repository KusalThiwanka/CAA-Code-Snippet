terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region  = var.region
  alias   = "northern-virginia"
  profile = "default"
}

# Add provisioning of the public subnetin the default VPC
resource "aws_subnet" "public_subnet_lab2" {
  vpc_id            = var.vpc_id
  cidr_block        = var.cidr_block
  availability_zone = var.az
  tags = merge(
    var.default_tags, {
      Name = "${var.prefix}-public-subnet"
    }
  )
}

# Set the lab2 EC2 instance in the default VPC, new subnet
resource "aws_instance" "lab2" {
  ami                         = "ami-08e4e35cccc6189f4"
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.lab2.key_name
  subnet_id                   = aws_subnet.public_subnet_lab2.id
  associate_public_ip_address = true

  tags = merge(var.default_tags,
    {
      "Name" = "${var.prefix}-EC2"
    }
  )
}

# Create another EBS volume
resource "aws_ebs_volume" "lab2_2" {
  availability_zone = var.az
  size              = 10

  tags = merge(var.default_tags,
    {
      "Name" = "${var.prefix}-EBS"
    }
  )
}

resource "aws_key_pair" "lab2" {
  key_name   = "lab2"
  public_key = file("lab2-key-pair.pub")
}

resource "aws_ebs_volume" "lab2" {
  availability_zone = var.availability_zone
  size              = var.volume_size
  tags = merge(var.default_tags,
    {
      Name = "Lab2-EBS"
    }
  )
}

resource "aws_volume_attachment" "lab2-ebs-att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.lab2.id
  instance_id = aws_instance.lab2.id
}

# resource "aws_instance" "lab2" {
#   ami           = "ami-08e4e35cccc6189f4"
#   instance_type = var.instance_type
#   key_name      = aws_key_pair.lab2.key_name
#   tags = merge(var.default_tags,
#     {
#       Name = "Lab2-Kusal"
#     }
#   )
# }

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