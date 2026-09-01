# --- Fill these in with your real Proxmox environment details ---
# NOTE: this file will hold real connection info once filled in.
# Even though this repo is private, avoid committing a real API token here long-term;
# consider passing proxmox_api_token via an environment variable
# (TF_VAR_proxmox_api_token) or a separate untracked *.auto.tfvars file instead.

proxmox_api_url      = "https://YOUR-PROXMOX-HOST:8006/api2/json"
proxmox_api_token    = "user@pve!tokenid=00000000-0000-0000-0000-000000000000"
proxmox_tls_insecure = true

proxmox_node   = "pve"
template_vm_id = 9000

vm_name   = "terraform-vm"
vm_id     = null
vm_cores  = 2
vm_memory = 2048

disk_datastore = "local-lvm"
disk_size      = 20

network_bridge = "vmbr0"
vm_ip_address  = "dhcp"
vm_gateway     = null
