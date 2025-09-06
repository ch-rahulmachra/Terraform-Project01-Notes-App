output "api_invoke_url" {
  value = "https://${aws_api_gateway_rest_api.notes_api.id}.execute-api.${var.region}.amazonaws.com/${aws_api_gateway_stage.api_stage.stage_name}"
}

output "notes_api_execution_arn" {
  value = aws_api_gateway_rest_api.notes_api.execution_arn
}