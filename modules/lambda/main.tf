resource "aws_lambda_function" "notes" {
  for_each = var.functions

  function_name = "${var.env}-${each.key}-lambda"
  handler       = each.value
  runtime       = "nodejs18.x"
  role          = var.lambda_role_arn
  filename      = "build/${each.value}.zip"

  source_code_hash = filebase64sha256("build/${each.value}.zip")

  environment {
    variables = {
      DYNAMODB_TABLE = var.env == "development" ? "${var.env}-notes-table" : "prod-notes-table"
    }
  }

  depends_on = [var.lambda_role_arn]
}

resource "aws_lambda_permission" "apigw_invoke" {
  for_each = var.functions

  statement_id  = "AllowAPIGatewayInvoke-${each.key}"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.notes[each.key].function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${var.api_gateway_execution_arn}/*/*"
}