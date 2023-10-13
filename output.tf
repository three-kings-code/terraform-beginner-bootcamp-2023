output "dizzy_bucket_name_output" {
  description = "S3 storage bucket for static website"
  value = module.home_dizzy.bucket_name
}

output "dizzy_website_endpoint_output" {
  description = "S3 Static website URL"
  value = module.home_dizzy.website_endpoint
}

output "dizzy_cloudfront_url" {
  description = "This will be the url that we need to use to access the website"
  value = module.home_dizzy.cloudfront_url
}

output "recipes_bucket_name_output" {
  description = "S3 storage bucket for static website"
  value = module.home_recipes.bucket_name
}

output "recipes_website_endpoint_output" {
  description = "S3 Static website URL"
  value = module.home_recipes.website_endpoint
}

output "recipes_cloudfront_url" {
  description = "This will be the url that we need to use to access the website"
  value = module.home_recipes.cloudfront_url
}