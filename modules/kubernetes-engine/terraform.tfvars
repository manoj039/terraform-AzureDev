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

name                              = "gke-instance-1"
regional                          = false
zones                             = ["us-east1-a", "us-east1-b"]
network                           = "network-1"
subnetwork                        = "subnet-1"
ip_range_pods                     = "pod-subnet"
ip_range_services                 = "service-subnet"
create_service_account            = false
remove_default_node_pool          = false
horizontal_pod_autoscaling        = true
http_load_balancing               = false
network_policy                    = true
enable_private_endpoint           = true
enable_private_nodes              = true
master_ipv4_cidr_block            = "12.0.0.0/28"
enable_shielded_nodes             = true
release_channel                   = "STABLE"
enable_binary_authorization       = false
disable_legacy_metadata_endpoints = true
default_max_pods_per_node         = 32

node_pools_name           = "default-node-pool"
machine_type              = "e2-micro"
node_locations            = "us-east1-a,us-east1-b"
min_count                 = 1
max_count                 = 2
local_ssd_count           = 0
disk_size_gb              = 30
disk_type                 = "pd-standard"
image_type                = "COS_CONTAINERD"
auto_repair               = true
auto_upgrade              = true
service_account           = ""
preemptible               = false
initial_node_count        = 1 