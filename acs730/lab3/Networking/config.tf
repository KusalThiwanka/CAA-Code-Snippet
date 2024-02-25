# Refference the bucket for save tfstate file
terraform {
  backend "s3" {
    bucket = "kusal-lab3"
    key    = "networking/terraform.tfstate"
    region = "us-east-1"
  }
}