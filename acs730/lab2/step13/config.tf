terraform {
  backend "s3" {
    bucket = "acs730-lab2-kusal"
    key    = "dev/step13/terraform.tfstate"
    region = "us-east-1"
  }
}