terraform {
  backend "s3" {
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    endpoint                    = "s3.us-east-005.backblazeb2.com"
    region                      = "us-east-1"                      # Needs to be a valid AWS region
    bucket                      = "skogsbrus-terraform-state-prod" # Variables aren't allowed in this block
    key                         = "terraform.tfstate"
  }
}

module "b2_remote_state" {
  source      = "../../modules/b2-bucket"
  bucket_name = "skogsbrus-terraform-state-prod"
  tags = {
    env = "prod"
  }
}

module "b2_backup" {
  source      = "../../modules/b2-bucket"
  bucket_name = "skogsbrus-backup-prod"
  tags = {
    env = "prod"
  }
}

module "b2_obsidian" {
  source      = "../../modules/b2-bucket"
  bucket_name = "skogsbrus-notes-prod"
  tags = {
    env = "prod"
  }
}
