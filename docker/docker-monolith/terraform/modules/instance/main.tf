resource "google_compute_instance" "instance" {
  count        = var.instance_count
  name         = "${var.name_prefix}-${var.environment}-${format("%03d", count.index + 1)}"
  machine_type = var.machine_type
  zone         = var.zone
  tags         = var.tags
  labels = {
    env = var.environment
  }
  boot_disk {
    initialize_params {
      image = var.instance_disk_image
    }
  }
  network_interface {
    network = var.vpc_network_name
    access_config {}
  }
}
resource "google_compute_firewall" "firewall_tcp" {
  name    = "allow-${var.name_prefix}-tcp-default-${var.environment}"
  network = var.vpc_network_name
  allow {
    protocol = "tcp"
    ports    = var.tcp_ports
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags   = var.tags
}
