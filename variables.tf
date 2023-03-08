// Common Banyan Variables followed by cloud specific variables
variable "name" {
  type        = string
  description = "Name to use when registering this Access Tier with the Banyan command center"
}

variable "banyan_host" {
  type        = string
  description = "URL to the Banyan API server"
  default     = "https://net.banyanops.com/"
}

variable "statsd_address" {
  type        = string
  description = "Address to send statsd messages: “hostname:port” for UDP, “unix:///path/to/socket” for UDS"
  default     = null
}

variable "events_rate_limiting" {
  type        = bool
  description = "Enable rate limiting of Access Event generation based on a credit-based rate control mechanism"
  default     = null
}

variable "event_key_rate_limiting" {
  type        = bool
  description = "Enable rate limiting of Access Event generated based on a derived “key” value. Each key has a separate rate limiter, and events with the same key value are subjected to the rate limiter for that key"
  default     = null
}

variable "forward_trust_cookie" {
  type        = bool
  description = "Forward the Banyan trust cookie to upstream servers. This may be enabled if upstream servers wish to make use of information in the Banyan trust cookie"
  default     = null
}

variable "enable_hsts" {
  type        = bool
  description = "If enabled, Banyan will send the HTTP Strict-Transport-Security response header"
  default     = null
}

variable "netagent_version" {
  type        = string
  description = "Override to use a specific version of netagent (e.g. `v2.2.0`). Omit for the latest version available. This version of the provider requires netagent v2.2.0 or higher"
  default     = null
}

variable "disable_snat" {
  type        = bool
  description = "Disable Source Network Address Translation (SNAT)"
  default     = false
}

variable "src_nat_cidr_range" {
  type        = string
  description = "CIDR range which source Network Address Translation (SNAT) will be disabled for"
  default     = null
}

variable "tunnel_port" {
  type        = number
  description = "UDP port for end users to this access tier to utilize when using wireguard service tunnel"
  default     = 51820
}

variable "tunnel_private_domains" {
  type        = list(string)
  description = "Any internal domains that can only be resolved on your internal network’s private DNS"
  default     = null
}

variable "tunnel_cidrs" {
  type        = list(string)
  description = "Backend CIDR Ranges that correspond to the IP addresses in your private network(s)"
  default     = null
}

variable "console_log_level" {
  type        = string
  description = "Controls verbosity of logs to console. Must be one of \"ERR\", \"WARN\", \"INFO\", \"DEBUG\""
  default     = null
}

variable "file_log_level" {
  type        = string
  description = "Controls verbosity of logs to file. Must be one of \"ERR\", \"WARN\", \"INFO\", \"DEBUG\""
  default     = null
}

variable "file_log" {
  type        = bool
  description = "Whether to log to file or not"
  default     = null
}

variable "log_num" {
  type        = number
  description = "For file logs: Number of files to use for log rotation"
  default     = null
}

variable "log_size" {
  type        = number
  description = "For file logs: Size of each file for log rotation"
  default     = null
}

variable "cluster" {
  type        = string
  description = "Name of an existing Shield cluster to register this Access Tier with. This value is set automatically if omitted from the configuration"
  default     = null
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
  description = "CIDR blocks to allow SSH connections from. Default is the VPC CIDR range"
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

variable "staging_repo" {
  type        = string
  description = "If set, the staging deb repository will be used for the netagent install. For internal use only."
  default     = null
}
