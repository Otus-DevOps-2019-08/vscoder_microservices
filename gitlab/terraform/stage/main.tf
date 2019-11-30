provider "google" {
  version = "2.15"
  project = var.project
  region  = var.region
}

# GitLab instance
module "docker-app" {
  instance_count      = 1
  source              = "../modules/instance"
  project             = var.project
  zone                = var.zone
  environment         = var.environment
  name_prefix         = "gitlab"
  machine_type        = "n1-standard-1"
  instance_disk_image = "gitlab-docker-base"
  tags                = ["gitlab-docker-app"]
  tcp_ports           = ["80", "443", "22", "2222"]
  vpc_network_name    = var.vpc_network_name
  use_static_ip       = true
}

# Gitlab Runner
module "gitlab-runner" {
  instance_count      = 1
  source              = "../modules/instance"
  project             = var.project
  zone                = var.zone
  environment         = var.environment
  name_prefix         = "gitlab-runner"
  machine_type        = "g1-small"
  instance_disk_image = "gitlab-runner-base"
  tags                = ["gitlab-runner-shell"]
  tcp_ports           = ["22"]
  vpc_network_name    = var.vpc_network_name
  use_static_ip       = false
}
