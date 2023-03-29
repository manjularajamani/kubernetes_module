# Variable for AWS Provider

variable "aws_access_key" {
  type        = string
  default     = "AKIA5RYHYXPCCNYZMJH5"
}

variable "aws_secret_key" {
  type        = string
  default     = "vFza/A7h+wSWrCd0VvNDv+QW0ttv6q4/7a+lFeBB"
}

variable "aws_region" {
  type        = string
  default     = "us-east-1"
}

# Variable for VPC module

variable "vpc_name" {
  default = "vpc-test"
}

variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

variable "gateway_name" {
  default = "gw-test"

}

variable "route_table_name" {
  default = "route-test"

}

variable "route_table_cidr_block" {
  default = "0.0.0.0/0"
}

variable "subnets_data" {
  default = {
    "0" = {
      "name" = "subnet1",
      "ip"   = "10.0.1.0/24"
      "zone" = "us-east-1a"
    },
    "1" = {
      "name" = "subnet2",
      "ip"   = "10.0.2.0/24"
      "zone" = "us-east-1b"
    },
    "2" = {
      "name" = "subnet3",
      "ip"   = "10.0.3.0/24"
      "zone" = "us-east-1c"
    }
  }
}

# Variable for EKS module

variable "eks_cluster_role_name" {
 default = "eksClusterRole"
}

variable "eks_worker_role_name" {
  default = "eksWorkerRole"
}

variable "eks_cluster_name" {
  default = "eks-master"

}

variable "node_group_name" {
  default = "nodegroup1"

}

# Variable for LoadBalancer module

variable "alb_ingress_name" {
  default = "aws-load-balancer-controller"

}

variable "alb_ingress_repo" {

  default = "https://aws.github.io/eks-charts"
}

variable "alb_chart" {
  default = "aws-load-balancer-controller"

}

variable "alb_serviceaccount" {
  default = "alb-service-account"

}

variable "alb_namespace" {
  default = "kube-system"
}

variable "alb_policy_name" {
  default = "aws-load-balancer-controller-policy"

}

# Variable for Jenkins module

variable "jenkins_name" {
  default = "jenkins"

}

variable "jenkins_repo" {
  default = "https://charts.jenkins.io"
}

variable "jenkins_chart" {
  default = "jenkins"

}

# Variable for prometheus module

variable "prometheus_name" {
  default = "prometheus"
}

variable "prometheus_repo" {
  default = "https://prometheus-community.github.io/helm-charts"
}

variable "prometheus_chart" {
  default = "prometheus"

}

# Variable for grafana module

variable "grafana_name" {
  default = "grafana"
}

variable "grafana_repo" {
  default = "https://grafana.github.io/helm-charts"
}

variable "grafana_chart" {
  default = "grafana"

}