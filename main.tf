terraform {
# cloud {
#     organization = "three-kings"
#     workspaces {
#       name = "terra-house-three-kings"
#     }
#   }
  required_providers {
    # aws = {
    #   source = "hashicorp/aws"
    #   version = "5.19.0"
    #  }
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
     }
   }

}

# provider "aws" {
#   # Configuration options
# }

provider "terratowns" {
  endpoint = "http://localhost:4567/api"
  user_uuid="e328f4ab-b99f-421c-84c9-4ccea042c7d1" 
  token="9b49b3fb-b8e9-483c-b703-97ba88eef8e0"
}


# module "terrahouse_aws" {
#     source = "./modules/terrahouse_aws"
#     user_uuid = var.user_uuid
#     bucket_name = var.bucket_name
#     index_html_filepath = var.index_html_filepath
#     error_html_filepath = var.error_html_filepath
#     content_version = var.content_version
#     assets_path = var.assets_path
# }

resource "terratowns_home" "Dizzy" {
  name = "Dizzy the Egg Fan Site"
  # domain_name = module.terrahouse_aws.cloudfront_url
  domain_name = "34asda32.cloudfront.net"
  description = "This site is a fan site which talks about the game where the main character is Dizzy and he has friends that help him along the way"
  town = "gamers-grotto"
  content_version = 1
}