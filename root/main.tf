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
 
/******************************************
	Service Account resource
 *****************************************/
 
  module "service_account" {
  source     = "../modules/service-account"
  project_id = var.project_id
  names       = var.names
  display_name  = var.display_name
  description   = var.description
}


/******************************************
	Cloud Storage Bucket
 *****************************************/
 
module "gcs" {
  source      = "../modules/cloud-storage"
  buckets_iam = var.buckets_iam
}

/******************************************
	Artifact Registry
 *****************************************/

module "artifact_registry" {
  source             = "../modules/artifact_registry"
  project_id         = var.project_id
  region             = var.region
  repository_id      = var.repository_id
  repo_description   = var.repo_description
  format             = var.format
 }

 /******************************************
	Kubernetes Engine
 *****************************************/

 /**module "kubernetes-engine" {
  source             = "../modules/kubernetes-engine"
  project_id         = var.project_id
  region             = var.region
  zones              = var.zones
  name                = var.name
  network             = var.network
  subnetwork          = var.subnetwork
  ip_range_pods       = var.ip_range_pods
  ip_range_services   = var.ip_range_services
  master_ipv4_cidr_block           = var.master_ipv4_cidr_block

  
  gke_service_account = module.service_account.gke_sa_email
  devops_project_id   = var.devops_project_id
 } **/