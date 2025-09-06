provider "aws" {
  region = var.region
}

#----------------------------------------------------------
#Root module for dynamo db table
module "dynamodb" {
  source = "./modules/dynamodb"
}
#Outputs for dynamo db table
output "dynamodb_table_name" {
  value = module.dynamodb.table_name
}
output "dynamodb_table_arn" {
  value = module.dynamodb.table_arn
}

#----------------------------------------------------------
#Iam role for lambda -> DynamoDb table and cloudWatch Logs
module "iam" {
  source            = "./modules/iam"
  env               = terraform.workspace
  dynamodb_table_arn = module.dynamodb.table_arn
}

#----------------------------------------------------------
#Lambda functions
module "lambda" {
  source = "./modules/lambda"
  env    = terraform.workspace
  lambda_role_arn = module.iam.lambda_exec_role_arn
  api_gateway_execution_arn = module.api_gateway.notes_api_execution_arn
  functions = {
    create = "createNote/index.handler"
    get    = "getNote/index.handler"
    update = "updateNote/index.handler"
    delete = "deleteNote/index.handler"
  }
}

#----------------------------------------------------------
#Api Gateway
module "api_gateway" {
  source = "./modules/apiGateway"
  env    = terraform.workspace
  lambda_functions = {
    create = module.lambda.lambda_function_arns[0]
    get    = module.lambda.lambda_function_arns[1]
    update = module.lambda.lambda_function_arns[2]
    delete = module.lambda.lambda_function_arns[3]
  }
}

#----------------------------------------------------------
#Frontend (S3)
module "frontend" {
  source      = "./modules/frontend"
  env         = terraform.workspace
  region      = var.region
  bucket_name = "${terraform.workspace}-notes-frontend"
}