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
    index_html_filepath = var.index_html_filepath
    error_html_filepath = var.error_html_filepath
    content_version = var.content_version
    assets_path = var.assets_path
}