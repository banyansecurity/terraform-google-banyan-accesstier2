output "address" {
  value       = google_compute_forwarding_rule.accesstier.ip_address
  description = "ip address of the google compute forwarding rule"
}

output "name" {
  value       = var.name
  description = "Name to use when registering this Access Tier with the console"
}
