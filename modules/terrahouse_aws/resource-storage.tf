# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
resource "aws_s3_bucket" "website_bucket" {
  # https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html?icmpid=docs_amazons3_console
  bucket = var.bucket_name
  tags = {
    UserUuid    = var.user_uuid
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_website_configuration
resource "aws_s3_bucket_website_configuration" "website_config" {
  bucket = aws_s3_bucket.website_bucket.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object
# resource "aws_s3_object" "website_index" {
#   bucket = aws_s3_bucket.website_bucket.bucket
#   key    = "index.html"
#   source = var.index_html_filepath
#   content_type = "text/html"
#   etag = filemd5(var.index_html_filepath)
  
#   lifecycle {
#     replace_triggered_by = [terraform_data.content_version]
#     ignore_changes = [etag]
#   }
# }

#var.html_path = "/workspace/terraform-beginner-bootcamp-2023/public/"
resource "aws_s3_object" "website_htmls" {
  for_each = fileset(var.htmls_filepath, "*.{html,css}")
  bucket   = aws_s3_bucket.website_bucket.bucket
  key      = each.key
  source   = "${var.htmls_filepath}${each.key}"
  content_type = "text/html"
  etag = filemd5("${var.htmls_filepath}${each.key}")

  lifecycle {
    replace_triggered_by = [terraform_data.content_version]
    ignore_changes = [etag]
  }
}

resource "aws_s3_object" "upload_assets" {
  for_each = fileset(var.assets_path, "*.{jpg,png,gif}")
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "assets/${each.key}"
  source = "${var.assets_path}${each.key}"
  #content_type = "text/html"
  etag = filemd5("${var.assets_path}${each.key}")
}

# resource "aws_s3_object" "website_error" {
#   bucket = aws_s3_bucket.website_bucket.bucket
#   key    = "error.html"
#   source = var.error_html_filepath
#   content_type = "text/html"
#   etag = filemd5(var.error_html_filepath)
# }

resource "aws_s3_bucket_policy" "website_bucket_policy" {
  bucket = aws_s3_bucket.website_bucket.bucket
  policy = jsonencode({
    "Version" = "2012-10-17",
    "Statement" = [
        {
            "Sid" = "AllowCloudFrontServicePrincipalReadOnly",
            "Effect" = "Allow",
            "Principal" = {
                "Service" = "cloudfront.amazonaws.com"
            },
            "Action" = "s3:GetObject",
            "Resource" = "arn:aws:s3:::${aws_s3_bucket.website_bucket.id}/*",
            "Condition" = {
                "StringEquals" = {
                    "AWS:SourceArn" = "arn:aws:cloudfront::${data.aws_caller_identity.current.account_id}:distribution/${aws_cloudfront_distribution.s3_distribution.id}"
                }
            }
        }
    ]
})
}

resource "terraform_data" "content_version" {
  input = var.content_version
}
