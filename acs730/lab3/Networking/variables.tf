variable "prefix" {
  type        = string
  default     = "lab3"
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

variable "cidr_block" {
  default     = "172.31.97.0/24"
  type        = string
  description = "Public Subnet CIDR"
}


