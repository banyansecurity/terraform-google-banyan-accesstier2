Banyan Google Cloud Access Tier 2 Module
======================================

Creates an autoscaling Access Tier for use with [Banyan Security][banyan-security].

This module creates an autoscaler and a TCP load balancer in Google Cloud (GCP) for a Banyan Access Tier. Only the load balancer is exposed to the public internet. The Access Tier and your applications live in private subnets with no ingress from the internet.

## Usage

```hcl
provider "google" {
  project = "my-gcloud-project"
  region  = "us-west1"
}

module "gcp_accesstier" {
  source           = "./accesstier2-gcp"
  name             = "gcp-terraform-test5"
  api_key          = var.api_key
  banyan_host      = var.banyan_host
  project          = local.project_id
  region           = local.region
  network          = local.gcp_network
  subnetwork       = local.gcp_subnetwork
  tags             = ["allow-accesstier"]
  netagent_version = local.netagent_version
}

```


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_banyan"></a> [banyan](#requirement\_banyan) | >=0.7.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_banyan"></a> [banyan](#provider\_banyan) | >=0.7.0 |
| <a name="provider_google"></a> [google](#provider\_google) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| banyan_accesstier.accesstier | resource |
| banyan_api_key.accesstier | resource |
| [google_compute_address.backend_service_ip_address](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_address) | resource |
| [google_compute_firewall.accesstier_ports](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
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
| <a name="input_api_key"></a> [api\_key](#input\_api\_key) | An admin scoped API key to use for authentication to Banyan | `string` | n/a | yes |
| <a name="input_banyan_host"></a> [banyan\_host](#input\_banyan\_host) | URL to the Banyan API server | `string` | `"https://net.banyanops.com/"` | no |
| <a name="input_cluster"></a> [cluster](#input\_cluster) | Name of an existing Shield cluster to register this Access Tier with | `string` | `null` | no |
| <a name="input_console_log_level"></a> [console\_log\_level](#input\_console\_log\_level) | Controls verbosity of logs to console | `any` | `null` | no |
| <a name="input_custom_user_data"></a> [custom\_user\_data](#input\_custom\_user\_data) | Custom commands to append to the launch configuration initialization script. | `list(string)` | `[]` | no |
| <a name="input_datadog_api_key"></a> [datadog\_api\_key](#input\_datadog\_api\_key) | API key for DataDog | `string` | `null` | no |
| <a name="input_disable_snat"></a> [disable\_snat](#input\_disable\_snat) | Disable Source Network Address Translation (SNAT) | `bool` | `false` | no |
| <a name="input_enable_hsts"></a> [enable\_hsts](#input\_enable\_hsts) | If enabled, Banyan will send the HTTP Strict-Transport-Security response header | `any` | `null` | no |
| <a name="input_event_key_rate_limiting"></a> [event\_key\_rate\_limiting](#input\_event\_key\_rate\_limiting) | Enable rate limiting of Access Event generated based on a derived “key” value. Each key has a separate rate limiter, and events with the same key value are subjected to the rate limiter for that key | `any` | `null` | no |
| <a name="input_events_rate_limiting"></a> [events\_rate\_limiting](#input\_events\_rate\_limiting) | Enable rate limiting of Access Event generation based on a credit-based rate control mechanism | `any` | `null` | no |
| <a name="input_file_log"></a> [file\_log](#input\_file\_log) | Whether to log to file or not | `any` | `null` | no |
| <a name="input_file_log_level"></a> [file\_log\_level](#input\_file\_log\_level) | Controls verbosity of logs to file | `any` | `null` | no |
| <a name="input_forward_trust_cookie"></a> [forward\_trust\_cookie](#input\_forward\_trust\_cookie) | Forward the Banyan trust cookie to upstream servers. This may be enabled if upstream servers wish to make use of information in the Banyan trust cookie. | `any` | `null` | no |
| <a name="input_groups_by_userinfo"></a> [groups\_by\_userinfo](#input\_groups\_by\_userinfo) | Derive groups information from userinfo endpoint | `bool` | `false` | no |
| <a name="input_infra_maximum_session_timeout"></a> [infra\_maximum\_session\_timeout](#input\_infra\_maximum\_session\_timeout) | n/a | `any` | `null` | no |
| <a name="input_log_num"></a> [log\_num](#input\_log\_num) | For file logs: Number of files to use for log rotation | `any` | `null` | no |
| <a name="input_log_size"></a> [log\_size](#input\_log\_size) | For file logs: Size of each file for log rotation | `any` | `null` | no |
| <a name="input_machine_type"></a> [machine\_type](#input\_machine\_type) | Google compute instance types | `string` | `"e2-standard-4"` | no |
| <a name="input_management_cidrs"></a> [management\_cidrs](#input\_management\_cidrs) | CIDR blocks to allow SSH connections from | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_minimum_num_of_instances"></a> [minimum\_num\_of\_instances](#input\_minimum\_num\_of\_instances) | The minimum number of instances that should be running | `number` | `2` | no |
| <a name="input_name"></a> [name](#input\_name) | Name to use when registering this Access Tier with the console | `string` | n/a | yes |
| <a name="input_netagent-version"></a> [netagent-version](#input\_netagent-version) | Specific version of netagent | `string` | `"1.43.0"` | no |
| <a name="input_netagent_version"></a> [netagent\_version](#input\_netagent\_version) | Override to use a specific version of netagent (e.g. `1.48.0`) | `string` | `""` | no |
| <a name="input_network"></a> [network](#input\_network) | Name of the network the Access Tier will belong to | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | GCloud project name where AccessTier is deployed | `string` | n/a | yes |
| <a name="input_redirect_http_to_https"></a> [redirect\_http\_to\_https](#input\_redirect\_http\_to\_https) | If true, requests to the Access Tier on port 80 will be redirected to port 443 | `bool` | `false` | no |
| <a name="input_region"></a> [region](#input\_region) | Region in which to create the Access Tier | `string` | n/a | yes |
| <a name="input_service_source_ip_ranges"></a> [service\_source\_ip\_ranges](#input\_service\_source\_ip\_ranges) | List of ip ranges which will be allowed access through the firewall to the Access Tier | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_service_source_tags"></a> [service\_source\_tags](#input\_service\_source\_tags) | List of network tags which will be allows access through the firewall to the Access Tier | `list(string)` | `[]` | no |
| <a name="input_src_nat_cidr_range"></a> [src\_nat\_cidr\_range](#input\_src\_nat\_cidr\_range) | n/a | `any` | `null` | no |
| <a name="input_statsd_address"></a> [statsd\_address](#input\_statsd\_address) | Address to send statsd messages: “hostname:port” for UDP, “unix:///path/to/socket” for UDS | `any` | `null` | no |
| <a name="input_subnetwork"></a> [subnetwork](#input\_subnetwork) | Name of the subnetwork the Access Tier will belong to | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags to assign to this Access Tier | `list(string)` | `[]` | no |
| <a name="input_tunnel_cidrs"></a> [tunnel\_cidrs](#input\_tunnel\_cidrs) | n/a | `any` | `null` | no |
| <a name="input_tunnel_port"></a> [tunnel\_port](#input\_tunnel\_port) | UDP for for end users to this access tier to utilize | `any` | `null` | no |
| <a name="input_tunnel_private_domain"></a> [tunnel\_private\_domain](#input\_tunnel\_private\_domain) | n/a | `any` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_address"></a> [address](#output\_address) | ip address of the google compute forwarding rule |
| <a name="output_name"></a> [name](#output\_name) | Name to use when registering this Access Tier with the console |
<!-- END_TF_DOCS -->