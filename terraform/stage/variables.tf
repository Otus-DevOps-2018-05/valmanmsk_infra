variable project {
  description = "Project ID"
}

variable region {
  description = "Region"
  default     = "us-west1"
}

variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable disk_image {
  description = "Disk image"
}

variable private_key_path {
  description = "Path to the private key used for ssh access"
}

variable zone {
  description = "Zone"
  default     = "us-west1-b"
}

variable count {
  description = "Count"
  default     = 1
}

variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-app-base"
}

variable db_disk_image {
  description = "Disk image for reddit db"
  default     = "reddit-db-base"
}

variable reddit_app {
  description = "Name of resource"
  default = "reddit-app"
}

variable reddit_app_ip {
  description = "Name of resource"
  default = "-"
}

variable allow_puma {
  description = "Name of resource"
  default = "allow-puma-default"
}

variable allow_mongo {
  description = "Name of resource"
  default = "allow-mongo-default"
}

variable reddit_db {
  description = "Name of resource"
  default = "reddit-db"
}

variable allow_ssh {
  description = "Name of resource"
  default = "default-allow-ssh"
}

variable db_address {
  description = "DATABASE_URL"
  default = "localhost"
}

