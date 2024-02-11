variable "region" {
    type = string
    default = "us-east-1"
    description = "The AWS region where resources will be created."
}

variable "instance_type" {
    type = string
    default = "t3.micro"
    description = "The type of EC2 instance to launch."
}

variable "key_name" {
    type = string
    default = "lab2"
    description = "The name of the EC2 key pair to associate with the instance."
}

variable "availability_zone" {
    type = string
    default = "us-east-1b"
    description = "The availability zone in which to create the EBS volume."
}

variable "volume_size" {
    type = number
    default = 10
    description = "The size of the EBS volume in gigabytes."
}

variable "tags" {
    type = map(string)
    default = {
        Name = "Lab2-Kusal"
        Owner = "Kusal Thiwanka"
        App = "Web"
    }
    description = "A map of tags to apply to EC2 instance."
}

variable "ebs_tags" {
    type = map(string)
    default = {
        Name = "Lab2-EBS"
    }
    description = "A map of tags to apply to EBS."
}