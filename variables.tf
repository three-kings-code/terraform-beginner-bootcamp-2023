variable "teacherseat_user_uuid" {
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

variable "htmls_filepath" {
  type        = string
  description = "Filepath to the html files"
}

variable "error_html_filepath" {
  type        = string
  description = "Filepath to the error.html file"
}

variable "content_version" {
  type        = number
  description = "Content version (positive integer starting at 1)"
}

variable "assets_path" {
  type = string
  description = "Path to the 'assets' folder"
}

variable "terratowns_endpoint" {
  type = string
  description = "This is the api endpoint for terratowns to deploy our page"
}

variable "terratowns_access_token" {
  type = string
  description = "This is the api access token for terratowns to deploy our page"
}