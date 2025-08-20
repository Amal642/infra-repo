# main.tf

# 1. Configure Terraform and the Google Provider
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.10.0" # Use a recent version
    }
  }
}

provider "google" {
  # Your gcloud CLI authentication will be used automatically
  project = "bricbybric-platform" # <-- VERY IMPORTANT: CHANGE THIS
  region  = "asia-east1-a"             # You can choose a region closer to you
}

# 2. Define the Kubernetes Cluster (GKE)
resource "google_container_cluster" "primary" {
  name     = "platform-cluster-1"
  location = "asia-east1-a"
  
  # Set deletion_protection to false to allow the cluster to be destroyed
  deletion_protection = false
  
  # We are removing the default node pool so we can create our own custom ones. This is a best practice.
  remove_default_node_pool = true
  initial_node_count       = 1

  # This configures the cluster to use a private network, which is a key security requirement.
  private_cluster_config {
    enable_private_nodes  = true
    enable_private_endpoint = false # Keep the endpoint public for now for easy access
    master_ipv4_cidr_block = "172.16.0.0/28"
  }

  # Enable the autoscaler for our node pools
  cluster_autoscaling {
    enabled = true
    resource_limits {
      resource_type = "cpu"
      minimum       = 1
      maximum       = 10
    }
    resource_limits {
      resource_type = "memory"
      minimum       = 1
      maximum       = 40 # In Gigabytes
    }
  }
}

# 3. Create a dedicated node pool for our applications
resource "google_container_node_pool" "default_pool" {
  name       = "default-pool"
  location   = google_container_cluster.primary.location
  cluster    = google_container_cluster.primary.name
  node_count = 1

  node_config {
    machine_type = "e2-medium" # A good general-purpose and cost-effective machine type
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}

# 4. Create a dedicated node pool for our infrastructure (ArgoCD, Istio, etc.)
resource "google_container_node_pool" "infra_pool" {
  name       = "infra-pool"
  location   = google_container_cluster.primary.location
  cluster    = google_container_cluster.primary.name
  node_count = 1

  node_config {
    machine_type = "e2-medium"
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
