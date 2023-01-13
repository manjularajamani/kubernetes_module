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
  alb-serviceaccount              = var.alb-serviceaccount
  alb-namespace                   = var.alb-namespace
  alb-policy-name                 = var.alb-policy-name
  account_id                      = module.eks.account_id
  cluster_name                    = module.eks.eks_cluster_name
  identity-oidc-issuer            = module.eks.identity-oidc-issuer
  aws_iam_openid_connect_provider = module.eks.aws_iam_openid_connect_provider

}


module "jenkins" {
  source        = "./modules/jenkins"
  jenkins_name  = var.jenkins_name
  jenkins_repo  = var.jenkins_repo
  jenkins_chart = var.jenkins_chart
  jenkins-namespace = module.loadbalancer.name_space   // able to use another namespace

  cluster_endpoint    = module.eks.endpoint
  cluster_token       = module.eks.token
  cluster_certificate = module.eks.kubeconfig-certificate-authority-data

}

