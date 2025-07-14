# Task -2 ( you can run the time-ip-app online)

# Infrastructure Setup Using Terraform (AWS ECS Fargate + ALB)

# prerequisites:
# terraform version >= 1.6.6 — https://developer.hashicorp.com/terraform/downloads
# aws cli installed and configured — https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html

# required AWS permissions for your IAM user (can also give AdministratorFullAccess) or give selected policies:
# AmazonEC2FullAccess  
# AmazonECS_FullAccess  
# IAMFullAccess  
# AmazonS3FullAccess  
# CloudWatchLogsFullAccess  
# ElasticLoadBalancingFullAccess  
# AmazonVPCFullAccess  

# steps to deploy:

cd terraform                  # go to terraform folder
terraform init               # initialize terraform (already initialised-can be skipped)
terraform plan               # show what will be created
terraform apply              # create infrastructure and deploy app

# after apply finishes, copy the alb_dns_name output and open in browser:
# example: http://ecs-alb-xxxxxxxxx.us-east-1.elb.amazonaws.com

# expected JSON response:
{
  "timestamp": "<current time>",
  "ip": "<your public IP>"
}

---

# terraform will create:

✅ VPC with public + private subnets  
→ `vpc.tf`  
→ Module: https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/6.0.1  
→ Config ref: https://github.com/terraform-aws-modules/terraform-aws-vpc/blob/master/examples/complete/main.tf

✅ Application Load Balancer (ALB) in public subnets  
→ `alb.tf`  
→ `aws_lb`: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb  
→ `aws_lb_target_group`: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group  
→ `aws_lb_listener`: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener  
→ `aws_security_group`: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group  

✅ ECS Cluster and Fargate service  
→ `ecs_cluster_task_service.tf`  
→ `aws_ecs_cluster`: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster  
→ `aws_ecs_task_definition`: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition  
→ `aws_ecs_service`: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service  
→ `aws_security_group`: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group  

✅ IAM Role for ECS task execution  
→ `iam.tf`  
→ `aws_iam_role`: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role  
→ `aws_iam_role_policy_attachment`: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment  

✅ Output variables  
→ `output.tf`  
→ Terraform output docs: https://developer.hashicorp.com/terraform/language/values/outputs   

✅ Terraform and AWS provider configuration  
→ `versions.tf`  
→ Terraform block reference: https://developer.hashicorp.com/terraform/language/settings  
→ AWS provider docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs  

✅ Docker image used for app  
→ https://hub.docker.com/r/mridulbadgurjar4/time-ip-image  
→ ECS pulls this image and runs container on port 3000  

---

# no secrets or credentials are committed to repo

# app is containerized and runs as non-root user (see Dockerfile inside `app/`)

# terraform plan and terraform apply are the only steps needed


