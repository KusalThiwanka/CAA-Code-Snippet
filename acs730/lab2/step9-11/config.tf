terraform {
  backend "s3" {
    bucket = "acs730-lab2-kusal"
    key    = "dev/terraform.tfstate"
    region = "us-east-1"
  }
}