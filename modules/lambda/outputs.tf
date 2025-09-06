output "lambda_function_names" {
  value = [for f in aws_lambda_function.notes : f.function_name]
}

output "lambda_function_arns" {
  value = [for f in aws_lambda_function.notes : f.arn]
}