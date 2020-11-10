# Example simple01

- create a file `terraform.tfvars`

```
pm_api_url  = "https://172.20.235.191:8006/api2/json"
#the url of the proxmox api

pm_user     = "terraform@pam"
#the user for the proxmox api

pve_user    = "terraform"
#the user for uploading snippets (`user-data`)

pm_password =  "very!secretPwforTerraform-User!"
# Password for the API and or the `pm_host`

pm_host     =  "172.20.235.191"  
#"<IP-Address of one Proxmox Host"
#We use this Host to upload the "snippet" for the `user-data`

pm_target   = "pve-hv-1"
#pm_target = "<name of the Host in the proxmox Datacenter e.g pve-hv-1"
```

- now lets create a simple `vm`

```
module "deb-01-simple" {
  source = "git::https://github.com/heil/terraform-module-proxmox-vm//simple"

  template_name = "ubu20-cloudinit-template"
  vm_name       = "deb20-01-simple-thomas"

  datastore = "cf-nfs-ssd1"
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
```

 - template_name - The Template from which we are creating the vm
 - vm_name - the name of the `vm`
 - datastore - the name of the datastore for disk (should be the same that we used to create the template)
 - disk_format - can be qcow2|raw|wmdk (depends on storage, use raw if qcow2 throws error)
 - disk_size - resize the disk from the template to this size (you can use K M or G)
 - dns_server = use this dns_servers (cloud-init)
 - domain_name = use this domain (cloud-int)
 - network_bridge = proxmox uses vmbr0 to vmbrXXX (use the right one)
 - num_cores - numbers of cores (e.g. 2 or 4)
 - memory - Memory in Megabytes
 - pve_host - Host for Uploading the snippets (user-data)
 - pve_password - Password for Uploading user-data and or the api
 - pve_user - user for uploading snippets (works only via sftp at the moment)
 - qemu_agent - use the qemu_agen 0|1
 - snippet_path - the prefix for the snippet path
 - storage_type - can be nfs lvmthin lvm ....
 - target_node - on which proxmox host the vm shall be created (use the name you will find for the hosts in the Server-View)
 - vm_ipconfig0 - Network Config for Nic0 in the given format
 - vm_password - encrypted Password for cloud-init
