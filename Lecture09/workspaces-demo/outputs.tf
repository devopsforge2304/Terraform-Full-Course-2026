output "workspace" {
    value = terraform.workspace
  
}

output "instance_type_used" {
    value = lookup(var.instance_type,terraform.workspace)
  
}