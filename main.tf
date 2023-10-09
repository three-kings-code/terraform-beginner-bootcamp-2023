terraform {
# cloud {
#     organization = "three-kings"
#     workspaces {
#       name = "terra-house-three-kings"
#     }
#   }
#   required_providers {
#     aws = {
#       source = "hashicorp/aws"
#       version = "5.19.0"
#     }
#   }
}

# provider "aws" {
#   # Configuration options
# }

module "terrahouse_aws" {
    source = "./modules/terrahouse_aws"
    user_uuid = var.user_uuid
    bucket_name = var.bucket_name
}