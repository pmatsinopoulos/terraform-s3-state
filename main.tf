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

resource "aws_instance" "app_server" {
  ami           = "ami-00785f4835c6acf64"
  instance_type = "t2.micro"

  tags = {
    Name        = "MyFantasticInstance",
    environment = "learning"
  }
}
