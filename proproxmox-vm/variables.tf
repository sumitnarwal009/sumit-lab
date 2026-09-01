variable "proxmox_api_url" {
  description = "URL of the Proxmox API, e.g. https://192.168.1.10:8006/api2/json"
  type        = string
}

variable "proxmox_api_token" {
  description = "Proxmox API token in the form 'user@realm!tokenid=uuid-secret'"
  type        = string
  sensitive   = true
}

variable "proxmox_tls_insecure" {
  description = "Skip TLS certificate verification (true for self-signed certs on a home lab)"
  type        = bool
  default     = true
}

variable "proxmox_node" {
  description = "Name of the Proxmox node to deploy the VM on"
  type        = string
}

variable "template_vm_id" {
  description = "VM ID of the cloud-init template to clone"
  type        = number
}

variable "vm_id" {
  description = "VM ID for the new VM (leave null to let Proxmox auto-assign one)"
  type        = number
  default     = null
}

variable "vm_name" {
  description = "Name of the VM"
  type        = string
  default     = "terraform-vm"
}

variable "vm_cores" {
  description = "Number of CPU cores"
  type        = number
  default     = 2
}

variable "vm_memory" {
  description = "Amount of RAM in MB"
  type        = number
  default     = 2048
}

variable "disk_datastore" {
  description = "Proxmox storage/datastore for the VM disk"
  type        = string
  default     = "local-lvm"
}

variable "disk_size" {
  description = "Disk size in GB"
  type        = number
  default     = 20
}

variable "network_bridge" {
  description = "Proxmox network bridge to attach the VM to"
  type        = string
  default     = "vmbr0"
}

variable "vm_ip_address" {
  description = "Static IP in CIDR form (e.g. 192.168.1.50/24), or 'dhcp'"
  type        = string
  default     = "dhcp"
}

variable "vm_gateway" {
  description = "Gateway IP for the VM's network (leave null when using dhcp)"
  type        = string
  default     = null
}
