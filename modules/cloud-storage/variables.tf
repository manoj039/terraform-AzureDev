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
