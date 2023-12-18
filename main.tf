resource "vault_rabbitmq_secret_backend" "this" {
  path                      = var.path
  connection_uri            = var.connection_uri
  username                  = var.username
  password                  = var.password
  default_lease_ttl_seconds = var.default_lease_ttl_seconds
  max_lease_ttl_seconds     = var.max_lease_ttl_seconds
}

resource "vault_rabbitmq_secret_backend_role" "this" {
  for_each = var.roles
  name     = coalesce(each.value.name, each.key)
  backend  = vault_rabbitmq_secret_backend.this.path
  tags     = each.value.tags
  dynamic "vhost" {
    for_each = each.value.vhosts
    content {
      host      = vhost.key
      configure = vhost.value.configure
      read      = vhost.value.read
      write     = vhost.value.write
    }
  }
}