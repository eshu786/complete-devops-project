resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
  }
}

resource "helm_release" "argocd" {
  name             = "argocd"
  chart           = "argo-cd"
  repository      = "https://argoproj.github.io/argo-helm"
  namespace       = kubernetes_namespace.argocd.metadata[0].name
  depends_on      = [kubernetes_namespace.argocd]  # Ensures namespace is created first

  values = [
    <<EOF
server:
  service:
    type: ClusterIP
EOF
  ]
}
