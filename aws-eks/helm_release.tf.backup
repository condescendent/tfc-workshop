#provider "helm" {
#  kubernetes {
#    host                   = module.eks.cluster_endpoint
#    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
#    #token                  = data.aws_eks_cluster_auth.cluster.token
#    exec = {
#      api_version = "client.authentication.k8s.io/v1beta1"
#      command     = "aws"
#      # This requires the awscli to be installed locally where Terraform is executed
#      args = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
#    }
#  }
#}


provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)

    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"
      # This requires AWS CLI to be installed where Terraform runs
      args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
    }
  }
}

resource "helm_release" "karpenter" {
  #name       = "karpenter"
  #repository = "https://charts.karpenter.sh"
  #chart      = "karpenter"
  #namespace  = "karpenter"
  #version    = "0.16.3" # Match this to latest stable if needed
  #create_namespace = true

  #values = [
  #  yamlencode({
  #    serviceAccount = {
  #      name = "karpenter"
  #      annotations = {
  #        "eks.amazonaws.com/role-arn" = module.karpenter.iam_role_arn
  #      }
  #    }
#
  #    settings = {
  #      clusterName    = module.eks.cluster_name
  #      clusterEndpoint = module.eks.cluster_endpoint
  #      aws = {
  #        #defaultInstanceProfile = module.karpenter.karpenter_node_instance_profile_name
  #        defaultInstanceProfile = module.karpenter.instance_profile_name # based on the latest terraform-aws-modules/eks version, this attibute is avaible. 
  #      }
  #    }
  #  })
  #]
  #values = [
  #  <<-EOT
  #  nodeSelector:
  #    karpenter.sh/controller: 'true'
  #  dnsPolicy: Default
  #  settings:
  #    clusterName: ${module.eks.cluster_name}
  #    clusterEndpoint: ${module.eks.cluster_endpoint}
  #    interruptionQueue: ${module.karpenter.queue_name}
  #  webhook:
  #    enabled: false
  #  EOT
  #]

  # namespace           = "kube-system"
  namespace           = "karpenter"
  name                = "karpenter"
  repository          = "oci://public.ecr.aws/karpenter"
  create_namespace    = true
  repository_username = data.aws_ecrpublic_authorization_token.token.user_name
  repository_password = data.aws_ecrpublic_authorization_token.token.password
  chart               = "karpenter"
  version             = "1.6.0"
  wait                = false

  #set {
  #  name  = "crds.create"
  #  value = "true"
  #}
  #set {
  #  name  = "settings.clusterName"
  #  value = var.cluster_name
  #}
  #set {
  #  name  = "settings.interruptionQueueName"
  #  value = aws_sqs_queue.karpenter.name
  #}


  values = [
    <<-EOT
    dnsPolicy: Default
    settings:
      clusterName: ${module.eks.cluster_name}
      clusterEndpoint: ${module.eks.cluster_endpoint}
      interruptionQueue: ${module.karpenter.queue_name}
    webhook:
      enabled: false
    EOT
  ]
}
