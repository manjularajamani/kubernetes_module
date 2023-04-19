module "vpc" {
  source                 = "./modules/vpc"
  vpc_name               = var.vpc_name
  vpc_cidr_block         = var.vpc_cidr_block
  subnets_data           = var.subnets_data
  gateway_name           = var.gateway_name
  route_table_name       = var.route_table_name
  route_table_cidr_block = var.route_table_cidr_block
}

module "eks" {
  source                = "./modules/eks"
  eks_cluster_role_name = var.eks_cluster_role_name
  eks_worker_role_name  = var.eks_worker_role_name
  eks_cluster_name      = var.eks_cluster_name
  node_group_name       = var.node_group_name
  subnet_id             = module.vpc.subnet_id

  depends_on = [
    module.vpc
  ]

}

module "loadbalancer" {
  source                          = "./modules/loadbalancer"
  cluster_endpoint                = module.eks.endpoint
  cluster_token                   = module.eks.token
  cluster_certificate             = module.eks.kubeconfig-certificate-authority-data
  alb_ingress_name                = var.alb_ingress_name
  alb_ingress_repo                = var.alb_ingress_repo
  alb_chart                       = var.alb_chart
  alb_serviceaccount              = var.alb_serviceaccount
  alb_namespace                   = var.alb_namespace
  alb_policy_name                 = var.alb_policy_name
  account_id                      = module.eks.account_id
  cluster_name                    = module.eks.eks_cluster_name
  identity_oidc_issuer            = module.eks.identity-oidc-issuer
  aws_iam_openid_connect_provider = module.eks.aws_iam_openid_connect_provider

}


module "jenkins" {
  source        = "./modules/jenkins"
  jenkins_name  = var.jenkins_name
  jenkins_repo  = var.jenkins_repo
  jenkins_chart = var.jenkins_chart
  jenkins_namespace = var.jenkins_namespace   // able to use another namespace

  cluster_endpoint    = module.eks.endpoint
  cluster_token       = module.eks.token
  cluster_certificate = module.eks.kubeconfig-certificate-authority-data

}

module "prometheus" {
  source        = "./modules/prometheus"
  prometheus_name = var.prometheus_name
  prometheus_repo  = var.prometheus_repo
  prometheus_chart = var.prometheus_chart
  prometheus_namespace = var.prometheus_namespace
  cluster_endpoint    = module.eks.endpoint
  cluster_token       = module.eks.token
  cluster_certificate = module.eks.kubeconfig-certificate-authority-data
}


module "grafana" {
  source        = "./modules/grafana"
  grafana_name = var.grafana_name
  grafana_repo  = var.grafana_repo
  grafana_chart = var.grafana_chart
  grafana_namespace = var.grafana_namespace
  cluster_endpoint    = module.eks.endpoint
  cluster_token       = module.eks.token
  cluster_certificate = module.eks.kubeconfig-certificate-authority-data
}


module "ebs_csi" {
  source        = "./modules/ebs-csi"
  ebs_csi_name = var.ebs_csi_name
  ebs_csi_repo  = var.ebs_csi_repo
  ebs_csi_chart = var.ebs_csi_chart
  ebs_csi_namespace = var.ebs_csi_namespace
  cluster_endpoint    = module.eks.endpoint
  cluster_token       = module.eks.token
  cluster_certificate = module.eks.kubeconfig-certificate-authority-data
}