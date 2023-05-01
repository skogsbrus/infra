terraform {
  required_version = ">= 1.0.0"
  required_providers {
    b2 = {
      # https://registry.terraform.io/providers/Backblaze/b2/latest/docs
      source = "Backblaze/b2"
    }
  }
}

resource "b2_bucket" "this" {
  bucket_name = var.bucket_name
  bucket_type = "allPrivate"
  bucket_info = var.tags
  default_server_side_encryption {
    algorithm = "AES256"
    mode      = "SSE-B2"
  }
}
