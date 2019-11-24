resource "google_compute_project_metadata_item" "ssh-keys" {
  key   = "ssh-keys"
  value = join("\n", var.ssh_keys)
}
