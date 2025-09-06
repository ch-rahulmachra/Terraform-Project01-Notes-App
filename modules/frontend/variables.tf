variable "env" {
  type        = string
  description = "Environment (dev/prod)"
}

variable "region" {
  type        = string
}

variable "bucket_name" {
  type        = string
  description = "S3 bucket name for frontend hosting"
}