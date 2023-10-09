variable "user_uuid" {
    description = "The UUID of the user"
    type = string

    validation {
    condition = can(regex("^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$", var.user_uuid))
    error_message = "The User Uuid must be in the following format 'e1e8b77c-7035-41e4-9388-326d91622433'"
    }
}



