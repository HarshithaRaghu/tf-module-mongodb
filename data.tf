# Fetches the information of the remote statefile, here in our case, this will fetch the information of the VPC Statefile
data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
        bucket = "b52-terraform-state-bucket"
        key    = "vpc/${var.ENV}/terraform.tfstate"
        region = "us-east-1"
  }
}