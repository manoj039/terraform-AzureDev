/**
 * Copyright 2021 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

variable "project_id" {
  description = "The ID of the project in which to provision resources."
  type        = string
}

variable "names" {
  type        = list(string)
  description = "Names of the service accounts to create."
}

variable "project_roles" {
  type        = list(string)
  description = "Common roles to apply to all service accounts, project=>role as elements."
  default  = []
}

variable "display_name" {
  type        = string
  description = "Display names of the created service accounts (defaults to 'Terraform-managed service account')"
}

variable "description" {
  type        = string
  description = "Default description of the created service accounts (defaults to no description)"
  default     = ""
}

variable "buckets_iam" {
  description = "List of buckets & IAM permissions"
  type = list(object({
    project              = string
    bucket_name          = string
    create_bucket        = bool
    location             = optional(string)
    prefix               = optional(string)
    bucket_permissions   = optional(map(list(string)))
    versioning           = optional(map(bool))
    encryption_key_names = optional(map(string))

    lifecycle_rules = optional(set(object({
      action    = map(string)
      condition = map(string)
    })))

    admins                   = optional(list(string))
    bucket_admins            = optional(map(string))
    bucket_creators          = optional(map(string))
    bucket_hmac_key_admins   = optional(map(string))
    bucket_policy_only       = optional(map(bool))
    bucket_storage_admins    = optional(map(string))
    bucket_viewers           = optional(map(string))
    cors                     = optional(set(any))
    creators                 = optional(list(string))
    folders                  = optional(map(list(string)))
    force_destroy            = optional(map(bool))
    hmac_key_admins          = optional(list(string))
    labels                   = map(string)
    logging                  = optional(any)
    randomize_suffix         = optional(bool)
    retention_policy         = any
    set_admin_roles          = optional(bool)
    set_creator_roles        = optional(bool)
    set_hmac_key_admin_roles = optional(bool)
    set_storage_admin_roles  = optional(bool)
    set_viewer_roles         = optional(bool)
    storage_admins           = optional(list(string))
    storage_class            = optional(string)
    viewers                  = optional(list(string))
    website                  = optional(map(any))
    }
  ))
  validation {
    condition = length([
      for data in var.buckets_iam : true
      if contains(keys(data.labels), "app") && contains(keys(data.labels), "owner")]) == length(var.buckets_iam)
    error_message = "You must specify app and owner keys labels."
  }
}

/** Artifact Registry **/

variable "region" {
	description = "region where repository need to store"
  	type = string
}

variable "repository_id" {
	description = "repository name/id"
  type = string
}

variable "format" {
	description = "type of repository DOCKER or pip or other package"
	type = string
}

variable "repo_description" {
	default=""
}

/** Kubernetes Engine **/



variable "name" {
  type        = string
  description = "The name of the cluster (required)"
}



variable "regional" {
  type        = bool
  description = "Whether is a regional cluster (zonal cluster if set false. WARNING: changing this after cluster creation is destructive!)"
}

variable "zones" {
  type        = list(string)
  description = "The zones to host the cluster in (optional if regional cluster / required if zonal)"
}

variable "network" {
  type        = string
  description = "The VPC network to host the cluster in (required)"
}

variable "subnetwork" {
  type        = string
  description = "The subnetwork to host the cluster in (required)"
}

variable "ip_range_pods" {
  type        = string
  description = "The _name_ of the secondary subnet ip range to use for pods"
}

variable "ip_range_services" {
  type        = string
  description = "The _name_ of the secondary subnet range to use for services"
}

variable "create_service_account" {
  type        = bool
  description = "Defines if service account specified to run nodes should be created."
}

variable "remove_default_node_pool" {
  type        = bool
  description = "Remove default node pool while setting up the cluster"
}

variable "horizontal_pod_autoscaling" {
  type        = bool
  description = "Enable horizontal pod autoscaling addon"
}

variable "http_load_balancing" {
  type        = bool
  description = "Enable httpload balancer addon"
}

