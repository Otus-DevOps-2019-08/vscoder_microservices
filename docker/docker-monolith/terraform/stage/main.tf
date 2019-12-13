provider "google" {
  version = "2.15"
  project = var.project
  region  = var.region
}

module "docker-app" {
  instance_count      = var.docker_app_instance_count
  source              = "../modules/instance"
  project             = var.project
  zone                = var.zone
  environment         = var.environment
  name_prefix         = var.docker_app_name_prefix
  machine_type        = var.docker_app_machine_type
  instance_disk_image = var.docker_app_disk_image
  tags                = var.docker_app_tags
  tcp_ports           = var.docker_app_tcp_ports
  vpc_network_name    = var.vpc_network_name
}
