locals {
  name = "${var.project}-${var.purpose}-${var.env}"
}

resource "aws_codebuild_project" "example" {
  name          = local.name
  description   = "Code Build Project for ${local.name}"
  build_timeout = "5"
  service_role  = module.iam-role-codebuild.arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  cache {
    type     = "S3"
    location = module.s3.id
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:1.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"

    environment_variable {
      name  = "SOME_KEY1"
      value = "SOME_VALUE1"
    }

    environment_variable {
      name  = "SOME_KEY2"
      value = "SOME_VALUE2"
      type  = "PARAMETER_STORE"
    }
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "log-group"
      stream_name = "log-stream"
    }

    s3_logs {
      status   = "ENABLED"
      location = "${module.s3.id}/build-log"
    }
  }

  source {
    type            = "GITHUB"
    location        = "https://github.com/von-salumbides/aws-codebuild.git"
    git_clone_depth = 1

    git_submodules_config {
      fetch_submodules = true
    }
  }

  source_version = "dev"

  tags = {
    Name = local.name
  }
}