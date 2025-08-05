terraform {
  required_providers {

    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.17.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.35.1"
    }
    aws = {
      source  = "hashicorp/aws"
      #version = ">= 5.95.0, < 6.0.0"
      version = ">= 5.95.0"
    }
    datadog = {
      source  = "datadog/datadog"
      version = "~> 3.49.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.6.3"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0.5"
    }

    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "~> 2.3.5"
    }
  }
  cloud {
    hostname     = "app.terraform.io"
    organization = "intangible-intelligence-corporation"
    workspaces {
      name = "aws-eks"
    }
  }
  required_version = "~> 1.10"
}

