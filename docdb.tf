# This block provisions document db on aws 

resource "aws_docdb_cluster" "docdb" {
  cluster_identifier      = "roboshop-docdb-${var.ENV"
  engine                  = "docdb"
  master_username         = "foo"
  master_password         = "mustbeeightchars"
  backup_retention_period = 5
  preferred_backup_window = "07:00-09:00"
  skip_final_snapshot     = true
}