resource "helm_release" "argo" {
  name       = "argo"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "7.7.10"

  values = [
    file("${path.module}/values/values-argocd.yaml")
  ]
}


# resource "kubernetes_ingress_v1" "grafana_ingress" {
#   metadata {
#     name      = "argo"
#     annotations = {
#       "alb.ingress.kubernetes.io/listen-ports"             = "[{\"HTTP\":80}]"
#       "alb.ingress.kubernetes.io/scheme"                   = "internet-facing"
#       "alb.ingress.kubernetes.io/target-type"              = "ip"
#       "alb.ingress.kubernetes.io/healthcheck-path"         = "/"
#     }
#   }
#
#   spec {
#     ingress_class_name = "alb"
#
#     default_backend {
#       service {
#         name = "argo-argocd-server"
#         port {
#           number = 80
#         }
#       }
#     }
#   }
# }

resource "helm_release" "argo_apps" {
  name       = "argo-apps"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argocd-apps"
  version    = "2.0.2"

  values = [
    file("${path.module}/values/values-argocd-apps.yaml")
  ]

  depends_on = [helm_release.argo]
}