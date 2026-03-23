variable "instance_type" {

    type = map(string)

    default = {
      dev = "t3.micro"
      staging = "t3.medium"
      prod = "m5d.xlarge"
    }
  
}