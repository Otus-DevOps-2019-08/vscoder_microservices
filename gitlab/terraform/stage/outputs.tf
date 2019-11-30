output "docker_app_external_ip" {
  value = module.docker-app.instances_external_ip
}
output "gitlab_runner_external_ip" {
  value = module.gitlab-runner.instances_external_ip
}
output "stage_server_external_ip" {
  value = module.stage-server.instances_external_ip
}
