resource "random_password" "db_password" {
  min_lower = 2
  min_upper = 2
  min_numeric = 3
  min_special = 2
  override_special = "!#$%^&*()_+-={}[]|:;<>,.?~`"
  length = 16
}

locals {
  ssm_param_name = "/lab24/rds/password"
}

resource "aws_ssm_parameter" "ssm_password" {
  name = local.ssm_param_name
  type = "SecureString"
  value = random_password.db_password.result
}