terraform {
  backend "gcs" {
    bucket = "vscoder-otus-tf-state"
    prefix = "terraform/state/stage"
  }
}
