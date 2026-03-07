resource "aws_codestarconnections_connection" "github" {
  name          = "${var.app_name}-github"
  provider_type = "GitHub"
}

resource "aws_codebuild_project" "app_build" {
  name         = "${var.app_name}-build"
  service_role = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = "aws/codebuild/standard:7.0"
    type            = "LINUX_CONTAINER"
    privileged_mode = true

    environment_variable {
      name  = "ECR_URI"
      value = aws_ecr_repository.app.repository_url
    }

    environment_variable {
      name  = "AWS_REGION"
      value = var.aws_region
    }
  }

  source {
    type = "CODEPIPELINE"
  }
}

resource "aws_codepipeline" "app_pipeline" {
  name     = "${var.app_name}-pipeline"
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    location = aws_s3_bucket.pipeline_artifacts.bucket
    type     = "S3"
  }

  stage {
    name = "Source"
    action {
      name             = "GitHub_Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        ConnectionArn    = aws_codestarconnections_connection.github.arn
        FullRepositoryId = "${var.github_owner}/${var.github_repo}"
        BranchName       = var.github_branch
      }
    }
  }

  stage {
    name = "Build"
    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]

      configuration = {
        ProjectName = aws_codebuild_project.app_build.name
      }
    }
  }
}
```

---

**`.gitignore`** (at root level, not inside terraform folder)
```
.terraform/
terraform.tfstate
terraform.tfstate.backup
terraform.exe
*.tfvars
