resource "null_resource" "docdb-schema" {
  
  # This is how we can create depenency and ensure this will only run after the creation if the RDS Instance.
  depends_on = [aws_docdb_cluster.docdb]

  provisioner "local-exec" {
        command = <<EOF
        cd /tmp 
        wget https://s3.amazonaws.com/rds-downloads/rds-combined-ca-bundle.pem
        curl -s -L -o /tmp/mongodb.zip "https://github.com/stans-robot-project/mongodb/archive/main.zip"
        unzip -o mongodb.zip
        cd mongodb-main
        mongo --ssl --host ${aws_docdb_cluster.docdb.endpoint}:27017 --sslCAFile /tmp/rds-combined-ca-bundle.pem --username ${local.DOCDB_USER} --password ${local.DOCDB_PASS} < catalogue.js 
        mongo --ssl --host ${aws_docdb_cluster.docdb.endpoint}:27017 --sslCAFile /tmp/rds-combined-ca-bundle.pem --username ${local.DOCDB_USER} --password ${local.DOCDB_PASS} < users.js 
        EOF
    }  
}