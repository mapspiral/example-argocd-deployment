locals {
  kubeconfig_path = "${path.module}/tmp/kubeconfig"
}

resource "kind_cluster" "default" {
    name = "dev-cluster"

    kubeconfig_path = local.kubeconfig_path

    wait_for_ready = true
}

resource "local_file" "kubeconfig" {
  content  = kind_cluster.default.kubeconfig
  filename = local.kubeconfig_path
}

resource "null_resource" "store-admin-password" {
  depends_on = [kind_cluster.default]

  provisioner "local-exec" {
    command = "kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d > tmp/default-admin-password.txt"
    }
}

resource "null_resource" "remove-admin-password" {
  depends_on = [null_resource.store-admin-password]

  provisioner "local-exec" {
    command = "kubectl -n argocd delete secret argocd-initial-admin-secret"
  }
}