variable "network_policy" {
  type        = bool
  description = "Enable network policy addon"
}

variable "enable_private_endpoint" {
  type        = bool
  description = "(Beta) Whether the master's internal IP address is used as the cluster endpoint"
}

variable "enable_private_nodes" {
  type        = bool
  description = "(Beta) Whether nodes have internal IP addresses only"
}

variable "master_ipv4_cidr_block" {
  type        = string
  description = "(Beta) The IP range in CIDR notation to use for the hosted master network"
}

variable "enable_shielded_nodes" {
  type        = bool
  description = "Enable Shielded Nodes features on all nodes in this cluster"
}

variable "release_channel" {
  type        = string
  description = "The release channel of this cluster. Accepted values are `UNSPECIFIED`, `RAPID`, `REGULAR` and `STABLE`. Defaults to `UNSPECIFIED`."
}

variable "disable_legacy_metadata_endpoints" {
  type        = bool
  description = "Disable the /0.1/ and /v1beta1/ metadata server endpoints on the node. Changing this value will cause all node pools to be recreated."
}

variable "enable_binary_authorization" {
  description = "Enable BinAuthZ Admission controller"
}

variable "default_max_pods_per_node" {
  description = "The maximum number of pods to schedule per node"
}

variable "node_pools_name" {
  type        = string
  description = "Name of the node pool."
}

variable "machine_type" {
  type        = string
  description = "The type of machine."
}

variable "node_locations" {
  type        = string
  description = "The locations of node."
}

variable "min_count" {
  type        = number
  description = "Minimum node count."
}

variable "max_count" {
  type        = number
  description = "Maximum node count."
}

variable "local_ssd_count" {
  type        = number
  description = "local ssd count."
}

variable "disk_size_gb" {
  type        = number
  description = "disk_size_gb."
}

variable "disk_type" {
  type        = string
  description = "disk_type."
}

variable "image_type" {
  type        = string
  description = "image_type."
}

variable "auto_repair" {
  type        = bool
  description = "auto_repair"
}

variable "auto_upgrade" {
  type        = bool
  description = "auto_upgrade"
}

variable "preemptible" {
  type        = bool
  description = "preemptible"
}

variable "service_account" {
  type        = string
  description = "The service account to run nodes as if not overridden in `node_pools`. The create_service_account variable default value (true) will cause a cluster-specific service account to be created."
}

variable "initial_node_count" {
  type        = number
  description = "The number of nodes to create in this cluster's default node pool."
}

variable "node_pools" {
  type        = list(map(string))
  description = "List of maps containing node pools"

  default = [
    {
      name = "default-node-pool"
    },
  ]
}

variable "node_pools_oauth_scopes" {
  type        = map(list(string))
  description = "Map of lists containing node oauth scopes by node-pool name"

  # Default is being set in variables_defaults.tf
  default = {
    all               = ["https://www.googleapis.com/auth/cloud-platform"]
    default-node-pool = []
  }
}

variable "node_pools_labels" {
  type        = map(map(string))
  description = "Map of maps containing node labels by node-pool name"

  # Default is being set in variables_defaults.tf
  default = {
    all               = {}
    default-node-pool = {}
  }
}

variable "node_pools_metadata" {
  type        = map(map(string))
  description = "Map of maps containing node metadata by node-pool name"

  # Default is being set in variables_defaults.tf
  default = {
    all               = {}
    default-node-pool = {}
  }
}

variable "node_pools_taints" {
  type        = map(list(object({ key = string, value = string, effect = string })))
  description = "Map of lists containing node taints by node-pool name"

  # Default is being set in variables_defaults.tf
  default = {
    all               = []
    default-node-pool = []
  }
}

variable "node_pools_tags" {
  type        = map(list(string))
  description = "Map of lists containing node network tags by node-pool name"

  # Default is being set in variables_defaults.tf
  default = {
    all               = []
    default-node-pool = []
  }
}