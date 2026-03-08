AWS CI/CD Pipeline with Terraform

Project structure
```
aws-cicd-terraform/
├── terraform/
│   ├── main.tf            # AWS provider and S3 bucket
│   ├── variables.tf       # Variables like region, app name, GitHub info
│   ├── iam.tf             # Roles for CodeBuild and CodePipeline
│   ├── ecr.tf             # Docker image registry
│   ├── ec2.tf             # Server and security groups
│   └── codepipeline.tf    # The actual pipeline and build project
├── Dockerfile
├── buildspec.yml
└── README.md
```

Deploy

cd aws-cicd-terraform/terraform

terraform init

terraform apply \
  -var="github_owner=YOUR_USERNAME" \
  -var="github_repo=aws-cicd-terraform" \
  -var="github_token=YOUR_TOKEN"
