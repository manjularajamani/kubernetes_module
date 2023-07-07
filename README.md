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
| `LoadBalancer` | Resource |


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
| `prometheus_name`  | string | yes |
| `prometheus_repo`  | string | yes |
| `prometheus_chart`  | string | yes |
| `grafana_name`  | string | yes |
| `grafana_repo`  | string | yes |
| `grafana_chart`  | string | yes |
| `ebs_csi_name`  | string | yes |
| `ebs_csi_repo`  | string | yes |
| `ebs_csi_chart`  | string | yes |

# Deployments

## Step: 1
```
terraform init
terraform plan 
terraform apply --auto-approve
```

## Step: 2
We need to perform [port forwarding](https://kubernetes.io/docs/tasks/access-application-cluster/port-forward-access-application-cluster/#forward-a-local-port-to-a-port-on-the-pod) action to check whether the Prometheus deployed successfully or not
```
kubectl port-forward service/prometheus-server 9090:80 -n monitoring
```

## Step: 3
To check Jenkins
```
<loadbalancer_url>/jenkins
```

## step: 4
To check Grafana
```
<loadbalancer_url>/grafana
```
To login into Grafana using the default username and password use the below command
```
kubectl get secret grafana -n monitoring -o yaml
```

Decode the credentials and use it


# Infrastructure testing using Chef Inspec

## step: 1
Install the [Chef Inspec Tool](https://docs.chef.io/inspec/install/)

## step: 2
Run the bellow command to create the default file structure of inspec
```
inspec init profile --platform aws <your-dir-name>
```

## step: 3
To run the inspec test files run the below command
```
inspec exec . -t aws:// --input-file inputs.yml
```