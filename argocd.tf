resource "kubernetes_namespace" "argocd" {
    depends_on = [kind_cluster.default]

    provider = kubernetes

    metadata {
        name = "argocd"
    }
}

resource "helm_release" "argocd" {
    depends_on = [kubernetes_namespace.argocd]

    name       = "argocd"
    repository = "https://mapspiral.github.io/example-argocd-charts"
    chart      = "argo-cd"
    version    = "0.0.1"

    namespace = kubernetes_namespace.argocd.metadata[0].name

    wait = true
}