variable "region" {
  type        = string
  default     = "us-east-1"
  description = "The AWS region where resources will be created."
}

variable "default_tags" {
  type = map(string)
  default = {
    Owner = "Kusal Thiwanka"
    App   = "Web"
  }
  description = "Default tags to be appliad to all AWS resources"
}

variable "prefix" {
  type        = string
  default     = "lab2_2"
  description = "Name prefix"
}

# Step 9 - Provision public subnet in default VPC
variable "vpc_id" {
  default     = "vpc-07bb711bb73b19bc3"
  type        = string
  description = "Default VPC id"
}

# Step 9 - Provision public subnet in default VPC
variable "cidr_block" {
  default     = "172.31.96.0/24"
  type        = string
  description = "Subnet CIDR"
}

# Step 9 - Provision public subnet in default VPC
variable "az" {
  default     = "us-east-1b"
  type        = string
  description = "AZ to use for EC2 provisioning"
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "The type of EC2 instance to launch."
}

variable "key_name" {
  type        = string
  default     = "lab2"
  description = "The name of the EC2 key pair to associate with the instance."
}

variable "availability_zone" {
  type        = string
  default     = "us-east-1b"
  description = "The availability zone in which to create the EBS volume."
}

variable "volume_size" {
  type        = number
  default     = 10
  description = "The size of the EBS volume in gigabytes."
}

