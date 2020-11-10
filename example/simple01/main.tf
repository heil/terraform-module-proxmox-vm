module "deb-01-simple" {
  source = "git::https://github.com/heil/terraform-module-proxmox-vm//simple"

  template_name = "ubu20-cloudinit-template"
  vm_name       = "deb20-01-simple-thomas"

  datastore = "cf-nfs-ssd1"
  # datastore      = "pve-ssd-1"
  disk_format    = "qcow2"
  disk_size      = "40G"
  dns_server     = "1.1.1.1 8.8.8.8"
  domain_name    = "internal.olanis.de"
  network_bridge = "vmbr25"

  num_cores    = 4
  memory       = 4096
  pve_host     = var.pm_host
  pve_password = var.pm_password
  pve_user     = var.pve_user

  qemu_agent    = 1
  snippet_path  = "/mnt/pve/cf-nfs-ssd1"
  snippet_store = "cf-nfs-ssd1"
  storage_type  = "nfs"
  target_node   = var.pm_target
  vm_ipconfig0  = "ip=172.20.236.210/22,gw=172.20.239.254"
  vm_password   = "$6$$yzVX2JRM7tdY4JjJHmrumQZNz4qxf57zZ4K6pj/u2JYzWQEeGhHvbqugg789pGrOeBypCD1fNaz/ClY9BI2vJ/"

}
