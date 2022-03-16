terraform {
  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "tf-bucket-11022022"
    region     = "us-east-1"
    key        = "terraform.tfstate"
    access_key = "1SJshgyvr80A8fJXrP1m"
    secret_key = "yT8RJhw_yI2inkCwZQhGYAHILn61lS2JuVYgODI_"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}
