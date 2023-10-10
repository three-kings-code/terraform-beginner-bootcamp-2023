output "bucket_name" {
  value = aws_s3_bucket.website_bucket.bucket
  description = "S3 storage bucket for static website"
}

output "website_endpoint" {
  description = "S3 Static website URL"
  value = aws_s3_bucket_website_configuration.website_config.website_endpoint
}