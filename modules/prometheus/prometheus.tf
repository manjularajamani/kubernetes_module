provider "helm" {
  kubernetes {
    host                   = var.cluster_endpoint
    token                  = var.cluster_token
    cluster_ca_certificate = base64decode(var.cluster_certificate)
  }
}

# Installing prometheus using Helm

resource "helm_release" "prometheus" {

  name       = var.prometheus_name
  repository = var.prometheus_repo
  chart      = var.prometheus_chart
  namespace  = var.prometheus_namespace // we can also use another namespace Ex: namespace = <naspace_name>
  timeout    = 300


  values = [
    "${file("${path.module}/values.yaml")}"
  ]

}