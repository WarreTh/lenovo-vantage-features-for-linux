#!/bin/bash

# Define required packages
PACKAGES="tlp python3-pyqt5 acpi-call-dkms tlp-rdw upower"

# Detect the Linux distribution
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
else
    echo "Unsupported Linux distribution."
    exit 1
fi

echo "Detected OS: $OS"
echo "Installing required dependencies..."

# Install dependencies based on the package manager
case $OS in
    ubuntu|debian|linuxmint|pop|elementary|zorin)
        sudo apt update
        sudo apt install -y $PACKAGES
        ;;
    arch|manjaro|cachyos|endeavouros|garuda)
        # For Arch-based distros, acpi-call-dkms might be in the AUR
        # This script assumes it's in the official repositories or a user-configured repo.
        sudo pacman -Syu --noconfirm $PACKAGES
        ;;
    fedora|nobara|rhel|centos|rocky|almalinux)
        sudo dnf install -y $PACKAGES
        ;;
    opensuse|sles|opensuse-tumbleweed)
        sudo zypper install -y $PACKAGES
        ;;
    *)
        echo "Unsupported Linux distribution: $OS"
        echo "You may need to install the following packages manually for your distribution:"
        echo "$PACKAGES"
        exit 1
        ;;
esac

echo "Installation complete! ✅"
