locals {
  
  #conditional expression - condiion ? true : false
  
  instance_type = var.environment == "prod"? "t3.large" : "t3.micro"

  # length function

  total_servers = length(var.server_names)

  # lookup function

  instance_type_lookup = lookup(var.instance_type_map, var.environment,"t3.micro")

  # merge function

  merged_tags = merge(
    var.common_tags,
    {
        Name = "Dev-server"
        Environment = "dev"
    }
  )

  # cidrsubnet function
  subnet1 = cidrsubnet(var.subnet_cidr,8,1)

  # for exression in list and map

  instance_server_names = [for name in var.server_names : upper(name)]

  instance_tag = {
    for key, value in var.common_tags :
    upper(key) => upper(value)
  }

}

resource "aws_instance" "web" {

    ami = "ami-02dfbd4ff395f2a1b"

    instance_type = local.instance_type

    count = local.total_servers

    user_data = file("userdata.sh")

    tags = local.merged_tags
  
}