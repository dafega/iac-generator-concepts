resource "aws_secretsmanager_secret" "app" {
  name = "${var.name_prefix}/${var.env}/app"
}

