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

#VPC
resource "aws_vpc" "main" {

  cidr_block = var.subnet_cidr

  tags = merge(
    local.instance_tag,
    {
      Name = "main-vpc"
      Environment = "dev"
    }
  )
  
}

#subnet

resource "aws_subnet" "public_subnet" {

  vpc_id = aws_vpc.main.id

  cidr_block = local.subnet1

  tags = merge(
    local.instance_tag,
    {
      Name = "public-subnet"
    }
  )
  
}


resource "aws_security_group" "web_sg" {

  name = "web-sg"

  vpc_id = aws_vpc.main.id

  dynamic "ingress" {

    for_each = var.allowed_ports

    content {

      from_port = ingress.value
      to_port = ingress.value
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      
    }
    
  }
  
}


resource "aws_instance" "web" {

    ami = "ami-02dfbd4ff395f2a1b"

    subnet_id = aws_subnet.public_subnet.id

    # for_each expands resources
    for_each = toset(var.server_names)

    # lookup is evaulated by for_each
    instance_type = local.instance_type_lookup

    #count = local.total_servers

    vpc_security_group_ids = [aws_security_group.web_sg.id]

    user_data = file("userdata.sh")

    tags = merge(
      local.merged_tags,
      {
        Name = each.value
      }
    )
  
}