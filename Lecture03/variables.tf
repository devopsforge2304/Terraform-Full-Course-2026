# variables.tf

#String

variable "aws_region" {

type = string
description = "Define your AWS region"
}

#Number

variable "instance_count" {
type = number
description = "Number of instances"
}

#Boolean

variable "enable_monitoring" {
type = bool
description = "Enable/Disable monitoring"
}

#List

variable "availability_zones" {
type = list(string)
}

#SET

variable "allowed_ports" {
type = set(number) 
}

#MAP

variable "common_tags" {
type = map(string)
}

#Object

variable "server_config" { 
type = object({ 
instance_type = string    
volume_size   = number  })
}

#Tuple

variable "tuple_example" {
type = tuple([ string,number,bool ])
}

# variable validation

variable "environment" {
type = string
validation {
  condition = contains(["dev","staging"],var.environment)
  error_message = "Env must be dev or staging"
}
}