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

## How to run it yourself

You'll need Terraform installed, AWS CLI configured, and a GitHub token.
```bash
# Clone the repo
git clone https://github.com/YOUR_USERNAME/aws-cicd-terraform.git
cd aws-cicd-terraform/terraform

# Init and deploy
terraform init

terraform apply \
  -var="github_owner=YOUR_USERNAME" \
  -var="github_repo=aws-cicd-terraform" \
  -var="github_token=YOUR_TOKEN"
```

After apply finishes, go to **AWS Console → CodePipeline → Settings → Connections** 
and authorize the GitHub connection. That step has to be done manually in the console.

## Cleaning up

To avoid charges when you're done:
```bash
terraform destroy \
  -var="github_owner=YOUR_USERNAME" \
  -var="github_repo=aws-cicd-terraform" \
  -var="github_token=YOUR_TOKEN"
```

## What I learned

- How to structure Terraform files across multiple resources
- How IAM roles and trust policies work between AWS services
- The difference between CodePipeline, CodeBuild, and CodeDeploy
- How CodeStar Connections replaced the old GitHub OAuth token method
- Debugging AWS permission errors (there were a few!)

## Notes

This runs within the AWS free tier. The EC2 instance is a t2.micro and CodeBuild 
uses the smallest compute type. Just make sure to run terraform destroy when 
you're not actively using it.
