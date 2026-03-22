output "instance_id" {
  value = values(aws_instance.web)[*].id
}
