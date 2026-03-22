variable "subnet_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "common_tags" {
  type = map(string)
}
