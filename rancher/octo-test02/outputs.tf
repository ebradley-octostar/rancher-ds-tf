output "cluster_name" {
  value = rancher2_cluster_v2.this.name
}

output "cluster_id" {
  value = rancher2_cluster_v2.this.cluster_v1_id
}
