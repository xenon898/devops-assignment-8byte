terraform {
  backend "s3" {
    bucket       = "devops-assignment-8byte-tfstate-2026-xenon898"
    key          = "staging/terraform.tfstate"
    region       = "ap-south-1"
    encrypt      = true
    use_lockfile = true
  }
}