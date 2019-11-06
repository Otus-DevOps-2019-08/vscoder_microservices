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

variable instance_disk_image {
  description = "Instance base disk image"
}

variable vpc_network_name {
  description = "Network name"
  default     = "default"
}

variable environment {
  description = "Environment name"
  default     = "stage"
}

variable machine_type {
  description = "Machine type"
  default     = "g1-small"
}

variable tags {
  description = "Tags list"
  type        = list
  default     = []
}

variable instance_count {
  description = "instances count"
  default     = 1
}

variable name_prefix {
  description = "Name prefix of instance"
  default     = "instance"
}

variable tcp_ports {
  description = "TCP ports list to open list"
  type        = list
  default     = []
}
