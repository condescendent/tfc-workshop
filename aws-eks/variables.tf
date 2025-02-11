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
