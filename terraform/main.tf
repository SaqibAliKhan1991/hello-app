provider "aws" {
  region = "eu-central-1"
}

resource "aws_eks_cluster" "hello" {
  name = "hello-cluster"
  role_arn = "REPLACE_ME"
}

