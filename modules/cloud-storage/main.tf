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

locals {
  buckets = {
    for a in var.buckets_iam : a.bucket_name => { for x, y in a : x => y if x != "bucket_permissions" } if a.create_bucket == true
  }

  buckets_iam_bindings = {
    for x in var.buckets_iam : x.bucket_name => x.bucket_permissions
  }
}

module "gcs_buckets" {
  source               = "terraform-google-modules/cloud-storage/google"
  version              = "~> 2.2"
  for_each             = local.buckets
  project_id           = each.value.project
  names                = [each.key]
  prefix               = each.value.prefix != null ? each.value.prefix : ""
  location             = each.value.location
  encryption_key_names = each.value.encryption_key_names != null ? each.value.encryption_key_names : {}
  versioning           = each.value.versioning != null ? each.value.versioning : {}
  lifecycle_rules      = each.value.lifecycle_rules != null ? each.value.lifecycle_rules : []

  admins                   = each.value.admins != null ? each.value.admins : []
  bucket_admins            = each.value.bucket_admins != null ? each.value.bucket_admins : {}
  bucket_creators          = each.value.bucket_creators != null ? each.value.bucket_creators : {}
  bucket_hmac_key_admins   = each.value.bucket_hmac_key_admins != null ? each.value.bucket_hmac_key_admins : {}
  bucket_policy_only       = each.value.bucket_policy_only != null ? each.value.bucket_policy_only : {}
  bucket_storage_admins    = each.value.bucket_storage_admins != null ? each.value.bucket_storage_admins : {}
  bucket_viewers           = each.value.bucket_viewers != null ? each.value.bucket_viewers : {}
  cors                     = each.value.cors != null ? each.value.cors : []
  creators                 = each.value.creators != null ? each.value.creators : []
  folders                  = each.value.folders != null ? each.value.folders : {}
  force_destroy            = each.value.force_destroy != null ? each.value.force_destroy : {}
  hmac_key_admins          = each.value.hmac_key_admins != null ? each.value.hmac_key_admins : []
  labels                   = each.value.labels != null ? each.value.labels : {}
  logging                  = each.value.logging != null ? each.value.logging : {}
  randomize_suffix         = false #each.value.randomize_suffix != null ? each.value.randomize_suffix : false
  retention_policy         = each.value.retention_policy != null ? each.value.retention_policy : {}
  set_admin_roles          = each.value.set_admin_roles != null ? each.value.set_admin_roles : false
  set_creator_roles        = each.value.set_creator_roles != null ? each.value.set_creator_roles : false
  set_hmac_key_admin_roles = each.value.set_hmac_key_admin_roles != null ? each.value.set_hmac_key_admin_roles : false
  set_storage_admin_roles  = each.value.set_storage_admin_roles != null ? each.value.set_storage_admin_roles : false
  set_viewer_roles         = each.value.set_viewer_roles != null ? each.value.set_viewer_roles : false
  storage_admins           = each.value.storage_admins != null ? each.value.storage_admins : []
  storage_class            = each.value.storage_class != null ? each.value.storage_class : "STANDARD"
  viewers                  = each.value.viewers != null ? each.value.viewers : []
  website                  = each.value.website != null ? each.value.website : {}

}

module "storage_bucket-iam-bindings" {
  source          = "terraform-google-modules/iam/google//modules/storage_buckets_iam"
  for_each        = local.buckets_iam_bindings
  storage_buckets = [each.key]
  mode            = "authoritative"
  bindings        = each.value
  depends_on = [
    module.gcs_buckets
  ]
}
