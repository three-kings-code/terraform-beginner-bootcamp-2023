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

#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object
resource "aws_s3_object" "website_css" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "styles.css"
  source = "${var.website_root_filepath}${var.project_folder}/styles.css"
  content_type = "text/css"
  etag = filemd5("${var.website_root_filepath}${var.project_folder}/styles.css")
  
  lifecycle {
    replace_triggered_by = [terraform_data.content_version]
    ignore_changes = [etag]
  }
}

resource "aws_s3_object" "website_htmls" {
  for_each = fileset("${var.website_root_filepath}${var.project_folder}/", "*.{html}")
  bucket   = aws_s3_bucket.website_bucket.bucket
  key      = each.key
  source   = "${var.website_root_filepath}${var.project_folder}/${each.key}"
  content_type = "text/html"
  etag = filemd5("${var.website_root_filepath}${var.project_folder}/${each.key}")

  lifecycle {
    replace_triggered_by = [terraform_data.content_version]
    ignore_changes = [etag]
  }
}

resource "aws_s3_object" "upload_assets" {
  for_each = fileset("${var.website_root_filepath}${var.project_folder}/assets/", "*.{jpg,png,gif}")
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "assets/${each.key}"
  source = "${var.website_root_filepath}${var.project_folder}/assets/${each.key}"
  #content_type = "text/html"
  etag = filemd5("${var.website_root_filepath}${var.project_folder}/assets/${each.key}")
}

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
