aws_region = "us-east-1"

instance_count = 1

enable_monitoring = true

availability_zones = [ "us-east-1a","us-east1b" ]

allowed_ports = [
22,
3306
]

common_tags = {
    Project = "terraform-datatypes"
    Owner = "Rahul"
}

server_config = {
instance_type = "t3.micro"
volume_size = 8
}

tuple_example = ["tuple_example",10,true]

environment = "dev"

