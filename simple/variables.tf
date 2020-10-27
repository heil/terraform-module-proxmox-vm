variable "domain_name" {
  type        = string
  default     = "example.com"
  description = "DNS Domain"
}

variable "dns_server" {
  type        = string
  description = "The DNS Server to use."
  default     = "192.168.2.1"
}

variable "resource_pool" {
  type        = string
  default     = "devops"
  description = "A logical group of containers and VMs "
}

variable "template_name" {
  type        = string
  description = "The template to clone from. Refer to Create Template.sh for creating a template."
}

variable "memory" {
  type        = number
  description = "The RAM in MB."
  default     = 1024
}

variable "num_cores" {
  type        = number
  description = "Number of cores per socket"
  default     = 2
}

variable "num_sockets" {
  type        = number
  description = "Number of sockets"
  default     = "1"
}

variable "vm_count" {
  type        = string
  description = "Number of virtual machines to create"
  default     = 0
}

variable "datastore" {
  type        = string
  description = "Storage pool where virtual machines will live."
  default     = "local-lvm"
}

variable "qemu_agent" {
  type        = number
  description = "Whether the qemu agent is running 1 = on, 0 = off"
  default     = 0
}

variable "disk_format" {
  type        = string
  description = "The virtual disk format. raw, qcow2, and vmdk"
  default     = "raw"
}

variable "disk_size" {
  type        = number
  description = "The main disk size in GB"
  default     = 10
}

variable "ssh_public_key" {
  type        = string
  description = "The ssh public key to use for auth."
  default     = "~/.ssh/id_rsa.pub"
}

variable "storage_type" {
  type        = string
  description = "The Storage Type."
  default     = "lvmthin"
}

variable "vm_password" {
  type        = string
  description = "cloud-init password"
  default     = "$6$$yzVX2JRM7tdY4JjJHmrumQZNz4qxf57zZ4K6pj/u2JYzWQEeGhHvbqugg789pGrOeBypCD1fNaz/ClY9BI2vJ/"
}

variable "vm_name" {
  type        = string
  description = "The name of the virtual machine"
  default     = "example-vm"
}

variable "network_bridge" {
  type        = string
  description = "The bridge to attach the networking too."
  default     = "vmbr0"
}

variable "target_node" {
  type        = string
  description = "The node to deploy virtual machines to."
  default     = "pve"
}


variable "pve_user" {
}

variable "pve_host" {
}

variable "pve_password" {
}


variable "vm_ipconfig0" {
  default = "ip=dhcp"
}
