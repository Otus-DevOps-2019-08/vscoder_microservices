variable project {
  description = "Project ID"
}
variable region {
  description = "Region"
  default     = "europe-west1"
}
variable zone {
  description = "Zone"
  default     = "europe-west1-d"
}

variable vpc_network_name {
  description = "Network name"
  default     = "default"
}

variable docker_app_disk_image {
  description = "Docker app base disk image"
  default     = "reddit-docker-base"
}

variable docker_app_machine_type {
  description = "Docker app Machine type"
  default     = "g1-small"
}

variable docker_app_name_prefix {
  description = "Name prefix of docker app instance"
  default     = "reddit-docker"
}

variable docker_app_instance_count {
  type    = number
  default = 1
}

variable environment {
  description = "Environment name"
  default     = "stage"
}

variable docker_app_tags {
  description = "Tags list"
  type        = list
  default     = []
}

variable docker_app_tcp_ports {
  description = "TCP ports list to open list"
  type        = list
  default     = []
}
