provider "helm" {
  kubernetes {
    host                   = var.cluster_endpoint
    token                  = var.cluster_token
    cluster_ca_certificate = base64decode(var.cluster_certificate)
  }
}

# Installing ArgoCD using Helm

resource "helm_release" "argocd" {

  name       = var.argocd_name
  repository = var.argocd_repo
  chart      = var.argocd_chart
  namespace  = var.argocd_namespace // we can also use another namespace Ex: namespace = <naspace_name>
  timeout    = 300


  values = [
    "${file("${path.module}/values.yaml")}"
  ]

}