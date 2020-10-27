
data "template_file" "cloudinit" {
  template = file("${path.module}../templates/cloudinit.yml")
  vars = {

    hostname    = var.vm_name
    domain_name = var.domain_name
    password    = var.vm_password
  }
}

data "template_cloudinit_config" "cloudinit" {
  base64_encode = false
  gzip          = false

  part {
    content      = data.template_file.cloudinit.rendered
    content_type = "text/cloud-config"
  }
}


resource "local_file" "template_cloudinit_out" {
  content  = data.template_cloudinit_config.cloudinit.rendered
  filename = "${path.module}..//templates/cloudinit-out-${var.vm_name}.yml"
}

# Transfer the file to the Proxmox Host
resource "null_resource" "cloudinit" {
  connection {
    type     = "ssh"
    user     = var.pve_user
    password = var.pve_password
    host     = var.pve_host
    agent    = false
  }

  provisioner "file" {
    source      = local_file.template_cloudinit_out.filename
    destination = "/var/lib/vz/snippets/cloudinit-out-${var.vm_name}.yml"
  }

  depends_on = [
    local_file.template_cloudinit_out
  ]

}

resource "proxmox_vm_qemu" "virtual_machine" {

  name = var.vm_name

  # Node name has to be the same name as within the cluster
  # this might not include the FQDN
  target_node = var.target_node

  # The destination resource pool for the new VM
  pool = var.resource_pool

  full_clone = true

  # The template name to clone this vm from
  clone = var.template_name

  # Activate QEMU agent for this VM
  agent = var.qemu_agent

  os_type  = "cloud-init"
  cores    = var.num_cores
  sockets  = var.num_sockets
  vcpus    = var.num_cores
  cpu      = "host"
  memory   = var.memory
  scsihw   = "virtio-scsi-pci"
  bootdisk = "virtio0"

  # Setup the disk. The id has to be unique
  disk {
    id           = 0
    size         = var.disk_size
    type         = "virtio"
    format       = var.disk_format
    storage      = var.datastore
    storage_type = var.storage_type
    iothread     = false
    backup       = false
  }

  lifecycle {
    ignore_changes = [
      network, cipassword
    ]
  }

  # Setup the network interface and assign a vlan tag: 256
  network {
    id     = 0
    model  = "virtio"
    bridge = var.network_bridge
  }

  cicustom = "user=local:snippets/cloudinit-out-${var.vm_name}.yml"

  # Setup the ip address using cloud-init.
  # Keep in mind to use the CIDR notation for the ip.
  ipconfig0    = "ip=dhcp"
  nameserver   = var.dns_server
  searchdomain = var.domain_name
  sshkeys      = file(var.ssh_public_key)
}
