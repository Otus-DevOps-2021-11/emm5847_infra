terraform {
  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "tf-bucket-11022022"
    region     = "us-east-1"
    key        = "terraform.tfstate"
    access_key = "6d__pBkuPXXzB42vbY_-"
    secret_key = "p8SjS1_eko1NlvbHFKEmfTTxnFX15G_uorzpLmAO"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}
