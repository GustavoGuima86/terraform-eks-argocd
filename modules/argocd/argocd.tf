resource "helm_release" "argo" {
  name       = "argo"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "7.7.10"

  values = [
    file("${path.module}/values/values-argocd.yaml")
  ]
}

resource "helm_release" "argo_apps" {
  name       = "argo-apps"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argocd-apps"
  version    = "1.6.2"

  values = [
    file("${path.module}/values/values-argocd-apps.yaml")
  ]

  depends_on = [helm_release.argo]
}