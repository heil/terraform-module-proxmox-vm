terraform {
  required_providers {
    proxmox = {
      # TF-UPGRADE-TODO
      #
      # No source detected for this provider. You must add a source address
      # in the following format:
      #
      source  = "terraform.example.com/telmate/proxmox"
      version = ">=1.0.0"
      # For more information, see the provider source documentation:
      #
      # https://www.terraform.io/docs/configuration/providers.html#provider-source
    }
  }
  required_version = ">= 0.13"
}
