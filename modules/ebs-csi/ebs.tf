provider "helm" {
  kubernetes {
    host                   = var.cluster_endpoint
    token                  = var.cluster_token
    cluster_ca_certificate = base64decode(var.cluster_certificate)
  }
}

# Installing ebs_csi using Helm

resource "helm_release" "ebs_csi" {

  name       = var.ebs_csi_name
  repository = var.ebs_csi_repo
  chart      = var.ebs_csi_chart
  namespace  = var.ebs_csi_namespace // we can also use another namespace Ex: namespace = <naspace_name>
  timeout    = 300

}