#!/bin/bash

# Manual config copier for Distrobox containers
# Usage: ./copy-configs-to-distrobox.sh <container-name>

# Check if container name is provided
if [ -z "$1" ]; then
    echo "Error: Please specify a container name"
    echo "Usage: $0 <container-name> <container-image>"
    exit 1
fi

if [ -z "$2" ]; then
    echo "Error: Please specify a container image"
    echo "Usage: $0 <container-name> <container-image>"
    exit 1
fi

CONTAINER_NAME=$1
CONTAINER_HOME="$HOME/.distrobox/$CONTAINER_NAME"
IMAGE=$2

if distrobox list | grep -qw "$CONTAINER_NAME"; then
    echo "Container $CONTAINER_NAME already exists"
else 
    distrobox create \
    --name "$CONTAINER_NAME" \
    --image "$IMAGE" \
    --home "$HOME/.distrobox/$CONTAINER_NAME"

fi

# Check if container home exists
if [ ! -d "$CONTAINER_HOME" ]; then
    echo "Error: Container directory $CONTAINER_HOME not found"
    exit 1
fi

# List of config files/dirs to copy (add more as needed)
CONFIG_FILES=(
    .zshrc
    .oh-my-zsh
)

echo "Copying configs to $CONTAINER_HOME:"

# Copy each config file/directory
for item in "${CONFIG_FILES[@]}"; do
    # Check if source exists
    if [ -e "$HOME/$item" ]; then
        echo "-> Copying $item..."
        
        # Handle directories differently
        if [ -d "$HOME/$item" ]; then
            rsync -a --delete "$HOME/$item/" "$CONTAINER_HOME/$item/"
        else
            cp -f "$HOME/$item" "$CONTAINER_HOME/$item"
        fi
    else
        echo "-> Skipping $item (not found in home directory)"
    fi
done

# Adds cd ~ to .zshrc if it existss
if [ -e "$CONTAINER_HOME/.zshrc" ]; then
    echo "Adding 'cd ~' to .zshrc"
    echo "cd ~" >> "$CONTAINER_HOME/.zshrc"
fi

# Oh My Zsh handling
if [ -d "$CONTAINER_HOME/.oh-my-zsh" ]; then
    echo "Oh My Zsh already exists in container"
else
    echo "Installing Oh My Zsh in container..."
    distrobox enter "$CONTAINER_NAME" -- bash -c \
        'git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh'
fi

echo "Config copy complete!"
echo "Enter container to verify: distrobox enter $CONTAINER_NAME"