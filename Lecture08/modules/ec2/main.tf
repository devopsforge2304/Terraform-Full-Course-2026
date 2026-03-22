locals {
  # lookup function
  instance_type_lookup = lookup(var.instance_type_map, var.environment, "t3.micro")

  # merge function
  merged_tags = merge(
    var.common_tags,
    {
      Name        = "Dev-server"
      Environment = "dev"
    }
  )

  # for exression in list and map

  instance_server_names = [for name in var.server_names : upper(name)]

  instance_tag = {
    for key, value in var.common_tags :
    upper(key) => upper(value)
  }

}


resource "aws_instance" "web" {
  ami = "ami-02dfbd4ff395f2a1b"

  subnet_id = var.subnet_id

  # for_each expands resources
  for_each = toset(var.server_names)

  # lookup is evaulated by for_each
  instance_type = local.instance_type_lookup

  #count = local.total_servers

  key_name = "terraform-examples"

  vpc_security_group_ids = var.security_group_ids

  user_data = file("${path.module}/userdata.sh")

  tags = merge(
    local.merged_tags,
    {
      Name = each.value
    }
  )
}
