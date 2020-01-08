module "gke" {
    source  = "gruntwork-io/gke/google"
    version = "0.3.9"
    project = var.project
    location = var.location
    region = var.region
    cluster_name = var.cluster_name
    cluster_service_account_name = var.cluster_service_account_name
    cluster_service_account_description = var.cluster_service_account_description

    kubectl_config_path = var.kubectl_config_path
    tls_subject = var.tls_subject
    client_tls_subject = var.client_tls_subject
    private_key_algorithm = var.private_key_algorithm
    private_key_ecdsa_curve = var.private_key_ecdsa_curve
    private_key_rsa_bits = var.private_key_rsa_bits
    
    force_undeploy = var.force_undeploy
    undeploy_releases = var.undeploy_releases
    

    master_ipv4_cidr_block = var.master_ipv4_cidr_block
    vpc_cidr_block = var.vpc_cidr_block
    vpc_secondary_cidr_block = var.vpc_secondary_cidr_block
}
