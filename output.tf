output "bucket_name_output" {
  description = "S3 storage bucket for static website"
  value = module.terrahouse_aws.bucket_name
}

output "website_endpoint_output" {
  description = "S3 Static website URL"
  value = module.terrahouse_aws.website_endpoint
}

output "cloudfront_url" {
  description = "This will be the url that we need to use to access the website"
  value = module.terrahouse_aws.cloudfront_url
}