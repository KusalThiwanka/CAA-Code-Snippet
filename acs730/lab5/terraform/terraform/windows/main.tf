# Specify AWS provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
  required_version = ">= 0.14.6"
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

data "aws_ami" "ami-windows" {
  most_recent = true
  filter {
    name   = "name"
    values = ["Windows_Server-2019-English-Full-Base-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["amazon"]
}

# Get VPC id of default VPC
data "aws_vpc" "default" {
  default = true
}

# Get an existing IAM instance profile
data "aws_iam_instance_profile" "lab_profile" {
  name = "LabInstanceProfile"
}

# Provision SSH key pair for Windows VMs
resource "aws_key_pair" "windows_key" {
  key_name   = "windows_key"
  public_key = file(var.path_to_windows_key)
  tags = {
    Name = "windows-keypair"
  }
}


# Security Groups that allows SSH and HTTP access
module "windows_sg" {
  source     = "cloudposse/security-group/aws"
  attributes = ["windows"]

  # Allow unlimited egress
  allow_all_egress = true

  rules = [
    {
      key         = "winrm"
      type        = "ingress"
      from_port   = 5986
      to_port     = 5986
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      self        = null
      description = "Allow WinRM from anywhere"
    }
  ]

  vpc_id = data.aws_vpc.default.id
  tags = {
    Name = "windowsServer-sg"
  }
}

# Create Amazon Windows EC2 instances in a default VPC
resource "aws_instance" "windows_vm" {
  count                  = var.num_windows_vms
  ami                    = data.aws_ami.ami-windows.id
  key_name               = aws_key_pair.windows_key.key_name
  instance_type          = var.windows_instance_type
  vpc_security_group_ids = [module.windows_sg.id]
  iam_instance_profile   = data.aws_iam_instance_profile.lab_profile.name
  tags = {
    Name = "WindowsServer-${count.index+1}"
  }

}





