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
  default     = "lab2_4"
  description = "Name prefix"
}

variable "cidr_block" {
  type        = list(string)
  default     = ["172.31.96.64/26", "172.31.96.128/26"]
  description = "Subnet CIDRs"
}