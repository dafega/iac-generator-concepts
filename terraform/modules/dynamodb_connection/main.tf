resource "aws_ssm_parameter" "dynamodb_table_name" {
  name  = "/iac/${var.env}/dynamodb/table_name"
  type  = "String"
  value = var.table_name
}
