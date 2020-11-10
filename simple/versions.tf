terraform {
  required_providers {
    proxmox = {
      # source  = "Telmate/proxmox"
      # version = "2.6.0"

      source  = "registry.example.com/telmate/proxmox"
      version = ">=1.0.0"
    }
  }
  required_version = ">= 0.13"
}
