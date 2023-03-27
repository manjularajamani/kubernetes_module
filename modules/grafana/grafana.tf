provider "helm" {
  kubernetes {
    host                   = var.cluster_endpoint
    token                  = var.cluster_token
    cluster_ca_certificate = base64decode(var.cluster_certificate)
  }
}

# Installing grafana using Helm

resource "helm_release" "grafana" {

  name       = var.grafana_name
  repository = var.grafana_repo
  chart      = var.grafana_chart
  namespace  = var.grafana_namespace // we can also use another namespace Ex: namespace = <naspace_name>
  timeout    = 300


  values = [
    "${file("${path.module}/values.yaml")}"
  ]

}