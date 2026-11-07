# Sample infrastructure for the CFM TIPs walkthrough.
# It's for cost analysis only. Don't deploy it.

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "app" {
  ami           = "ami-0123456789abcdef0" # placeholder
  instance_type = "m5.xlarge"

  root_block_device {
    volume_type = "gp2"
    volume_size = 100
  }

  tags = {
    Name = "cfm-tips-sample-app"
  }
}

resource "aws_db_instance" "app" {
  identifier                  = "cfm-tips-sample-db"
  engine                      = "postgres"
  instance_class              = "db.m5.large"
  allocated_storage           = 100
  storage_type                = "gp2"
  username                    = "appadmin"
  manage_master_user_password = true
  skip_final_snapshot         = true

  tags = {
    Name = "cfm-tips-sample-db"
  }
}
