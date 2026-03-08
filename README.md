AWS CI/CD Pipeline with Terraform

Project structure
```
aws-cicd-terraform/
├── terraform/
│   ├── main.tf            
│   ├── variables.tf       
│   ├── iam.tf             
│   ├── ecr.tf             
│   ├── ec2.tf             
│   └── codepipeline.tf    
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
