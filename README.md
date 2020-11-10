# terraform-module-proxmox-vm

## Linux AMD64 Install

Iam hoping we get the first stable binary release so we can stop
building the source code.
...

```
cd /tmp
git clone https://github.com/heil/terraform-module-proxmox-vm.git
cd terraform-module-proxmox-vm
PLUGIN_ARCH=linux_amd64
mkdir -p ~/.terraform.d/plugins/registry.example.com/telmate/proxmox/1.0.0/$PLUGIN_ARCH
cp ./bin/linux_amd64/* ~/.terraform.d/plugins/registry.example.com/telmate/proxmox/1.0.0/$PLUGIN_ARCH
```

## simple and block

Module `terraform-proxmox-virtual-machine` is a universal module that can be
used to deploy proxmox virtual machines from a Linux-based template based off of a cloud img. Link: [Proxmox Cloud-Init Support](https://pve.proxmox.com/wiki/Cloud-Init_Support)

This makes use of the following resources and data sources within the
[Terraform Proxmox Provider](https://github.com/Telmate/terraform-provider-proxmox):

* [Resource VM QEMU](https://github.com/Telmate/terraform-provider-proxmox/blob/master/proxmox/resource_vm_qemu.go)

In order to use this module, ensure that you have configured the Proxmox
provider as per the instructions seen [Terraform Proxmox Provider](https://github.com/Telmate/terraform-provider-proxmox).


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| datastore | The Storage Pool to deploy the virtual machines to. | string | - | yes |


## Usage

```lang=hcl
terraform {
  required_providers {
    proxmox = {
      source  = "terraform.example.com/telmate/proxmox"
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
}
```

```
terraform {
  required_version = ">= 0.13"
}
```

### type simple

* Example [simple01](example/simple01/)


### type block


```
module "deb-01-block" {
  source        = "git::https://github.com/heil/terraform-module-proxmox-vm//block"
  template_name = "ubuntu-2004-cloudinit-template"
  vm_name       = "deb-01-block-terraform"

  pve_user     = var.pve_user
  pve_password = var.pm_password
  pve_host     = var.pm_host
  vm_password  = "$6$$yzVX2JRM7tdY4JjJHmrumQZNz4qxf57zZ4K6pj/u2JYzWQEeGhHvbqugg789pGrOeBypCD1fNaz/ClY9BI2vJ/"
  qemu_agent   = 1
  vm_ipconfig0 = "ip=192.168.54.142/24,gw=192.168.54.1"

  data_disk_mount = "/data/mariadb"
}
```
