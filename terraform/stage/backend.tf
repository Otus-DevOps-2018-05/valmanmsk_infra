terraform {
  backend "gcs" {
    bucket  = "valman-tf-state-stage"
    prefix  = "stage"
  }
}

