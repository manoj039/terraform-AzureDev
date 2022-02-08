buckets_iam = [
  {
      ## BUCKET WITH ALL THE INPUT ATTRIBUTES
      ## AS SPECIIFIED IN THE TERRAFORM GOOGLE MODULES DOCS
    bucket_name   = "europe-nextflow-dummy-gsb-standard-001"
    project       = "ace-ripsaw-311918"
    create_bucket = true
    location      = "EU"
    prefix        = ""

    /*encryption_key_names = {
      gsk-prod-bucket-01 = "projects/cvs-edp-ext-prj-7331/locations/us/keyRings/suhail-demo-key-ring/cryptoKeys/suhail-demo-key"
    }*/
    versioning = {
      europe-nextflow-dummy-gsb-standard-001 = true
    }
    bucket_permissions = {
      "roles/storage.admin" = [
        "user:manoj.sdm@gmail.com",
      ]
    }
    lifecycle_rules = [{
      action = {
        type          = "SetStorageClass"
        storage_class = "NEARLINE"
      }
      condition = {
        age                   = "10"
        matches_storage_class = "MULTI_REGIONAL,STANDARD,DURABLE_REDUCED_AVAILABILITY"
      }
    }]

    labels = {
      app = "nextflow"
      owner      = "my"
    }

    admins                   = []
    bucket_admins            = {}
    bucket_creators          = {}
    bucket_hmac_key_admins   = {}
    bucket_policy_only       = {}
    bucket_storage_admins    = {}
    bucket_viewers           = {}
    randomize_suffix         = false
    retention_policy         = {}
    set_admin_roles          = false
    set_creator_roles        = false
    set_hmac_key_admin_roles = false
    set_storage_admin_roles  = false
    set_viewer_roles         = false
    storage_admins           = []
    storage_class            = "STANDARD"
    viewers                  = []
    website                  = {}
  },
]

/** Service Account **/
project_id    = "ace-ripsaw-311918" #"gcp-gskspeedboats"
names         = ["gs-hpc-objectCreator-01"] #["sa-account-prod"]
display_name  = "Service Account for HPC server" #"GSK Service Account"
description   = "To run copy to GCS script on HPC server" #"Service Account for handling Cloud Storage Buckets"

/** Artifact Registry **/
region               = "us-east1"
repository_id        = "my-repository"
format               = "DOCKER"
repo_description     = "Docker image repo"

/** GKE Cluster **/

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