# Proxmox VM Provisioning (Terraform)

This folder provisions a virtual machine on a Proxmox host by cloning an existing template — using Terraform instead of clicking through the Proxmox web UI.

## What is Proxmox?

Proxmox VE is the hypervisor running on the `Acemagic` host — think of it as the operating system for your physical server, whose whole job is to carve that one machine up into multiple virtual machines. It has its own web UI and its own API; everything in this folder talks to that API rather than to the web UI directly.

## What is Terraform doing here?

Terraform is "infrastructure as code": instead of clicking "Create VM" in the Proxmox UI and remembering what you picked, you describe the VM you want in a file, and Terraform figures out how to make Proxmox match that description. Run it again later with a change, and Terraform only changes what's different — it won't recreate the VM from scratch.

Here specifically, Terraform doesn't build a VM from an ISO — it **clones a template**. VM `199` on the `Acemagic` node is that template: a pre-built VM with cloud-init support, kept powered off, that new VMs are copied from. Cloning a template is faster and more consistent than a fresh OS install every time.

## What each file does

Terraform splits configuration into three files by convention — each with a different job:

### `main.tf` — the blueprint

Defines *what gets built*: which provider talks to Proxmox (`bpg/proxmox`), and the VM resource itself — that it's a clone of the template, how many cores and how much RAM it gets, its disk, which network bridge it plugs into, and its IP configuration. Nothing in this file is a real value — everything is a `var.something`, filled in from `variables.tf` and `terraform.tfvars`. This is the file you'd edit to change *how* a VM is built (e.g. add a second disk).

### `variables.tf` — the contract

Declares every variable `main.tf` is allowed to use: its name, its type (string, number, bool), a description, and — for the ones with sensible defaults (like `vm_cores = 2` or `disk_datastore = "local-lvm"`) — a default value. Variables without a default (`proxmox_api_url`, `proxmox_node`, `template_vm_id`, `proxmox_api_token`) are *required*: Terraform will refuse to run until they're supplied. This file never contains real values, just the shape of what's expected. `proxmox_api_token` is marked `sensitive = true` so Terraform hides it from console output and logs.

### `terraform.tfvars` — the real values

The actual settings for *this* environment: the real Proxmox endpoint (`https://100.116.18.19:8006/api2/json`, reached over Tailscale), the real node name (`Acemagic` — note the capital A, Proxmox node names are case-sensitive), the real template ID (`199`), and the real API token. Terraform loads this file automatically because of its name. This is the file you'd edit to point at a different Proxmox host, use a different template, or change the VM's size — without touching the logic in `main.tf`.

> **Security note:** `terraform.tfvars` holds a real API token in plain text. This repo is private, but a token in git history doesn't stop being sensitive just because the repo is private — if you ever suspect it's leaked, revoke and reissue it from Proxmox under *Datacenter → Permissions → API Tokens*. Longer term, consider moving the token out of this file entirely (an environment variable, `TF_VAR_proxmox_api_token`, or a separate untracked `*.auto.tfvars` file) and adding a `.gitignore` entry so a fresh `terraform apply` can't accidentally commit a rotated secret back into git.
>
> ## Running it
>
> ```
> terraform init    # downloads the bpg/proxmox provider
> terraform plan    # shows what Terraform would create/change, without doing it
> terraform apply   # asks for confirmation, then actually creates the VM
> ```
>
> `terraform apply` will also create `terraform.tfstate` locally — Terraform's record of what it built and the current real-world values (including, again, the sensitive token). It isn't meant to be committed to git either.
>
> ## See also
>
> For the full story of how this got set up — the broken files this replaced, the Proxmox permission grant the API token needed, and a walkthrough of a real `plan`/`apply` run — see the *Proxmox Terraform Runbook* doc from that session.
> 
