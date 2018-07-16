variable public_key_path {
  description = "Path to the public key used to connect to instance"
}

variable zone {
  description = "Zone"
}

variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-app-base"
}

variable reddit_app {
  description = "Name of resource"
  default = "reddit-app"
}

variable reddit_app_ip {
  description = "Name of resource"
  default = "reddit-app"
}

variable allow_puma {
  description = "Name of resource"
  default = "allow-puma-default"
}

variable db_address {
  description = "DATABASE_URL"
  default = "localhost"
}

variable private_key_path {
  description = "Path to the private key used for ssh access"
}

