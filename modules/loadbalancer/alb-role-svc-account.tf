# Configure the Helm and Kubernetes

provider "helm" {
  kubernetes {
    host                   = var.cluster_endpoint
    token                  = var.cluster_token
    cluster_ca_certificate = base64decode(var.cluster_certificate)
  }
}

provider "kubernetes" {
    host                   = var.cluster_endpoint
    token                  = var.cluster_token
    cluster_ca_certificate = base64decode(var.cluster_certificate)
}

# Creating NameSpace

resource "kubernetes_namespace" "k8s_monitoring" {
  metadata {
    annotations = {
      name = "monitoring_kubernetes"
    }
       name = "monitoring"
  }
}

# Creating role for ALB ingress controller

resource "aws_iam_role" "alb_role" {
  name = var.alb_serviceaccount
  path = "/"
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRoleWithWebIdentity"
      Effect = "Allow"
      Principal = {

        Federated = var.aws_iam_openid_connect_provider

      }
      Condition = {
        StringEquals = {
          format("%s:sub", local.oidcprovider) = local.oidc_fully_qualified_subjects,
          format("%s:aud", local.oidcprovider) = "sts.amazonaws.com"

        }
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_policy" "alb-policy" {
  name        = var.alb_policy_name
  description = format("Allow aws-load-balancer-controller to manage AWS resources")
  path        = "/"
  policy      = file("${path.module}/policy.json")

}

resource "aws_iam_role_policy_attachment" "alb-policy-attachment" {
  policy_arn = aws_iam_policy.alb-policy.arn
  role       = aws_iam_role.alb_role.name

}


locals {
  oidc_fully_qualified_subjects = format("system:serviceaccount:%s:%s", var.alb_namespace, var.alb_serviceaccount)
  oidcprovider                  = replace(var.identity_oidc_issuer, "/(https://)/", "")
}

# Installing ALB loadbalancer using helm

resource "helm_release" "alb_ingress" {

  name       = var.alb_ingress_name
  repository = var.alb_ingress_repo
  chart      = var.alb_chart
  namespace  = var.alb_namespace
  timeout    = 300

  dynamic "set" {
    for_each = {
      "clusterName"                                               = var.cluster_name
      "serviceAccount.name"                                       = var.alb_serviceaccount
      "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn" = aws_iam_role.alb_role.arn
    }

    content {
      name  = set.key
      value = set.value
    }
  }

}