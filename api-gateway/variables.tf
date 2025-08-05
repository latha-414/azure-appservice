# variables.tf
variable "client_id" {
  type = string
}

variable "client_secret" {
  type = string
}

variable "tenant_id" {
  type = string
}

variable "subscription_id" {
  type = string
}

variable "location" {
  type    = string
  default = "East US"
}

variable "publisher_email" {
  type    = string
  default = "admin@example.com"
}
