Banyan Google Cloud Access Tier 2 Module
======================================

This module creates an auto-scaling instance group and a TCP load balancer in Google Cloud (GCP) for a Banyan Access Tier. A network load balancer forwards traffic to the instance group which, when added to the proper tags and banyan zero trust policies, allows for connections to internal services or to the network via service tunnel. 

This module will create an access tier definition in the Banyan API, and an `access_tier` scoped API key. It will populate the launch configuration of all instances in the auto-scaling group with a short script to download the latest version of the Banyan NetAgent (or a pinned version if set), install it as a service, and launch the netagent with the API key and access tier configuration name for your Banyan organization.

### Why Access Tier 2?

In order to ease the installation and configuration the access tier, the new netagent only needs an access tier scoped API key, Banyan API url, and the name of an access tier configuration in order to successfully connect. In this new module the access tier is defined in the Banyan API with the `banyan_accesstier` resource from the `banyan` terraform provider. The API key is created specifically for the access tier and added to the launch configuration

This change brings substantial cohesion to the overall deployment of the access tier via Terraform and should lead to less configuration errors and deployment issues.


## Usage

```terraform
provider "google" {
  project = "my-gcloud-project"
  region  = "us-west1"
}

module "gcp_accesstier" {
  source                   = "banyansecurity/banyan-accesstier2/google"
  name                     = "example"
  banyan_host              = var.banyan_host
  project                  = "example-project"
  region                   = "us-west1"
  network                  = "us-west1"
  subnetwork               = "us-west1-external"
  tags                     = ["allow-accesstier"]
  tunnel_cidrs             = ["10.10.0.0/24"]
}

```

## Example Stack with Service Tunnel and Wildcard DNS Record

```terraform
provider "banyan" {
  api_key = var.api_key
  host    = var.banyan_host
}

provider "google" {
  project = local.project_id
  region  = local.region
}

module "gcp_accesstier" {
  source                   = "banyansecurity/banyan-accesstier2/google"
  name                     = "example"
  banyan_host              = var.banyan_host
  project                  = "example-project"
  region                   = "us-west1"
  network                  = "us-west1"
  subnetwork               = "us-west1-external"
  tags                     = ["allow-accesstier"]
  tunnel_cidrs             = ["10.10.0.0/24"]
}

resource "banyan_service_tunnel" "example" {
  name        = "example-anyone-high"
  description = "tunnel allowing anyone with a high trust level"
  access_tier = module.gcp_accesstier.name
  policy      = banyan_policy_infra.anyone-high.id
}

resource "banyan_policy_infra" "anyone-high" {
  name        = "allow-anyone"
  description = "${module.gcp_accesstier.name} allow"
  access {
    roles       = ["ANY"]
    trust_level = "High"
  }
}

resource "google_dns_record_set" "frontend" {
  name = "*.${module.gcp_accesstier.name}.mycompany.com"
  type = "A"
  ttl  = 300
  managed_zone = google_dns_managed_zone.prod.name
  rrdatas = module.gcp_accesstier.address
}
```

## Upgrading Netagent

Set `netagent_version` to the desired version number. This will ensure all instances are pinned to the same version number. If `netagent_version` is not specified, each instance will automatically install the latest version.

## Notes

The default value for `management_cidr` leaves SSH closed to instances in the access tier.

