provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    token                  = data.aws_eks_cluster_auth.cluster.token
  }
}

resource "helm_release" "karpenter" {
  name       = "karpenter"
  repository = "https://charts.karpenter.sh"
  chart      = "karpenter"
  namespace  = "karpenter"
  version    = "v0.36.1" # Match this to latest stable if needed
  create_namespace = true

  values = [
    yamlencode({
      serviceAccount = {
        name = "karpenter"
        annotations = {
          "eks.amazonaws.com/role-arn" = module.karpenter.iam_role_arn
        }
      }

      settings = {
        clusterName    = module.eks.cluster_name
        clusterEndpoint = module.eks.cluster_endpoint
        aws = {
          #defaultInstanceProfile = module.karpenter.karpenter_node_instance_profile_name
          defaultInstanceProfile = module.karpenter.instance_profile_name # based on the latest terraform-aws-modules/eks version, this attibute is avaible. 
        }
      }
    })
  ]
}
