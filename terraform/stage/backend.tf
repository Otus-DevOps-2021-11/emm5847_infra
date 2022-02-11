terraform {
  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "tf-bucket-11022022"
    region     = "us-east-1"
    key        = "terraform.tfstate"
    access_key = "fadjfdkleocaJdwea"
    secret_key = "fasfewricvlasiIsaWadcdCV"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}
