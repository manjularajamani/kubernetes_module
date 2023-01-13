provider "helm" {
  kubernetes {
    host                   = var.cluster_endpoint
    token                  = var.cluster_token
    cluster_ca_certificate = base64decode(var.cluster_certificate)
  }
}

# Installing Jenkins using Helm

resource "helm_release" "jenkins" {

  name       = var.jenkins_name
  repository = var.jenkins_repo
  chart      = var.jenkins_chart
  namespace  = var.jenkins-namespace           // we can also use another namespace Ex: namespace = <naspace_name>
  timeout    = 300


   values = [
    "${file("${path.module}/values.yaml")}"
  ]

}

# # Configuring Ingress using kubernetes resource

# resource "kubernetes_ingress_v1" "example" {
#   wait_for_load_balancer = true
#   metadata {
#     name = "example"
#     namespace = "kube-system"
#     annotations = {
#       "kubernetes.io/ingress.class" = "alb"
#       "alb.ingress.kubernetes.io/scheme" = "internet-facing"
#       "alb.ingress.kubernetes.io/target-type" = "ip"
#       "alb.ingress.kubernetes.io/healthcheck-protocol" = "HTTP"
#       "alb.ingress.kubernetes.io/healthcheck-port" = "8080"
#       "alb.ingress.kubernetes.io/healthcheck-interval-seconds" = "15"
#       "alb.ingress.kubernetes.io/healthcheck-timeout-seconds" = "5"
#       "alb.ingress.kubernetes.io/success-codes" = "200"
#       "alb.ingress.kubernetes.io/healthy-threshold-count" = "2"
#       "alb.ingress.kubernetes.io/unhealthy-threshold-count" = "2"
#     }
#   }
#   spec {
#     rule {
#       http {
#         path {
#           path = "/*"
#           backend {
#             service {
#               name = "jenkins"
#               port {
#                 number =8080
#               }
#             }
#           }
#         }
#       }
#     }
#   }
# }

