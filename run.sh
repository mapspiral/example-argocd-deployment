declare -x KUBECONFIG="$(pwd)/tmp/kubeconfig"

terraform init -upgrade && terraform apply -auto-approve

kubectl port-forward svc/argocd-server -n argocd 8080:443

