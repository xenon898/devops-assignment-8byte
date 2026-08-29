resource "aws_db_subnet_group" "postgres" {
  name = "${local.project_name}-db-subnet-group"

  subnet_ids = [
    aws_subnet.private_1.id,
    aws_subnet.private_2.id
  ]

  tags = {
    Name        = "${local.project_name}-db-subnet-group"
    Environment = local.environment
  }
}

resource "aws_db_instance" "postgres" {
  identifier = "${local.project_name}-postgres"

  engine         = "postgres"
  engine_version = "16"

  instance_class        = "db.t3.micro"
  allocated_storage     = 20
  max_allocated_storage = 50
  storage_type          = "gp3"
  storage_encrypted     = true

  db_name  = "assignmentdb"
  username = "appuser"
  password = var.db_password
  port     = 5432

  db_subnet_group_name = aws_db_subnet_group.postgres.name
  vpc_security_group_ids = [
    aws_security_group.rds.id
  ]

  publicly_accessible     = false
  multi_az                = false
  backup_retention_period = 1
  backup_window           = "03:00-04:00"
  maintenance_window      = "sun:04:00-sun:05:00"

  skip_final_snapshot = true
  deletion_protection = false

  tags = {
    Name        = "${local.project_name}-postgres"
    Environment = local.environment
  }
}