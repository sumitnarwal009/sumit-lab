# --- Filled in from the running Proxmox instance (Acemagic host via Tailscale) ---
# Still needed from you: the real secret half of the API token below.
# Proxmox only shows a token's secret once, at creation time - if you don't have
# it saved, generate a new one for this token (or a new token) in
# Datacenter > Permissions > API Tokens.
#
# NOTE: this file will hold a real secret once filled in. Even though this repo is
# private, avoid committing a real API token here long-term; consider passing
# proxmox_api_token via an environment variable (TF_VAR_proxmox_api_token) or a
# separate untracked *.auto.tfvars file instead.

proxmox_api_url      = "https://100.116.18.19:8006/api2/json"
proxmox_api_token    = "root@pam!terraform=a4bf51ad-4e98-48fd-9c4a-71f25d9b6f93"
proxmox_tls_insecure = true

proxmox_node   = "Acemagic"
template_vm_id = 199

vm_name   = "terraform-vm"
vm_id     = null
vm_cores  = 2
vm_memory = 2048

disk_datastore = "local-lvm"
disk_size      = 20

network_bridge = "vmbr0"
vm_ip_address  = "dhcp"
vm_gateway     = null
