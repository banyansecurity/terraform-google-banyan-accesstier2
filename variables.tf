// Common Banyan Variables followed by cloud specific variables
variable "name" {
  type        = string
  description = "Name to use when registering this Access Tier with the console"
}

variable "api_key" {
  type        = string
  description = "An admin scoped API key to use for authentication to Banyan"
}

variable "banyan_host" {
  type        = string
  description = "URL to the Banyan API server"
  default     = "https://net.banyanops.com/"
}

variable "cluster" {
  type        = string
  description = "Name of an existing Shield cluster to register this Access Tier with"
  default     = null
}

variable "disable_snat" {
  description = "Disable Source Network Address Translation (SNAT)"
  default     = false
}

variable "src_nat_cidr_range" {
  description = ""
  default     = null
}

variable "tunnel_port" {
  description = "UDP for for end users to this access tier to utilize"
  default     = null
}

variable "tunnel_private_domain" {
  description = ""
  default     = null
}

variable "tunnel_cidrs" {
  description = ""
  default     = null
}

variable "console_log_level" {
  description = "Controls verbosity of logs to console"
  default     = null
}

variable "file_log_level" {
  description = "Controls verbosity of logs to file"
  default     = null
}

variable "file_log" {
  description = "Whether to log to file or not"
  default     = null
}

variable "log_num" {
  description = "For file logs: Number of files to use for log rotation"
  default     = null
}

variable "log_size" {
  description = "For file logs: Size of each file for log rotation"
  default     = null
}

variable "statsd_address" {
  description = "Address to send statsd messages: “hostname:port” for UDP, “unix:///path/to/socket” for UDS"
  default     = null
}

variable "events_rate_limiting" {
  description = "Enable rate limiting of Access Event generation based on a credit-based rate control mechanism"
  default     = null
}

variable "event_key_rate_limiting" {
  description = "Enable rate limiting of Access Event generated based on a derived “key” value. Each key has a separate rate limiter, and events with the same key value are subjected to the rate limiter for that key"
  default     = null
}

variable "forward_trust_cookie" {
  description = "Forward the Banyan trust cookie to upstream servers. This may be enabled if upstream servers wish to make use of information in the Banyan trust cookie."
  default     = null
}

variable "enable_hsts" {
  description = "If enabled, Banyan will send the HTTP Strict-Transport-Security response header"
  default     = null
}

variable "infra_maximum_session_timeout" {
  description = ""
  default     = null
}

variable "netagent_version" {
  type        = string
  description = "Override to use a specific version of netagent (e.g. `1.48.0`)"
  default     = ""
}

// GCP specific variables
variable "custom_user_data" {
  type        = list(string)
  description = "Custom commands to append to the launch configuration initialization script."
  default     = []
}

variable "redirect_http_to_https" {
  type        = bool
  description = "If true, requests to the Access Tier on port 80 will be redirected to port 443"
  default     = false
}

variable "machine_type" {
  type        = string
  description = "Google compute instance types"
  default     = "e2-standard-4"
}

variable "project" {
  type        = string
  description = "GCloud project name where AccessTier is deployed"
}

variable "region" {
  type        = string
  description = "Region in which to create the Access Tier"
}

variable "network" {
  type        = string
  description = "Name of the network the Access Tier will belong to"
}

variable "subnetwork" {
  type        = string
  description = "Name of the subnetwork the Access Tier will belong to"
}

variable "minimum_num_of_instances" {
  type        = number
  description = "The minimum number of instances that should be running"
  default     = 2
}

variable "management_cidrs" {
  type        = list(string)
  description = "CIDR blocks to allow SSH connections from"
  default     = ["0.0.0.0/0"]
}

variable "service_source_ip_ranges" {
  type        = list(string)
  description = "List of ip ranges which will be allowed access through the firewall to the Access Tier"
  default     = ["0.0.0.0/0"]
}

variable "service_source_tags" {
  type        = list(string)
  description = "List of network tags which will be allows access through the firewall to the Access Tier"
  default     = []
}

variable "tags" {
  type        = list(string)
  description = "Additional tags to assign to this Access Tier"
  default     = []
}

variable "groups_by_userinfo" {
  type        = bool
  description = "Derive groups information from userinfo endpoint"
  default     = false
}

variable "datadog_api_key" {
  type        = string
  description = "API key for DataDog"
  default     = null
}

variable "netagent-version" {
  type        = string
  description = "Specific version of netagent"
  default     = null
}