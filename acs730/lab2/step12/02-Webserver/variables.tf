variable "instance_type" {
  type        = string
  default     = "t3.micro"
  description = "Type of the instance"
}

variable "default_tags" {
  type = map(any)
  default = {
    "Owner" = "Kusal Thiwanka"
    "App"   = "Web"
  }
  description = "Default tags to be appliad to all AWS resources"
}

variable "prefix" {
  type        = string
  default     = "lab2_3"
  description = "Name prefix"
}



