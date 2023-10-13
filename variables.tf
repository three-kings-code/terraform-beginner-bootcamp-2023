variable "teacherseat_user_uuid" {
    description = "The UUID of the user"
    type = string
}

variable "website_root_filepath" {
  type        = string
  description = "Filepath to the html files"
}

variable "terratowns_endpoint" {
  type = string
  description = "This is the api endpoint for terratowns to deploy our page"
}

variable "terratowns_access_token" {
  type = string
  description = "This is the api access token for terratowns to deploy our page"
}

variable "dizzy" {
  description = "This variable holds all the details of the project"
  type = object({
    project_folder = string
    content_version = number
  })
}

variable "recipes" {
  description = "This variable holds all the details of the project"
  type = object({
    project_folder = string
    content_version = number
  })
}