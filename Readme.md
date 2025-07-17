# Server Setup Automation Script

![Server Setup Demo](./video.gif)

This Bash `server-setup.sh` script automates the provisioning and management of a self-hosted server environment. It provides interactive prompts and executes the following tasks:
    
1. **HTTP Port Enablement**: Optionally opens port 80 via iptables.
    
2. **Docker Installation**: Optionally installs Docker Engine, CLI, and Docker Compose.
    
3. **Selfhosted Applications Setup**:
    
    - Ensures proper ownership and permissions for `/opt`.
        
    - Clones the `Selfhost-Applications` repository into `/opt`.
        
    - Cleans up Git metadata, README, and unwanted files.
        
    - Recursively removes any `delete-this.txt` files.
        
4. **Interactive App Management**: Prompts to keep or remove each application folder (e.g., Portainer, Watchtower, Immich, Nextcloud, etc.).
    
5. **Bulk Service Startup**: Optionally runs `docker-compose up -d` in each application directory containing a `docker-compose.yml`.

---

## Features
    
- **Interactive Prompts**: Defaults to “Y” for most operations, allowing you to skip steps easily.
    
- **Idempotent Directory Handling**: Won’t re-clone if the directory already exists.
    
- **Safe Cleanup**: Confirms before removing application directories.
    
- **Bulk Orchestration**: Starts all Docker Compose services in one go.
    
---

## Usage

```bash
curl -L -o server-setup.sh https://raw.githubusercontent.com/Saisamarth21/Selfhost-Applications/refs/heads/main/server-setup.sh
```

```bash
chmod +x server-setup.sh
```

```bash
./server-setup.sh
```

## Requirements

- Ubuntu or Debian-based Linux
    
- `bash` shell
    
- `sudo` privileges

---

## Self-Hosted Applications Included

The script manages the following apps:

- Portainer
    
- Watchtower
    
- Immich
    
- Nextcloud
    
- File Browser
    
- Glance Dashboard
    
- JDownloader2
    
- Jenkins
    
- Nginx Proxy Manager
    
- SonarQube
    
- Rancher
    
- TinyAuth

- Dozzle 

- Cup

- Jellyfin

- Paperless-ngx

- n8n

- Visual Studio Code

- Cup updates

- Uptime kuma