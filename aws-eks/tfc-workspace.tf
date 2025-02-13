provider "tfe" {
  hostname = var.tfc_hostname
}

# Data source used to grab the project under which a workspace will be created.
#
# https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/data-sources/project
#data "tfe_project" "tfc_project" {
#  name         = var.tfc_project_name
#  organization = var.tfc_organization_name
#}


data "tfe_workspace" "aws-eks_workspace" {
  name         = var.tfc_workspace_name
  organization = var.tfc_organization_name
}

# The following variables must be set to allow runs
# to authenticate to AWS.
#
# https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable
resource "tfe_variable" "enable_aws_provider_auth" {
  #workspace_id = data.tfe_workspace.aws-eks_workspace.id
  workspace_id = "ws-YAhd1AZJU1si6J9j"
  key      = "TFC_AWS_PROVIDER_AUTH"
  value    = "true"
  category = "env"
  description = "Enable the Workload Identity integration for AWS."
  sensitive = false
}

#resource "tfe_variable" "tfc_aws_role_arn" {
#  workspace_id = data.tfe_workspace.aws-eks_workspace.id
#  key      = "TFC_AWS_RUN_ROLE_ARN"
#  #value    = aws_iam_role.tfc_role.arn
#  value    = data.aws_iam_role.tfc-role.arn
#  category = "env"
#
#  description = "The AWS role arn runs will use to authenticate."
#}