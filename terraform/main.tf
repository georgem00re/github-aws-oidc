
terraform {
  required_version = ">= 1.4.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.95.0"
    }
  }

  // Ordinarily, we would want to store the tfstate in an S3 bucket,
  // but for this example, we are using a local backend to keep things simple.
  backend "local" {
    path = "./terraform.tfstate"
  }
}

locals {
  oidc_role_name = "my-aws-iam-role"
}

provider "aws" {
  region = "eu-west-2"
  profile = "admin"
}

module "aws_iam_openid_connect_provider" {
  source = "./modules/aws_iam_openid_connect_provider"
}

module "aws_iam_policy_document" {
  source = "./modules/aws_iam_policy_document"
  openid_connect_provider_arn = module.aws_iam_openid_connect_provider.arn
}

module "aws_iam_role" {
  source = "./modules/aws_iam_role"
  name = local.oidc_role_name
  assume_role_policy = module.aws_iam_policy_document.json
}

// This will allow the GitHub repository full administrative access
// to the AWS account.
module "aws_iam_role_policy_attachment" {
  source     = "./modules/aws_iam_role_policy_attachment"
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  role_name  = module.aws_iam_role.name
}
