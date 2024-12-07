variable "wordpress_version" {
  description = "Version of WordPress to install"
  type        = string
  default     = "latest"
}

variable "apache_version" {
  description = "Version of Apache to install"
  type        = string
  default     = "2.4"
}