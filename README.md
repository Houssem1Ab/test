# atom-terraform-modules

## Description

Repository for the terraform modules mainly backing atm.

Most of these can be either deployed using the [atm command line tool](https://github.com/lvmh-data/atom-atm) (ask atom team read permissions if you encounter an *`http-404-not-found`* error).

However, feel free to use them directly in your terraform code if it's something you are more comfortable with.

## Requirements

- [terraform](https://www.terraform.io/downloads.html) >= `1.4`
- [terraform-provider-google](https://registry.terraform.io/providers/hashicorp/google/4.75.1) >= `4.75.1`
- *(for documentation only)* [terraform-docs](https://terraform-docs.io/user-guide/installation/) == `latest`
## Usage

```hcl
/*
* Example with the naming module
* Change GITHUB_READ_TOKEN with token value and TAG_OR_BRANCH with the tag or branch name you want to use for the module.
* You can use the value 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 for the Github READ token.
*/

module "my_compute_name" {
  source    = "git::https://GITHUB_READ_TOKEN@github.com/lvmh-data/atom-terraform-modules//src/utils/naming?ref=TAG_OR_BRANCH" # Choose either tag or branch name.

  format_map    = local.format_map
  format_values = local.format_values

  type_trigram = "gce"
  name         = local.name
}
```

## Modules

| Module (link) | Description |
| - | - |
| [batch_vpc](src/batch_vpc/README.md) | Create a VPC ready to use with Cloud Batch. |
| [dataiku](src/dataiku/README.md) | Dataiku deployment on a private network (optional gke support). |
| [dataform/schedule](src/dataform/schedule/README.md) | Dataform flow scheduling using Workflows. |
| [dataplex](src/dataplex/README.md) | Plug-and-play data quality checks for Customer data using Dataplex. |
| [genai_components](src/genai_components/README.md) | Deploy GenAI components into cloud Run (Session memory and prompt store) |
| [gke](src/gke/README.md) | Deploys a GKE Cluster in private mode. |
| [ingress](src/ingress/README.md) | Deploys a load balancer with a single HTTPS endpoint. |
| [run_job_scheduler](src/run_job_scheduler/README.md) | Schedule the execution of a Cloud Run Job. |
| [run_service](src/run_service/README.md) | Cloud Run Service simple deployment. Creates a dedicated service account. |
| [sensitive_data_protection](src/sensitive_data_protection/README.md) | Secure PII and business critical data with column-level access control. |
| [utils/naming](src/utils/naming/README.md) | Naming utilities for naming conventions. |
| [utils/services](src/utils/services/README.md) | Service module that enables most of the google apis needed to deploy other modules. |
