resource "aws_dynamodb_table" "notes" {
  name = "${terraform.workspace}-notes-table"

  hash_key = "noteId"

  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "noteId"
    type = "S"
  }

  tags = {
    Project        = "Notes-App"
    Environment = "${terraform.workspace}"
  }
}