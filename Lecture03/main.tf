locals {
  instance_name = "${var.environment}-web-server"

  instance_tags = merge(
    var.common_tags,
    {
        Name = local.instance_name
        Environment = var.environment

    }
  )

tuple_inst = var.tuple_example[0]

port_list = tolist(var.allowed_ports)
}

resource "aws_instance" "web" {

    count = var.instance_count
    ami = "ami-02dfbd4ff395f2a1b"
    instance_type = var.server_config.instance_type

    monitoring = var.enable_monitoring
    availability_zone = var.availability_zones[0]

    root_block_device {
      volume_size = var.server_config.volume_size
    }

    tags = local.instance_tags
  
}