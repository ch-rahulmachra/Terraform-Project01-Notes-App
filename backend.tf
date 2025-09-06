terraform {
  backend "s3" {
    bucket = "rx7-notes-app-tf-state"
    key    = "notes-app/development/terraform.tfstate"
    region = "ap-south-1"
    encrypt      = true
    use_lockfile = true
  }
}
