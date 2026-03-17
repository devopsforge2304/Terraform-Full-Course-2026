output "instance_id" {
    value = aws_instance.web[0].id
  
}

output "public_ip" {
    value = aws_instance.web[0].public_ip
  
}

output "allowed_ports_list" {
    value = local.port_list
  
}

output "instance_arn" {

    value = aws_instance.web[0].arn
  
}