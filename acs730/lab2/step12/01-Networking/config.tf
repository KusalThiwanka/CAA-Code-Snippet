terraform {
  backend "s3" {
    bucket = "acs730-lab2-kusal"
    key    = "dev/01-networking/terraform.tfstate"
    region = "us-east-1"
  }
}