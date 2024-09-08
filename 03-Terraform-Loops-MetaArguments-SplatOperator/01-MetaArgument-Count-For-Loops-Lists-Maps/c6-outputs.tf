# Terraform Output Vaules
# For loop with list to get Public IP of Instances
output "instance_publicip_list" {
  description = "EC2 Instance Public IPs List"
  value = [for instance in aws_instance.myec2vm: instance.public_ip]
}

# For loop with list to get EC2 Instance Public DNS
output "instance_publicdns_list" {
  description = "EC2 Instance Public DNS List"
  value = [for instance in aws_instance.myec2vm: instance.public_dns]
}
/*
# For loop with Map to get Public IP of Instances
output "instance_publicip_map" {
  description = "EC2 Instance Public IPs List"
  value = {for instance in aws_instance.myec2vm: instance.id => instance.public_ip}
}

# For loop with Map to get EC2 Instance Public DNS
output "instance_publicdns_map" {
  description = "EC2 Instance Public DNS List"
  value = {for instance in aws_instance.myec2vm: instance.id => instance.public_dns}
}
*/

# Output Latest Generalized Splat Operator - Returns the Public IPs
output "splat_instance_publicips" {
  description = "Using Splat Operator to get EC2 Instance Public IPs"
  value = aws_instance.myec2vm[*].public_ip
}

# Output Latest Generalized Splat Operator - Returns the Public DNS Names
output "splat_instance_publicdns_nanmes" {
  description = "Using Splat Operator to get EC2 Instance Public DNS Names"
  value = aws_instance.myec2vm[*].public_dns
}

