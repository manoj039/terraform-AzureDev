
terraform {
backend "gcs" {
  bucket = "manoj-azure-tf-state"   # GCS bucket name to store terraform tfstate
  prefix = "terraform/state"           # Update to desired prefix name. Prefix name should be unique for each Terraform project having same remote state bucket.
  }
}