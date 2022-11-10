output "address" {
  value       = google_compute_forwarding_rule.accesstier.ip_address
  description = "ip address of the google compute forwarding rule"
}

output "name" {
  value       = var.name
  description = "Name to use when registering this Access Tier with the console"
}

output "api_key_id" {
  value       = banyan_api_key.accesstier.id
  description = "ID of the API key associated with the Access Tier"
}
