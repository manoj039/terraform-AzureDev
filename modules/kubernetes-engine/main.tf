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

 data "google_client_config" "default" {}

provider "kubernetes" {
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}

module "gke" {
  source                     = "terraform-google-modules/kubernetes-engine/google//modules/beta-private-cluster"
  project_id                 = var.project_id
  name                       = var.name 
  region                     = var.region
  zones                      = var.zones 
  network                    = var.network
  subnetwork                 = var.subnetwork
  ip_range_pods              = var.ip_range_pods
  ip_range_services          = var.ip_range_services
  http_load_balancing        = var.http_load_balancing
  horizontal_pod_autoscaling = var.horizontal_pod_autoscaling
  network_policy             = var.network_policy
  enable_private_endpoint    = var.enable_private_endpoint
  enable_private_nodes       = var.enable_private_nodes
  master_ipv4_cidr_block     = var.master_ipv4_cidr_block

  node_pools = [
    {
      name                      = var.node_pools_name #"default-node-pool"
      machine_type              = var.machine_type
      node_locations            = var.node_locations
      min_count                 = var.min_count
      max_count                 = var.max_count
      local_ssd_count           = var.local_ssd_count
      disk_size_gb              = var.disk_size_gb
      disk_type                 = var.disk_type
      image_type                = var.image_type
      auto_repair               = var.auto_repair
      auto_upgrade              = var.auto_upgrade
      service_account           = var.service_account 
      preemptible               = var.preemptible
      initial_node_count        = var.initial_node_count
    },
  ]

  node_pools_oauth_scopes = {
    all = []

    default-node-pool = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  node_pools_labels = {
    all = {}

    default-node-pool = {
      default-node-pool = true
    }
  }

  node_pools_metadata = {
    all = {}

    default-node-pool = {
      node-pool-metadata-custom-value = "my-node-pool"
    }
  }

  node_pools_taints = {
    all = []

    default-node-pool = [
      {
        key    = "default-node-pool"
        value  = true
        effect = "PREFER_NO_SCHEDULE"
      },
    ]
  }

  node_pools_tags = {
    all = []

    default-node-pool = [
      "default-node-pool",
    ]
  }
}