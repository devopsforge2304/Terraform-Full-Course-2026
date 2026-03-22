variable "environment" {
  type = string
}

variable "instance_type_map" {
  type = map(string)

  default = {
    dev  = "t3.micro"
    prod = "t3.large"
  }

}

variable "server_names" {
  type = list(string)
}

variable "common_tags" {
  type = map(string)
}

variable "subnet_id" {
  type = string
}

variable "security_group_ids" {
  type = list(string)
}
