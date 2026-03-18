variable "aws_region" {
    type = string
    default = "us-east-1"
  
}

variable "environment" {
  type = string
}

variable "instance_type_map" {
    type = map(string)

    default = {
      dev = "t3.micro"
      prod = "t3.large"
    }
  
}

variable "subnet_cidr" {
    type = string
    default = "10.0.0.0/16"
  
}

variable "server_names" {
    type = list(string)
}

variable "common_tags" {
    type = map(string)
  
}

variable "allowed_ports" {

    type = list(number)
  
}