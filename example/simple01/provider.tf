terraform {
  required_providers {
    proxmox = {
      # source  = "Telmate/proxmox"
      # version = "2.6.0"

      source  = "registry.example.com/telmate/proxmox"
      version = ">=1.0.0"
    }
    local = {
      source = "hashicorp/local"
    }
    null = {
      source = "hashicorp/null"
    }
    template = {
      source = "hashicorp/template"
    }
  }
  required_version = ">= 0.13"
}

provider "proxmox" {
  pm_parallel     = 1
  pm_tls_insecure = true
  pm_api_url      = var.pm_api_url
  pm_password     = var.pm_password
  pm_user         = var.pm_user
}
