#!/bin/bash

# Clear the screen after showing the banner
clear

echo "███████╗ █████╗ ██╗███████╗ █████╗ ███╗   ███╗ █████╗ ██████╗ ████████╗██╗  ██╗                "
echo "██╔════╝██╔══██╗██║██╔════╝██╔══██╗████╗ ████║██╔══██╗██╔══██╗╚══██╔══╝██║  ██║                "
echo "███████╗███████║██║███████╗███████║██╔████╔██║███████║██████╔╝   ██║   ███████║                "
echo "╚════██║██╔══██║██║╚════██║██╔══██║██║╚██╔╝██║██╔══██║██╔══██╗   ██║   ██╔══██║                "
echo "███████║██║  ██║██║███████║██║  ██║██║ ╚═╝ ██║██║  ██║██║  ██║   ██║   ██║  ██║                "
echo "╚══════╝╚═╝  ╚═╝╚═╝╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝                "
echo "                                                                                              "
echo "███████╗███████╗██████╗ ██╗   ██╗███████╗██████╗     ███████╗███████╗████████╗██╗   ██╗██████╗ "
echo "██╔════╝██╔════╝██╔══██╗██║   ██║██╔════╝██╔══██╗    ██╔════╝██╔════╝╚══██╔══╝██║   ██║██╔══██╗"
echo "███████╗█████╗  ██████╔╝██║   ██║█████╗  ██████╔╝    ███████╗█████╗     ██║   ██║   ██║██████╔╝"
echo "╚════██║██╔══╝  ██╔══██╗╚██╗ ██╔╝██╔══╝  ██╔══██╗    ╚════██║██╔══╝     ██║   ██║   ██║██╔═══╝ "
echo "███████║███████╗██║  ██║ ╚████╔╝ ███████╗██║  ██║    ███████║███████╗   ██║   ╚██████╔╝██║     "
echo "╚══════╝╚══════╝╚═╝  ╚═╝  ╚═══╝  ╚══════╝╚═╝  ╚═╝    ╚══════╝╚══════╝   ╚═╝    ╚═════╝ ╚═╝     "
echo ""

# Display script summary
 echo "******************************************"
 echo "Script automates:"
 echo "  - HTTP port enablement (iptables)"
 echo "  - Docker & Docker Compose installation"
 echo "  - Self-hosted app cloning & cleanup"
 echo "  - Interactive install/cleanup per app"
 echo "  - Bulk start of Docker Compose services"
 echo "******************************************"
 echo ""

# Prompt 1: Update iptables for HTTP
echo ">> Do you want to update iptables to allow HTTP (port 80)? [Y/n]"
read -r response
response=${response:-Y}
if [[ "$response" =~ ^[Yy]$ ]]; then
  echo ">> Updating system and iptables rules for HTTP..."
  sudo apt update
  sudo iptables -I INPUT 6 -m state --state NEW -p tcp --dport 80 -j ACCEPT
  sudo netfilter-persistent save
  echo "✅ HTTP port allowed."
else
  echo ">> Skipping iptables update."
fi

# Prompt 2: Install Docker
echo ">> Do you want to install Docker? [Y/n]"
read -r response
response=${response:-Y}
if [[ "$response" =~ ^[Yy]$ ]]; then
  echo ">> Installing Docker..."
  sudo apt update
  sudo apt install -y ca-certificates curl gnupg lsb-release
  sudo mkdir -p /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" |
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt update
  sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
  sudo usermod -aG docker $USER
  sudo curl -L "https://github.com/docker/compose/releases/download/v2.12.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
  docker-compose --version
  echo "✅ Docker installed."
else
  echo ">> Skipping Docker installation."
fi

# Section: Setup Selfhost Applications
echo ">> Setting up Selfhost-Applications directory..."
sudo chown $USER:$USER /opt
sudo chmod 755 /opt
sudo chown -R $USER:$USER /opt

# Clone the repository
if [ ! -d "/opt/Selfhost-Applications" ]; then
  git clone https://github.com/Saisamarth21/Selfhost-Applications.git /opt/Selfhost-Applications
  # Ensure /opt ownership and permissions
  sudo chown $USER:$USER /opt
  sudo chmod 755 /opt
  sudo chown -R $USER:$USER /opt
fi

cd /opt/Selfhost-Applications || exit 1
# Remove Git metadata and unwanted files
rm -rf .git
rm -f Readme.md server-setup.sh

echo ">> Cleaning up delete-this.txt files..."
count_before=$(find . -type f -name "delete-this.txt" | wc -l)
echo "Found $count_before delete-this.txt files. Removing..."
find . -type f -name "delete-this.txt" -exec rm -f {} \;
count_after=$(find . -type f -name "delete-this.txt" | wc -l)
echo "Remaining delete-this.txt files: $count_after"

# Prompt 3: Install applications one by one
echo ">> Processing available applications..."
for dir in */; do
  app=${dir%/}
  echo ">> Do you want to install $app? [Y/n]"
  read -r response
  response=${response:-Y}
  if [[ "$response" =~ ^[Yy]$ ]]; then
    echo "✅ $app kept."
  else
    echo "✅ $app removed."
    sudo rm -rf "$app"
  fi
done

# Prompt 4: Start all applications
echo ">> Do you want to start all applications? [Y/n]"
read -r response
response=${response:-Y}
if [[ "$response" =~ ^[Yy]$ ]]; then
  for dir in */; do
    if [[ -f "$dir/docker-compose.yml" ]]; then
      echo ">> Starting $dir"
      (cd "$dir" && docker-compose up -d)
    fi
  done
  echo "✅ All services have been started."
else
  echo "You can manually start via 'docker-compose up -d' in each folder."
fi

echo "🎉 Setup complete! Your server is fully configured and self-hosted applications are ready to use. 🎉"
