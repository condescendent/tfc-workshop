terraform {
  required_version = ">=1.9.8"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "=5.75.0"
    }
    controltower = {
      source  = "idealo/controltower"
      version = "~> 1.0"
    }
  }

  cloud {
    hostname     = "app.terraform.io"
    organization = "intangible-intelligence-corporation"
    workspaces {
      name = "aws-eks"
    }
  }
}