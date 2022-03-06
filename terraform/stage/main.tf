provider "yandex" {
#  version                  = "~> 0.56"
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
  service_account_key_file = var.service_account_key_file
}
module "app" {
  source            = "../modules/app"
  public_key_path   = var.public_key_path
  app_disk_image    = var.app_disk_image
  app_subnet_id     = var.subnet_id
  db_url            = module.db.external_ip_address_db
  enable_deploy_app = var.enable_provision
}
module "db" {
  source           = "../modules/db"
  public_key_path  = var.public_key_path
  db_disk_image    = var.db_disk_image
  db_subnet_id     = var.subnet_id
  enable_deploy_db = var.enable_provision
}

