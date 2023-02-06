# terraform-eks-jenkins

This repo contains a Terraform plan for deploying Jenkins with Application load balancing on Amazon EKS

## Requirements

| Name | Version |
| ---- | ------- |
| terraform | >=1.0.0 |
| aws | >=4.0 |

## Providers

|Name | Version |
| --- | ------- |
| aws | >=4.0 |

## Terraform Resources

| Name | Type |
| ---------| ------------|
| `aws_vpc` | Resource |
| `aws_internet_gateway` | Resource |
| `aws_subnet` | Resource |
| `aws_route_table` | Resource |
| `aws_route_table_association` | Resource |
| `aws_eks_cluster` | Resource |
| `aws_eks_worker` | Resource |
| `helm` | Resource |
| `kubernetes` | Resource |


## Inputs

| Name |  Type | Required|
| ---- |  ---- | ------- |
| `aws_access_key` |  string | yes
| `aws_secret_key` | string | yes |
| `region` | string | yes |
| `vpc_name` | string | yes |
| `vpc_cidr_block` | string | yes |
| `gateway_name` | string | yes |
| `route_table_name` | string | yes |
| `route_table_cidr_block` | string | yes |
| `subnets_data` | array | yes |
| `eks_cluster_role_name` | string | yes |
| `eks_worker_role_name`  | string | yes |
| `eks_cluster_name`  | string | yes |
| `node_group_name`  | string | yes |
| `alb_ingress_name`  | string | yes |
| `alb_ingress_repo`  | string | yes |
| `alb_chart`  | string | yes |
| `alb-serviceaccount`  | string | yes |
| `alb-namespace`  | string | yes |
| `alb-policy-name`  | string | yes |
| `jenkins_name`  | string | yes |
| `jenkins_repo`  | string | yes |
| `jenkins_chart`  | string | yes |

## Run the Terraform template

```
terraform init
terraform plan 
terraform apply --auto-approve
```