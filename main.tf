terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = "3.0.1-rc4"
    }
  }
}

provider "proxmox" {
  pm_api_url = "https://192.168.8.133:8006/api2/json"
  pm_api_token_id = "terraform@pam!tf-token"
  pm_api_token_secret = "fad8d5f8-0c9f-45d7-8128-14a9a6ef432d"
  pm_tls_insecure = true
}

resource "proxmox_lxc" "kontainer_docker" {
  target_node  = "zli"
  
  vmid         = 2000 
  
  hostname     = "vps-4"
  ostemplate   = "ssd-0:vztmpl/debian-12-standard_12.12-1_amd64.tar.zst"
  password     = "fazli2005"
  unprivileged = true
  
  # features {
  #   nesting = true
  #   keyctl  = true
  # }

  cores  = 1
  memory = 512
  swap   = 512

  rootfs {
    storage = "ssd-0"
    size    = "4G"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "192.168.8.200/24" 
    gw     = "192.168.8.1"
  }
  
  start = true

  # provisioner "remote-exec" {
  #   connection {
  #     type     = "ssh"
  #     user     = "root"
  #     password = "fazli2005"
  #     host     = "192.168.8.200"
  #   }

  #   inline = [
  #     # 1. Update Repo
  #     "echo '>>> [1/5] Update Repository...'",
  #     "apt update", 
  #     "apt upgrade -y",
      
  #     # 2. Install Dependencies
  #     "echo '>>> [2/5] Install Curl & Neofetch...'",
  #     "apt install -y neofetch curl",
      
  #     # 3. Install Docker
  #     "echo '>>> [3/5] Install Docker...'",
  #     "curl -fsSL https://get.docker.com | sh",
      
  #     # 4. Install Tailscale
  #     "echo '>>> [4/5] Install Tailscale...'",
  #     "curl -fsSL https://tailscale.com/install.sh | sh",
      
  #     "mkdir -p /dev/net",
  #     "mknod /dev/net/tun c 10 200 || true", 

  #     # "neofetch --off",
  #     # "docker --version",
  #     # "tailscale --version"
  #   ]
  # }
}