terraform {
  required_version = ">= 1.0"
  required_providers {   
    helm = {
      source  = "hashicorp/helm"
      version = "2.14.0"
    }
    kind = {
        source = "tehcyx/kind"
        version = "0.5.1"
    }
    kubectl = {
      source  = "alekc/kubectl"
      version = "2.0.4"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.31.0"
    }
    local = {
        source  = "hashicorp/local"
        version = "2.5.1"
    }
    null = {
        source  = "hashicorp/null"
        version = "3.2.2"
    } 
  }
}

provider "helm" {
  kubernetes {
    config_path = local_file.kubeconfig.filename
  }
}

provider "kind" {}

provider "kubernetes" {
    config_path = local_file.kubeconfig.filename
}

provider local {}