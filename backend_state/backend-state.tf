terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "eu-west-2"
  profile = "me"
}

resource "aws_s3_bucket" "terraform_state_bucket" {
  bucket = "pmatsinopoulos-terraform-state-test"

  tags = {
    Name        = "PMatsinopoulos Terraform State Test"
    environment = "learning"
  }
}

resource "aws_s3_bucket_acl" "terraform_state_bucket_acl" {
  bucket = aws_s3_bucket.terraform_state_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "terraform_state_bucket_versioning" {
  bucket = aws_s3_bucket.terraform_state_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "terraform_state_lock_table" {
  name         = "pmatsinopoulos-terraform-test"
  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"
  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "PMatsinopoulos Terraform State Lock Table"
    environment = "learning"
  }
}
