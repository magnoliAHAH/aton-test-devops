terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "0.141.0"
    }
  }
}

locals {
    folder_id = "123"
    cloud_id = "123"
}

provider "yandex" {
    cloud_id  = local.cloud_id
    folder_id = local.folder_id
    service_account_key_file = "123"
    zone = "ru-central1-a"
}