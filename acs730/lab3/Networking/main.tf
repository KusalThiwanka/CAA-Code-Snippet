# Define required providers
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
  region = "us-east-1"
}

# Resource for default VPC id
resource "aws_default_vpc" "default_vpc" {
  tags = {
    Name = "Default VPC"
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

# Add provisioning of the public subnet in the default VPC on us-east-1 availability zone
resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_default_vpc.default_vpc.id
  cidr_block        = var.cidr_block
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = merge(
    var.default_tags, {
      Name = "${var.prefix}-public-subnet"
    }
  )
}




