terraform {
cloud {
    organization = "three-kings"
    workspaces {
      name = "terra-home-three-kings"
    }
  }
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
     }
   }

}

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid 
  token = var.terratowns_access_token
}

# #mock town
# provider "terratowns" {
#   endpoint = "http://localhost:4567/api"
#   user_uuid="e328f4ab-b99f-421c-84c9-4ccea042c7d1" 
#   token="9b49b3fb-b8e9-483c-b703-97ba88eef8e0"
# }


module "home_dizzy" {
    source = "./modules/terrahome_aws"
    user_uuid = var.teacherseat_user_uuid
    bucket_name = "${var.dizzy.project_folder}-three-kings"
    content_version = var.dizzy.content_version
    project_folder = var.dizzy.project_folder
    website_root_filepath = var.website_root_filepath
}

resource "terratowns_home" "dizzy" {
  name = "Dizzy the Egg Fan Site"
  domain_name = module.home_dizzy.cloudfront_url
  description = "This site is a fan site which talks about the game where the main character is Dizzy"# and he has friends that help him along the way"
  town = "gamers-grotto"
  content_version = var.dizzy.content_version
}

module "home_recipes" {
    source = "./modules/terrahome_aws"
    user_uuid = var.teacherseat_user_uuid
    bucket_name = "${var.recipes.project_folder}-three-kings"
    project_folder = var.recipes.project_folder
    content_version = var.recipes.content_version
    website_root_filepath = var.website_root_filepath
}

resource "terratowns_home" "recipes" {
  name = "Sticky Toffee Pudding Recipe"
  domain_name = module.home_recipes.cloudfront_url
  description = "I love Sticky toffee pudding and here is a recipe for making one"
  town = "cooker-cove"
  content_version = var.recipes.content_version
}