# All variables are intended to be set via environment variables (TF_VAR_*). See README.

variable "rancher_api_url" {
  type = string
}

variable "rancher_access_key" {
  type      = string
  sensitive = true
}

variable "rancher_secret_key" {
  type      = string
  sensitive = true
}

variable "cluster_name" {
  type = string
}

variable "kubernetes_version" {
  type    = string
  default = "v1.32.0+rke2r1"
}

variable "cni" {
  type    = string
  default = "canal"
}

variable "tls_san" {
  type    = list(string)
  default = []
}
