variable "aws_region" {
  default = "eu-west-1"
}

variable "app_name" {
  default = "my-cicd-app"
}

variable "github_owner" {
  description = "Your GitHub username"
}

variable "github_repo" {
  description = "Your GitHub repo name"
}

variable "github_branch" {
  default = "main"
}

variable "github_token" {
  description = "GitHub personal access token"
  sensitive   = true
}
