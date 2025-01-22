> *This document is generated and maintained using [terraform-docs](https://terraform-docs.io/user-guide/introduction/)*


# dataiku
[See appendix for deeptails](./APPENDIX.md)

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_backend_service_name"></a> [backend\_service\_name](#module\_backend\_service\_name) | ../utils/naming | n/a |
| <a name="module_bucket_name"></a> [bucket\_name](#module\_bucket\_name) | ../utils/naming | n/a |
| <a name="module_certificate_name"></a> [certificate\_name](#module\_certificate\_name) | ../utils/naming | n/a |
| <a name="module_cloudsql_database_name"></a> [cloudsql\_database\_name](#module\_cloudsql\_database\_name) | ../utils/naming | n/a |
| <a name="module_cloudsql_instance_name"></a> [cloudsql\_instance\_name](#module\_cloudsql\_instance\_name) | ../utils/naming | n/a |
| <a name="module_cloudsql_password_secret_name"></a> [cloudsql\_password\_secret\_name](#module\_cloudsql\_password\_secret\_name) | ../utils/naming | n/a |
| <a name="module_compute_address_name"></a> [compute\_address\_name](#module\_compute\_address\_name) | ../utils/naming | n/a |
| <a name="module_data_disk_name"></a> [data\_disk\_name](#module\_data\_disk\_name) | ../utils/naming | n/a |
| <a name="module_data_sac_name"></a> [data\_sac\_name](#module\_data\_sac\_name) | ../utils/naming | n/a |
| <a name="module_dataset_name"></a> [dataset\_name](#module\_dataset\_name) | ../utils/naming | n/a |
| <a name="module_gce_disk_snapshot_policy_name"></a> [gce\_disk\_snapshot\_policy\_name](#module\_gce\_disk\_snapshot\_policy\_name) | ../utils/naming | n/a |
| <a name="module_gce_name"></a> [gce\_name](#module\_gce\_name) | ../utils/naming | n/a |
| <a name="module_gce_start_stop_policy_name"></a> [gce\_start\_stop\_policy\_name](#module\_gce\_start\_stop\_policy\_name) | ../utils/naming | n/a |
| <a name="module_gke"></a> [gke](#module\_gke) | ../gke | n/a |
| <a name="module_health_check_name"></a> [health\_check\_name](#module\_health\_check\_name) | ../utils/naming | n/a |
| <a name="module_host_sac_name"></a> [host\_sac\_name](#module\_host\_sac\_name) | ../utils/naming | n/a |
| <a name="module_http_forwarding_rule_name"></a> [http\_forwarding\_rule\_name](#module\_http\_forwarding\_rule\_name) | ../utils/naming | n/a |
| <a name="module_http_proxy_name"></a> [http\_proxy\_name](#module\_http\_proxy\_name) | ../utils/naming | n/a |
| <a name="module_https_forwarding_rule_name"></a> [https\_forwarding\_rule\_name](#module\_https\_forwarding\_rule\_name) | ../utils/naming | n/a |
| <a name="module_https_proxy_name"></a> [https\_proxy\_name](#module\_https\_proxy\_name) | ../utils/naming | n/a |
| <a name="module_instance_group_name"></a> [instance\_group\_name](#module\_instance\_group\_name) | ../utils/naming | n/a |
| <a name="module_main_url_map_name"></a> [main\_url\_map\_name](#module\_main\_url\_map\_name) | ../utils/naming | n/a |
| <a name="module_redirect_url_map_name"></a> [redirect\_url\_map\_name](#module\_redirect\_url\_map\_name) | ../utils/naming | n/a |

## Resources

| Name | Type |
|------|------|
| [google_bigquery_dataset.main](https://registry.terraform.io/providers/hashicorp/google/4.75.1/docs/resources/bigquery_dataset) | resource |
| [google_compute_address.main](https://registry.terraform.io/providers/hashicorp/google/4.75.1/docs/resources/compute_address) | resource |
| [google_compute_forwarding_rule.http](https://registry.terraform.io/providers/hashicorp/google/4.75.1/docs/resources/compute_forwarding_rule) | resource |
| [google_compute_forwarding_rule.https](https://registry.terraform.io/providers/hashicorp/google/4.75.1/docs/resources/compute_forwarding_rule) | resource |
| [google_compute_health_check.main](https://registry.terraform.io/providers/hashicorp/google/4.75.1/docs/resources/compute_health_check) | resource |
| [google_compute_instance.main](https://registry.terraform.io/providers/hashicorp/google/4.75.1/docs/resources/compute_instance) | resource |
| [google_compute_instance_group.main](https://registry.terraform.io/providers/hashicorp/google/4.75.1/docs/resources/compute_instance_group) | resource |
| [google_compute_region_backend_service.main](https://registry.terraform.io/providers/hashicorp/google/4.75.1/docs/resources/compute_region_backend_service) | resource |
| [google_compute_region_disk.data_disk](https://registry.terraform.io/providers/hashicorp/google/4.75.1/docs/resources/compute_region_disk) | resource |
| [google_compute_region_disk_resource_policy_attachment.data_disk_snapshot_policy](https://registry.terraform.io/providers/hashicorp/google/4.75.1/docs/resources/compute_region_disk_resource_policy_attachment) | resource |
| [google_compute_region_ssl_certificate.main](https://registry.terraform.io/providers/hashicorp/google/4.75.1/docs/resources/compute_region_ssl_certificate) | resource |
| [google_compute_region_target_http_proxy.main](https://registry.terraform.io/providers/hashicorp/google/4.75.1/docs/resources/compute_region_target_http_proxy) | resource |
| [google_compute_region_target_https_proxy.main](https://registry.terraform.io/providers/hashicorp/google/4.75.1/docs/resources/compute_region_target_https_proxy) | resource |
| [google_compute_region_url_map.main](https://registry.terraform.io/providers/hashicorp/google/4.75.1/docs/resources/compute_region_url_map) | resource |
| [google_compute_region_url_map.redirect](https://registry.terraform.io/providers/hashicorp/google/4.75.1/docs/resources/compute_region_url_map) | resource |
| [google_compute_resource_policy.snapshot_policy](https://registry.terraform.io/providers/hashicorp/google/4.75.1/docs/resources/compute_resource_policy) | resource |
| [google_compute_resource_policy.start_stop_policy](https://registry.terraform.io/providers/hashicorp/google/4.75.1/docs/resources/compute_resource_policy) | resource |
| [google_project_iam_custom_role.dataiku_cloud_run_jobs](https://registry.terraform.io/providers/hashicorp/google/4.75.1/docs/resources/project_iam_custom_role) | resource |
| [google_project_iam_member.data_sac_roles](https://registry.terraform.io/providers/hashicorp/google/4.75.1/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.host_sac_cloudsqlclient_role](https://registry.terraform.io/providers/hashicorp/google/4.75.1/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.host_sac_cr_role](https://registry.terraform.io/providers/hashicorp/google/4.75.1/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.host_sac_roles](https://registry.terraform.io/providers/hashicorp/google/4.75.1/docs/resources/project_iam_member) | resource |
| [google_secret_manager_secret.cloudsql_password](https://registry.terraform.io/providers/hashicorp/google/4.75.1/docs/resources/secret_manager_secret) | resource |
| [google_secret_manager_secret_version.cloudsql_password](https://registry.terraform.io/providers/hashicorp/google/4.75.1/docs/resources/secret_manager_secret_version) | resource |
| [google_service_account.data_sac](https://registry.terraform.io/providers/hashicorp/google/4.75.1/docs/resources/service_account) | resource |
| [google_service_account.host_sac](https://registry.terraform.io/providers/hashicorp/google/4.75.1/docs/resources/service_account) | resource |
| [google_service_account_key.data_sac_key](https://registry.terraform.io/providers/hashicorp/google/4.75.1/docs/resources/service_account_key) | resource |
| [google_sql_database.database](https://registry.terraform.io/providers/hashicorp/google/4.75.1/docs/resources/sql_database) | resource |
| [google_sql_database_instance.main](https://registry.terraform.io/providers/hashicorp/google/4.75.1/docs/resources/sql_database_instance) | resource |
| [google_sql_user.dataiku](https://registry.terraform.io/providers/hashicorp/google/4.75.1/docs/resources/sql_user) | resource |
| [google_storage_bucket.main](https://registry.terraform.io/providers/hashicorp/google/4.75.1/docs/resources/storage_bucket) | resource |
| [random_id.cloudsql_instance_id](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [random_password.cloudsql_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [google_compute_disk.fusion-source-disk](https://registry.terraform.io/providers/hashicorp/google/4.75.1/docs/data-sources/compute_disk) | data source |
| [google_compute_image.ubuntu](https://registry.terraform.io/providers/hashicorp/google/4.75.1/docs/data-sources/compute_image) | data source |
| [google_compute_network.shared](https://registry.terraform.io/providers/hashicorp/google/4.75.1/docs/data-sources/compute_network) | data source |
| [google_compute_subnetwork.shared](https://registry.terraform.io/providers/hashicorp/google/4.75.1/docs/data-sources/compute_subnetwork) | data source |
| [google_compute_zones.available](https://registry.terraform.io/providers/hashicorp/google/4.75.1/docs/data-sources/compute_zones) | data source |
| [google_secret_manager_secret_version.ssl_certificate](https://registry.terraform.io/providers/hashicorp/google/4.75.1/docs/data-sources/secret_manager_secret_version) | data source |
| [google_secret_manager_secret_version.ssl_private_key](https://registry.terraform.io/providers/hashicorp/google/4.75.1/docs/data-sources/secret_manager_secret_version) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apt_proxy_url"></a> [apt\_proxy\_url](#input\_apt\_proxy\_url) | APT proxy URL | `string` | `"http://emea-private-zscaler.proxy.lvmh:9480"` | no |
| <a name="input_cloud_sql_dataiku_password_secret_name"></a> [cloud\_sql\_dataiku\_password\_secret\_name](#input\_cloud\_sql\_dataiku\_password\_secret\_name) | Name of the secret containing the password of the 'dataiku' user of the Cloud SQL instance. | `string` | `""` | no |
| <a name="input_cloud_sql_instance_connection_name"></a> [cloud\_sql\_instance\_connection\_name](#input\_cloud\_sql\_instance\_connection\_name) | Name of the connection of a Cloud SQL instance to use for hosting the Dataiku internal database ('project\_id:region:instance\_name'). | `string` | `""` | no |
| <a name="input_data_disk_size"></a> [data\_disk\_size](#input\_data\_disk\_size) | Data disk size in GB for the Compute Engine instance. The GigaByte available to store Dataiku resources in the machine. The default value suits most of needs. | `number` | `1000` | no |
| <a name="input_dataiku_license_secret_name"></a> [dataiku\_license\_secret\_name](#input\_dataiku\_license\_secret\_name) | Name of secret containing Dataiku license in json format. Mandatory for Dataiku api node. It is use to set a license automatically when installing Dataiku. | `string` | n/a | yes |
| <a name="input_dataiku_setup_version"></a> [dataiku\_setup\_version](#input\_dataiku\_setup\_version) | Dataiku setup script version used to provision the Dataiku machine. Please go to https://github.com/lvmh-data/atom-dataiku-setup for more information. | `string` | `"12.6.3"` | no |
| <a name="input_dss_admin_email"></a> [dss\_admin\_email](#input\_dss\_admin\_email) | DSS admin email, it will be used as the first available mean of login to finalize the DSS configuration. | `string` | n/a | yes |
| <a name="input_format_map"></a> [format\_map](#input\_format\_map) | Map of naming convention format | `map(string)` | n/a | yes |
| <a name="input_format_values"></a> [format\_values](#input\_format\_values) | Map of naming convention values | `map(string)` | n/a | yes |
| <a name="input_gke_node_pools"></a> [gke\_node\_pools](#input\_gke\_node\_pools) | Map with k8s node-pool details | <pre>map(object({<br>    max_node_count = number<br>    machine_type   = string<br>    gpu_type       = string<br>    gpu_count      = number<br>  }))</pre> | `{}` | no |
| <a name="input_location"></a> [location](#input\_location) | Location. eg: EU | `string` | n/a | yes |
| <a name="input_machine_type"></a> [machine\_type](#input\_machine\_type) | Machine type used for the Compute Engine instance hosting Dataiku. It will affect the compute power available for running jobs with the DSS. | `string` | `"n1-standard-2"` | no |
| <a name="input_name"></a> [name](#input\_name) | Dataiku deployment name | `string` | n/a | yes |
| <a name="input_node_type"></a> [node\_type](#input\_node\_type) | Dataiku node type. It can be 'design', 'automation' or 'api'. See more here: https://doc.dataiku.com/dss/latest/deployment/index.html. | `string` | `"design"` | no |
| <a name="input_oidc_client_id"></a> [oidc\_client\_id](#input\_oidc\_client\_id) | OIDC client ID. The client ID generated by the IdP (Okta), enter the raw value. | `string` | n/a | yes |
| <a name="input_oidc_client_secret_name"></a> [oidc\_client\_secret\_name](#input\_oidc\_client\_secret\_name) | OIDC client secret name containing the client secret value generated by the IdP. The secret's value shall not start with a hyphen '-' | `string` | n/a | yes |
| <a name="input_okta_domain"></a> [okta\_domain](#input\_okta\_domain) | Okta domain. Your Okta domain (URL), looks like: `example.okta.com`, `okta.lvmh.com`... | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Project ID | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Region. eg: europe-west1 | `string` | n/a | yes |
| <a name="input_sentinel_one_token_name"></a> [sentinel\_one\_token\_name](#input\_sentinel\_one\_token\_name) | Sentinel one secret token name containing the SentinelOne site token. Used to install SentinelOne on the Dataiku machine, each Maison has a dedicated site token. If not provided neither Tanium nor SentineOne will be installed on the Dataiku VM. | `string` | `"FALSE"` | no |
| <a name="input_shared_vpc_name"></a> [shared\_vpc\_name](#input\_shared\_vpc\_name) | Shared VPC project name | `string` | n/a | yes |
| <a name="input_shared_vpc_project_id"></a> [shared\_vpc\_project\_id](#input\_shared\_vpc\_project\_id) | Shared VPC project ID | `string` | n/a | yes |
| <a name="input_shared_vpc_subnet_name"></a> [shared\_vpc\_subnet\_name](#input\_shared\_vpc\_subnet\_name) | Shared VPC subnet name | `string` | n/a | yes |
| <a name="input_shared_vpc_subnet_region"></a> [shared\_vpc\_subnet\_region](#input\_shared\_vpc\_subnet\_region) | Shared VPC subnet region | `string` | n/a | yes |
| <a name="input_source_bigquery_dataset"></a> [source\_bigquery\_dataset](#input\_source\_bigquery\_dataset) | Fusion: BigQuery dataset to import (no-copy). Old-Dataiku bigquery dataset to import for the Dataiku deployed. | <pre>object({<br>    dataset_id    = string<br>    location      = string<br>    friendly_name = string<br>    description   = string<br>  })</pre> | `null` | no |
| <a name="input_source_data_disk"></a> [source\_data\_disk](#input\_source\_data\_disk) | Fusion: Source disk to import (copy). Old-Dataiku data disk to use as a source for the Dataiku deployed. Format: 'zones/{zone}/disks/{disk}' or 'regions/{region}/disks/{disk}' | `string` | `""` | no |
| <a name="input_source_data_disk_type"></a> [source\_data\_disk\_type](#input\_source\_data\_disk\_type) | Fusion: To import a regional persistent disk you must specify its type otherwise the deployment will fail if it isn't a 'pd-standard' | `string` | `"pd-standard"` | no |
| <a name="input_source_storage_bucket"></a> [source\_storage\_bucket](#input\_source\_storage\_bucket) | Fusion: Storage bucket to import (no-copy). Old-Dataiku GCS bucket to import for the Dataiku deployed. | <pre>object({<br>    name     = string<br>    location = string<br>  })</pre> | `null` | no |
| <a name="input_ssl_certificate_secret_id"></a> [ssl\_certificate\_secret\_id](#input\_ssl\_certificate\_secret\_id) | Google Secret Manager SSL certificate secret ID containing the SSL certificate value in PEM format | `string` | n/a | yes |
| <a name="input_ssl_private_key_secret_id"></a> [ssl\_private\_key\_secret\_id](#input\_ssl\_private\_key\_secret\_id) | Google Secret Manager SSL private key secret ID containing the SSL private key value in PEM format | `string` | n/a | yes |
| <a name="input_start_stop"></a> [start\_stop](#input\_start\_stop) | Start/Stop schedule (cron format) | <pre>object({<br>    time_zone  = string<br>    start_time = string<br>    stop_time  = string<br>  })</pre> | `null` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | Zone. eg: europe-west1-b | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_forwarding_rule_ip"></a> [forwarding\_rule\_ip](#output\_forwarding\_rule\_ip) | n/a |


## Example usage

> See [example](example/main.tf)
