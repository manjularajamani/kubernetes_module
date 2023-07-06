output "vpc_id" {
  description = "ID of project VPC"
  value       = aws_vpc.vpc.id
}

output "subnet_id" {
  description = "ID of project SUBNET"
  value       = [for k, v in aws_subnet.public_subnet : aws_subnet.public_subnet[k].id]
}

output "gateway_id" {
  description = "ID of project GATWAY"
  value       = aws_internet_gateway.gw.id
}

output "route_id" {
  description = "ID of project ROUTE"
  value       = aws_route_table.route.id
}

output "security_group_id"{
  description = "ID of Security group"
  value       = aws_security_group.security_group.id
}