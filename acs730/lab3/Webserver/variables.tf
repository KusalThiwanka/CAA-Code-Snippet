variable "prefix" {
  default     = "lab3"
  type        = string
  description = "Name prefix"
}

variable "default_tags" {
  default = {
    "Owner" = "Kusal"
    "App"   = "Web"
  }
  type        = map(any)
  description = "Default tags to be appliad to all AWS resources"
}

variable "instance_type" {
  default = {
    "prod" = "t3.medium"
    "test" = "t2.micro"
  }
  type        = map(string)
  description = "Type of the instance"
}

# Variable to signal the current environment 
variable "env" {
  default     = "test"
  type        = string
  description = "Deployment Environment"
}
