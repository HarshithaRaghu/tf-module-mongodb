# Creates Security Group
resource "aws_security_group" "allow_mongodb" {
  name        = "roboshop-${var.ENV}-mongodb-sg"
  description = "Allow 27017 inbound traffic from intranet only"
  vpc_id      = data.terraform_remote_state.vpc.outputs.VPC_ID

  ingress {
    description = "Allow DOCDB From Local Network"
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    cidr_blocks = [data.terraform_remote_state.vpc.outputs.VPC_CIDR]   # [] represent's list. 
  }

  ingress {
    description = "Allow DOCDB From Default VPC Network"
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    cidr_blocks = [data.terraform_remote_state.vpc.outputs.DEFAULT_VPC_CIDR]   # [] represent's list. 
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "roboshop-${var.ENV}-mongodb-sg"
  }
}