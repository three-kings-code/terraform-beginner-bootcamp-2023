variable "user_uuid" {
    description = "The UUID of the user"
    type = string

    validation {
    condition = can(regex("^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$", var.user_uuid))
    error_message = "The User Uuid must be in the following format 'e1e8b77c-7035-41e4-9388-326d91622433'"
    }
}

variable "bucket_name" {
  type        = string
  description = "The name of the AWS S3 bucket."

  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9.-]{1,61}[a-z0-9]$", var.bucket_name))
    error_message = "Invalid S3 bucket name. The name must be lowercase, between 3 and 63 characters, and can only contain lowercase letters, numbers, hyphens, and periods. It cannot start or end with a hyphen or period."
  }
}

variable "index_html_filepath" {
  type        = string
  description = "Filepath to the index.html file"

  validation {
    condition     = fileexists(var.index_html_filepath)
    error_message = "The specified index_html_filepath does not exist."
  }
}

variable "error_html_filepath" {
  type        = string
  description = "Filepath to the error.html file"

  validation {
    condition     = fileexists(var.error_html_filepath)
    error_message = "The specified error_html_filepath does not exist."
  }
}