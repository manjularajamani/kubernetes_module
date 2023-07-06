output "vpc_id" {
  description = "ID of project VPC"
  value       = module.vpc.vpc_id
}

output "subnet_id" {
  description = "ID of project subnets"
  value       = module.vpc.subnet_id
}

output "route_id" {
  description = "ID of project subnets"
  value       = module.vpc.route_id
}

output "gateway_id" {
  description = "ID of project subnets"
  value       = module.vpc.gateway_id
}


output "account_id" {
  value = module.eks.account_id
}

output "security_group_id" {
  value = module.vpc.security_group_id
}

# output "load_balancer_hostname" {
#   value = module.jenkins.load_balancer_hostname
# }