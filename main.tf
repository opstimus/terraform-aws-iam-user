resource "aws_iam_user" "main" {
  name = "${var.project}-${var.environment}-${var.name}"
  tags = var.tags
}

resource "aws_iam_user_policy" "main" {
  name   = "${var.project}-${var.environment}-${var.name}"
  user   = aws_iam_user.main.name
  policy = var.user_policy
}

resource "aws_iam_access_key" "main" {
  user = aws_iam_user.main.name
}

resource "aws_secretsmanager_secret" "access_key" {
  name = "${var.project}-${var.environment}-${var.name}-iam-access-key"
  tags = var.tags
}

resource "aws_secretsmanager_secret_version" "access_key" {
  secret_id     = aws_secretsmanager_secret.access_key.id
  secret_string = aws_iam_access_key.main.id
}

resource "aws_secretsmanager_secret" "secret_key" {
  name = "${var.project}-${var.environment}-${var.name}-iam-secret-key"
  tags = var.tags
}

resource "aws_secretsmanager_secret_version" "secret_key" {
  secret_id     = aws_secretsmanager_secret.secret_key.id
  secret_string = aws_iam_access_key.main.secret
}
