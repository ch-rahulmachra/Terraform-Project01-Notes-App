variable "env" {
  type        = string
  description = "Environment"
}

variable "lambda_role_arn" {
  type        = string
  description = "IAM role ARN for Lambda execution"
}

variable "functions" {
  type        = map(string)
  description = "Map of Lambda functions names to their handler filenames"
}

variable "api_gateway_execution_arn" {}