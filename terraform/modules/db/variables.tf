variable public_key_path {
  description = "Path to the public key used to connect to instance"
}

variable zone {
  description = "Zone"
}

variable db_disk_image {
  description = "Disk image for reddit db"
  default     = "reddit-db-base"
}

variable allow_mongo {
  description = "Name of resource"
  default = "allow-mongo-default"
}

variable reddit_db {
  description = "Name of resource"
  default = "reddit-db"
}
variable private_key_path {
  description = "Path to the private key used to connect to instance"
}

