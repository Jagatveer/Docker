disable_cache = true
disable_mlock = true
backend "file" {
  path = "/var/lib/vault/storage"
}

listener "tcp" {
  address = "0.0.0.0:8200"
  tls_disable = 1
}
