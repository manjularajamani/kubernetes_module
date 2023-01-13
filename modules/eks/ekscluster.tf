resource "aws_iam_role" "eksClusterRole" {
  name = var.eks_cluster_role_name

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}

POLICY
}

resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eksClusterRole.name
}

resource "aws_eks_cluster" "k8s-cluster" {
  name     = var.eks_cluster_name
  role_arn = aws_iam_role.eksClusterRole.arn

  vpc_config {

    #subnet_ids = [for k, v in aws_subnet.public_subnet: aws_subnet.public_subnet[k].id] // Used for without modules
    subnet_ids = var.subnet_id
  }


  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
  ]
}

# Creating Identity provider in IAM

resource "aws_iam_openid_connect_provider" "k8s-cluster" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.k8s-cluster.certificates.0.sha1_fingerprint]
  url             = aws_eks_cluster.k8s-cluster.identity[0].oidc[0].issuer
}
