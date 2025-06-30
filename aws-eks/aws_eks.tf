module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.37.1"

  cluster_name    = local.cluster_name
  cluster_version = var.eks_cluster_version

  #cluster_endpoint_public_access           = true
  #enable_cluster_creator_admin_permissions = true

  #cluster_addons = {
  #    aws-ebs-csi-driver = {
  #    service_account_role_arn = module.irsa-ebs-csi.iam_role_arn
  #  }
  #}

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets  # use public subnet for production

  node_security_group_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = null
  }

  eks_managed_node_group_defaults = {
    #ami_type = "AL2_x86_64"
    #ami_type = "AL2023_x86_64_STANDARD"
    ami_type = "BOTTLEROCKET_x86_64"

    attach_cluster_primary_security_group = true

    # Disabling and using externally provided security groups
    create_security_group = false
  }

  #eks_managed_node_groups = {
  #  one = {
  #    name = "node-group-1"
#
  #    instance_types = ["t3.small"]
#
  #    min_size     = 1
  #    max_size     = 1
  #    desired_size = 1
#
  #    pre_bootstrap_user_data = <<-EOT
  #    echo 'foo bar'
  #    EOT
#
  #    vpc_security_group_ids = [
  #      aws_security_group.node_group_one.id
  #    ]
  #  }
#
    #two = {
    #  name = "node-group-2"
#
    #  instance_types = ["t2.medium"]
#
    #  min_size     = 1
    #  max_size     = 2
    #  desired_size = 1
#
    #  pre_bootstrap_user_data = <<-EOT
    #  echo 'foo bar'
    #  EOT
#
    #  vpc_security_group_ids = [
    #    aws_security_group.node_group_two.id
    #  ]
#    }
  }
}


#module "karpenter" {
#  source = "terraform-aws-modules/eks/aws//modules/karpenter"
#
#  cluster_name = module.eks.cluster_name
#
#  # Attach additional IAM policies to the Karpenter node IAM role
#  node_iam_role_additional_policies = {
#    AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
#  }
#
#  tags = {
#    Environment = "dev"
#    Terraform   = "true"
#  }
#}




# https://aws.amazon.com/blogs/containers/amazon-ebs-csi-driver-is-now-generally-available-in-amazon-eks-add-ons/ 
data "aws_iam_policy" "ebs_csi_policy" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
}

module "irsa-ebs-csi" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version = "5.39.0"

  create_role                   = true
  role_name                     = "AmazonEKSTFEBSCSIRole-${module.eks.cluster_name}"
  provider_url                  = module.eks.oidc_provider
  role_policy_arns              = [data.aws_iam_policy.ebs_csi_policy.arn]
  oidc_fully_qualified_subjects = ["system:serviceaccount:kube-system:ebs-csi-controller-sa"]
}
