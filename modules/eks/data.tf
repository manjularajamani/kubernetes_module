data "aws_eks_cluster_auth" "cluster" {
  name       = aws_eks_cluster.k8s-cluster.id
  depends_on = [aws_eks_cluster.k8s-cluster]
}

data "tls_certificate" "k8s-cluster" {
  url = aws_eks_cluster.k8s-cluster.identity[0].oidc[0].issuer
}

data "aws_caller_identity" "current" {}
