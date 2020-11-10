terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "2.6.3"
    }
  }
  required_version = ">= 0.13"
}
