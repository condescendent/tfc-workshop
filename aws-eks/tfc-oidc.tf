# Data source used to grab the TLS certificate for Terraform Cloud.
#
# https://registry.terraform.io/providers/hashicorp/tls/latest/docs/data-sources/certificate
data "tls_certificate" "tfc_certificate" {
  url = "https://${var.tfc_hostname}"
}

# This data source can be used to fetch information about a specific IAM OpenID Connect provider. 
# By using this data source, you can retrieve the the resource information by either its arn or url.
data "aws_iam_openid_connect_provider" "example" {
  arn = "arn:aws:iam::194639014949:oidc-provider/app.terraform.io"
}

data "aws_iam_role" "tfc-role" {
  name = "tfc-role"
}
# Creates a role which can only be used by the specified Terraform
# cloud workspace.
#
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role
#resource "aws_iam_role" "tfc_role" {
#  name = "tfc-role"
#
#  assume_role_policy = <<EOF
#{
# "Version": "2012-10-17",
# "Statement": [
#   {
#     "Effect": "Allow",
#     "Principal": {
#       "Federated": "${aws_iam_openid_connect_provider.tfc_provider.arn}"
#     },
#     "Action": "sts:AssumeRoleWithWebIdentity",
#     "Condition": {
#       "StringEquals": {
#         "${var.tfc_hostname}:aud": "${one(aws_iam_openid_connect_provider.tfc_provider.client_id_list)}"
#       },
#       "StringLike": {
#         "${var.tfc_hostname}:sub": "organization:${var.tfc_organization_name}:project:${var.tfc_project_name}:workspace:${var.tfc_workspace_name}:run_phase:*"
#       }
#     }
#   }
# ]
#}
#EOF
#}
#
# Creates a policy that will be used to define the permissions that
# the previously created role has within AWS.
#
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy
data "aws_iam_policy" "AdministratorAccess" {
  arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}



## Creates an attachment to associate the above policy with the
## previously created role.
##
## https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment
#resource "aws_iam_role_policy_attachment" "tfc_policy_attachment" {
#  role       = aws_iam_role.tfc_role.name
#  policy_arn = data.aws_iam_policy.AdministratorAccess.arn
#}
