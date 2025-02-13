variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_name" {
  type = string
  default = "eks_vpc"
}
variable "eks_cluster_version" {
  type = string
  default = "1.26"
}


# TFC workspace variables:
variable "tfc_aws_audience" {
  description = "The audience value to use in run identity tokens"
  type        = string
  default     = "aws.workload.identity"
}


variable "tfc_hostname" {
  description = "The hostname of the TFC or TFE instance you'd like to use with AWS"
  type        = string
  default     = "app.terraform.io"
}

variable "tfc_organization_name" {
  description = "The name of your Terraform Cloud organization"
  type        = string
  default     = "intangible-intelligence-corporation"
}


variable "tfc_project_name" {
  description = "The project under which a workspace will be created"
  type        = string
  default     = "Intangible-Intelligence-Infrastructure"
}

variable "tfc_workspace_name" {
  description = "The name of the workspace that you'd like to create and connect to AWS"
  type        = string
  default     = "aws-eks"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to add to all resources"
  default     = {}
}

