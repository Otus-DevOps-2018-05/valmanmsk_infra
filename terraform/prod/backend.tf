terraform {
  backend "gcs" {
    bucket  = "valman-tf-state-prod"
    prefix  = "prod"
  }
}

