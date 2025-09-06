variable "env" {
  type        = string
  description = "Environment name (dev, prod, etc.)"
}

variable "lambda_functions" {
  type        = map(string)
  description = "Map of Lambda function ARNs with keys as method names"
}

variable "region" {
  type = string
  default = "ap-south-1"
}