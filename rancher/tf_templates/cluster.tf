resource "rancher2_cluster_v2" "this" {
  name               = var.cluster_name
  kubernetes_version = var.kubernetes_version

  rke_config {
    machine_global_config = yamlencode({
      cni     = var.cni
      tls-san = var.tls_san
    })

    etcd {
      snapshot_retention     = 10
      snapshot_schedule_cron = "0 */6 * * *"
    }
  }
}
