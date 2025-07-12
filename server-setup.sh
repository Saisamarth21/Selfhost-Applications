#!/bin/bash


# Clear the screen after showing the banner
clear

# Display ASCII Art Banner
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

# Section: Update System
echo ">> [Placeholder] Updating system..."
# sudo apt update && sudo apt upgrade -y

# Section: Install Basic Packages
echo ">> [Placeholder] Installing basic packages..."
# sudo apt install -y curl git vim htop

# Section: Configure Firewall
echo ">> [Placeholder] Configuring firewall..."
# sudo ufw allow OpenSSH
# sudo ufw enable

# Section: Create User
echo ">> [Placeholder] Creating user..."
# sudo adduser newuser

# Section: Setup SSH Keys
echo ">> [Placeholder] Setting up SSH keys..."
# mkdir /home/newuser/.ssh && chmod 700 /home/newuser/.ssh

# Section: Install Docker
echo ">> [Placeholder] Installing Docker..."
# curl -fsSL https://get.docker.com -o get-docker.sh
# sh get-docker.sh

# Section: Cleanup
echo ">> [Placeholder] Cleaning up..."
# rm -rf get-docker.sh

echo "✅ Server setup script initialized. Customize each section as needed."