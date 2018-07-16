provider "google" {
  version = "1.4.0"
  project = "${var.project}"
  region  = "${var.region}"
}

module "app" {
  source          = "../modules/app"
  public_key_path = "${var.public_key_path}"
  zone            = "${var.zone}"
  app_disk_image  = "${var.app_disk_image}"
  reddit_app = "${var.reddit_app}"
  reddit_app_ip = "${var.reddit_app_ip}"
  allow_puma = "${var.allow_puma}"
  db_address = "${module.db.db_internal_ip}"
  private_key_path = "${var.private_key_path}"
}

module "db" {
  source          = "../modules/db"
  public_key_path = "${var.public_key_path}"
  zone            = "${var.zone}"
  db_disk_image   = "${var.db_disk_image}"
  reddit_db = "${var.reddit_db}"
  allow_mongo = "${var.allow_mongo}"
  private_key_path = "${var.private_key_path}"
}

module "vpc" {
  source        = "../modules/vpc"
  source_ranges = ["${var.source_ranges}"] 
  allow_ssh = "${var.allow_ssh}"
}

