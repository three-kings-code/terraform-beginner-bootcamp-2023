variable "user_uuid" {
    description = "The UUID of the user"
    type = string
}

variable "bucket_name" {
  type        = string
  description = "The name of the AWS S3 bucket."
}

variable "index_html_filepath" {
  type        = string
  description = "Filepath to the index.html file"
}

variable "error_html_filepath" {
  type        = string
  description = "Filepath to the error.html file"
}