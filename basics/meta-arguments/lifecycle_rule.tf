resource "aws_db_instance" "prod" {
  allocated_storage = 100
  engine            = "postgres"
  instance_class    = "db.t3.micro"

  lifecycle {
    prevent_destroy       = true
    create_before_destroy = true
    ignore_changes        = [allocated_storage]
  }
}

