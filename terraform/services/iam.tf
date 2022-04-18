module "iam-role-codebuild" {
  source  = "git::https://github.com/von-salumbides/terraform-module.git//aws-iam-role"
  project = var.project
  env     = var.env
  purpose = "codebuild"
  config  = "trust_services"
}

module "codebuild-policy" {
  source      = "git::https://github.com/von-salumbides/terraform-module.git//aws-iam-policy"
  project     = var.project
  env         = var.env
  aws_service = "codebuild"
  aws_account = var.aws_account
  aws_region  = var.region
  iam_role    = [module.iam-role-codebuild.name]
}