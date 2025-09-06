resource "aws_api_gateway_rest_api" "notes_api" {
  name        = "${var.env}-notes-api"
  description = "API Gateway for Notes App"
}

data "aws_api_gateway_resource" "root" {
  rest_api_id = aws_api_gateway_rest_api.notes_api.id
  path        = "/"
}

resource "aws_api_gateway_resource" "api_resource" {
  for_each   = var.lambda_functions
  rest_api_id = aws_api_gateway_rest_api.notes_api.id
  parent_id   = data.aws_api_gateway_resource.root.id
  path_part   = each.key
}

resource "aws_api_gateway_method" "api_method" {
  for_each   = var.lambda_functions
  rest_api_id   = aws_api_gateway_rest_api.notes_api.id
  resource_id   = aws_api_gateway_resource.api_resource[each.key].id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda_integration" {
  for_each = var.lambda_functions

  rest_api_id = aws_api_gateway_rest_api.notes_api.id
  resource_id = aws_api_gateway_resource.api_resource[each.key].id
  http_method = aws_api_gateway_method.api_method[each.key].http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/${each.value}/invocations"
}

resource "aws_api_gateway_deployment" "api_deployment" {
  depends_on  = [aws_api_gateway_integration.lambda_integration]
  rest_api_id = aws_api_gateway_rest_api.notes_api.id
}

resource "aws_api_gateway_stage" "api_stage" {
  stage_name    = var.env
  rest_api_id   = aws_api_gateway_rest_api.notes_api.id
  deployment_id = aws_api_gateway_deployment.api_deployment.id
}