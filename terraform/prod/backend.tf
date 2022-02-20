terraform {
  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "tf-bucket-11022022"
    region     = "us-east-1"
    key        = "terraform.tfstate"
    access_key = "hSd34USU3qNoebgrrZMG"
    secret_key = "l1Tip2GLiD_RuSNE3TXdsrYk3aiOLiY3DiXCriJB"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}
