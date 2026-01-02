resource "aws_db_instance" "db" {
  allocated_storage = 20
  db_name = "dbwordpress"
  engine = "mysql"
  engine_version = "8.0"
  instance_class = "db.t3.micro"
  username = "admin"
  password = random_password.db_password.result
  skip_final_snapshot = true
  db_subnet_group_name = aws_db_subnet_group.db_subnet.name
  multi_az = false
  vpc_security_group_ids = [module.rds_sg.sg_id]
  backup_retention_period = 0
}