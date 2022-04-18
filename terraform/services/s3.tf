module "s3" {
  source        = "git::https://github.com/von-salumbides/terraform-module.git//aws-s3-bucket"
  project       = var.project
  env           = var.env
  force_destroy = true
  purpose       = "main"
}