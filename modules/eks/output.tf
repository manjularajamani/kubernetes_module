output "eks_cluster_name" {
  value = aws_eks_cluster.k8s-cluster.id
}

output "endpoint" {
  value = aws_eks_cluster.k8s-cluster.endpoint
}

output "token" {
  value = data.aws_eks_cluster_auth.cluster.token
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.k8s-cluster.certificate_authority[0].data
}

output "identity-oidc-issuer" {
  #  value = data.aws_eks_cluster.k8s-cluster.name   // To list all resources in JSON format
  value = aws_eks_cluster.k8s-cluster.identity[0].oidc[0].issuer
}


output "aws_iam_openid_connect_provider" {
  value = aws_iam_openid_connect_provider.k8s-cluster.arn

}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "eks_worker_name" {
  value = aws_eks_node_group.k8s-worker.node_group_name
}
