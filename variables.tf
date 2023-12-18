variable "connection_uri" {}

variable "username" {}

variable "password" {}

variable "path" {}

variable "default_lease_ttl_seconds" {
  default = null
}
variable "max_lease_ttl_seconds" {
  default = null
}

variable "roles" {
  type = map(object({
    name    = optional(string)
    tags    = optional(string)
    vhosts = optional(map(object({
      configure = string
      read      = string
      write     = string
    })), {})
  }))
  default = {}
  nullable = false
}