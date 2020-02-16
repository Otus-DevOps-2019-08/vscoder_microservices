provider "helm" {
  kubernetes {
    host     = module.gke_cluster.endpoint

    client_certificate     = module.gke_cluster.client_certificate
    client_key             = module.gke_cluster.client_key
    cluster_ca_certificate = module.gke_cluster.cluster_ca_certificate
  }
}
data "helm_repository" "stable" {
  name = "stable"
  url  = "https://kubernetes-charts.storage.googleapis.com"
}
resource "helm_release" "nginx" {
  name  = "nginx"
  chart = "stable/nginx-ingress"
  repository = data.helm_repository.stable.metadata[0].name

  cleanup_on_fail = true
  wait = true

//   set {
//     name  = "controller.service.loadBalancerIP"
//     value = "127.0.0.1"
//   }
}