The current recommended setup for  to use a banyan SSH service to SSH to a host inside of the private network, which in turn has SSH access to the instances in the auto-scaling group. This way no SSH service is exposed to the internet.


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_banyan"></a> [banyan](#requirement\_banyan) | >=0.9.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_banyan"></a> [banyan](#provider\_banyan) | >=0.9.1 |
| <a name="provider_google"></a> [google](#provider\_google) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [banyan_accesstier.accesstier](https://registry.terraform.io/providers/banyansecurity/banyan/latest/docs/resources/accesstier) | resource |
| [banyan_api_key.accesstier](https://registry.terraform.io/providers/banyansecurity/banyan/latest/docs/resources/api_key) | resource |
| [google_compute_address.external](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_address) | resource |
| [google_compute_firewall.accesstier_ports](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_firewall.accesstier_ports_tunnel](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_firewall.accesstier_ssh](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_firewall.healthcheck](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_forwarding_rule.accesstier](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_forwarding_rule) | resource |
| [google_compute_health_check.accesstier_health_check](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_health_check) | resource |
| [google_compute_instance_template.accesstier_template](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance_template) | resource |
| [google_compute_region_autoscaler.accesstier](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_region_autoscaler) | resource |
| [google_compute_region_backend_service.accesstier](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_region_backend_service) | resource |
| [google_compute_region_health_check.backend_service_loadbalancer_health_check](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_region_health_check) | resource |
| [google_compute_region_instance_group_manager.accesstier_rigm](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_region_instance_group_manager) | resource |
| [google_compute_image.accesstier_image](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_image) | data source |
| [google_compute_network.accesstier_network](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_network) | data source |
| [google_compute_subnetwork.accesstier_subnet](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_subnetwork) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | Name to use when registering this Access Tier with the Banyan command center | `string` | n/a | yes |
| <a name="input_network"></a> [network](#input\_network) | Name of the network the Access Tier will belong to | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | GCloud project name where AccessTier is deployed | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Region in which to create the Access Tier | `string` | n/a | yes |
| <a name="input_subnetwork"></a> [subnetwork](#input\_subnetwork) | Name of the subnetwork the Access Tier will belong to | `string` | n/a | yes |
| <a name="input_banyan_host"></a> [banyan\_host](#input\_banyan\_host) | URL to the Banyan API server | `string` | `"https://net.banyanops.com/"` | no |
| <a name="input_cluster"></a> [cluster](#input\_cluster) | Name of an existing Shield cluster to register this Access Tier with. This value is set automatically if omitted from the configuration | `string` | `null` | no |
| <a name="input_console_log_level"></a> [console\_log\_level](#input\_console\_log\_level) | Controls verbosity of logs to console. Must be one of "ERR", "WARN", "INFO", "DEBUG" | `string` | `null` | no |
| <a name="input_custom_user_data"></a> [custom\_user\_data](#input\_custom\_user\_data) | Custom commands to append to the launch configuration initialization script. | `list(string)` | `[]` | no |
| <a name="input_datadog_api_key"></a> [datadog\_api\_key](#input\_datadog\_api\_key) | API key for DataDog | `string` | `null` | no |
| <a name="input_disable_snat"></a> [disable\_snat](#input\_disable\_snat) | Disable Source Network Address Translation (SNAT) | `bool` | `false` | no |
| <a name="input_enable_hsts"></a> [enable\_hsts](#input\_enable\_hsts) | If enabled, Banyan will send the HTTP Strict-Transport-Security response header | `bool` | `null` | no |
| <a name="input_event_key_rate_limiting"></a> [event\_key\_rate\_limiting](#input\_event\_key\_rate\_limiting) | Enable rate limiting of Access Event generated based on a derived “key” value. Each key has a separate rate limiter, and events with the same key value are subjected to the rate limiter for that key | `bool` | `null` | no |
| <a name="input_events_rate_limiting"></a> [events\_rate\_limiting](#input\_events\_rate\_limiting) | Enable rate limiting of Access Event generation based on a credit-based rate control mechanism | `bool` | `null` | no |
| <a name="input_file_log"></a> [file\_log](#input\_file\_log) | Whether to log to file or not | `bool` | `null` | no |
| <a name="input_file_log_level"></a> [file\_log\_level](#input\_file\_log\_level) | Controls verbosity of logs to file. Must be one of "ERR", "WARN", "INFO", "DEBUG" | `string` | `null` | no |
| <a name="input_forward_trust_cookie"></a> [forward\_trust\_cookie](#input\_forward\_trust\_cookie) | Forward the Banyan trust cookie to upstream servers. This may be enabled if upstream servers wish to make use of information in the Banyan trust cookie | `bool` | `null` | no |
| <a name="input_groups_by_userinfo"></a> [groups\_by\_userinfo](#input\_groups\_by\_userinfo) | Derive groups information from userinfo endpoint | `bool` | `false` | no |
| <a name="input_log_num"></a> [log\_num](#input\_log\_num) | For file logs: Number of files to use for log rotation | `number` | `null` | no |
| <a name="input_log_size"></a> [log\_size](#input\_log\_size) | For file logs: Size of each file for log rotation | `number` | `null` | no |
| <a name="input_machine_type"></a> [machine\_type](#input\_machine\_type) | Google compute instance types | `string` | `"e2-standard-4"` | no |
| <a name="input_management_cidrs"></a> [management\_cidrs](#input\_management\_cidrs) | CIDR blocks to allow SSH connections from. Default is the VPC CIDR range | `list(string)` | `[]` | no |
| <a name="input_minimum_num_of_instances"></a> [minimum\_num\_of\_instances](#input\_minimum\_num\_of\_instances) | The minimum number of instances that should be running | `number` | `2` | no |
| <a name="input_netagent-version"></a> [netagent-version](#input\_netagent-version) | Specific version of netagent | `string` | `null` | no |
| <a name="input_netagent_version"></a> [netagent\_version](#input\_netagent\_version) | Override to use a specific version of netagent (e.g. `1.49.1`). Omit for the latest version available | `string` | `null` | no |
| <a name="input_redirect_http_to_https"></a> [redirect\_http\_to\_https](#input\_redirect\_http\_to\_https) | If true, requests to the Access Tier on port 80 will be redirected to port 443 | `bool` | `false` | no |
| <a name="input_service_source_ip_ranges"></a> [service\_source\_ip\_ranges](#input\_service\_source\_ip\_ranges) | List of ip ranges which will be allowed access through the firewall to the Access Tier | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_service_source_tags"></a> [service\_source\_tags](#input\_service\_source\_tags) | List of network tags which will be allows access through the firewall to the Access Tier | `list(string)` | `[]` | no |
| <a name="input_src_nat_cidr_range"></a> [src\_nat\_cidr\_range](#input\_src\_nat\_cidr\_range) | CIDR range which source Network Address Translation (SNAT) will be disabled for | `string` | `null` | no |
| <a name="input_statsd_address"></a> [statsd\_address](#input\_statsd\_address) | Address to send statsd messages: “hostname:port” for UDP, “unix:///path/to/socket” for UDS | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags to assign to this Access Tier | `list(string)` | `[]` | no |
| <a name="input_tunnel_cidrs"></a> [tunnel\_cidrs](#input\_tunnel\_cidrs) | Backend CIDR Ranges that correspond to the IP addresses in your private network(s) | `list(string)` | `null` | no |
| <a name="input_tunnel_port"></a> [tunnel\_port](#input\_tunnel\_port) | UDP port for end users to this access tier to utilize when using service tunnel | `number` | `null` | no |
| <a name="input_tunnel_private_domains"></a> [tunnel\_private\_domains](#input\_tunnel\_private\_domains) | Any internal domains that can only be resolved on your internal network’s private DNS | `list(string)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_address"></a> [address](#output\_address) | ip address of the google compute forwarding rule |
| <a name="output_api_key_id"></a> [api\_key\_id](#output\_api\_key\_id) | ID of the API key associated with the Access Tier |
| <a name="output_name"></a> [name](#output\_name) | Name to use when registering this Access Tier with the console |
<!-- END_TF_DOCS -->