#!/bin/bash

# Copy .zshrc and .oh-my-zsh from /tmp to the bind-mounted home directory
set -x
echo "Copying .zshrc and .oh-my-zsh from /tmp..."
\cp -f /tmp/.zshrc ~/.zshrc 2>/dev/null
rm -rf ~/.oh-my-zsh 2>/dev/null
cp -r /tmp/.oh-my-zsh ~/.oh-my-zsh 2>/dev/null

# Append configurations to .zshrc (only if missing)
echo "Updating .zshrc..."
grep -qxF 'export PATH="$HOME/.local/bin:$PATH"' ~/.zshrc || echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
grep -qxF 'cd ~' ~/.zshrc || echo 'cd ~' >> ~/.zshrc

# Fix permissions (critical for bind-mounted directories)
chmod 644 ~/.zshrc 2>/dev/null
chmod -R 755 ~/.oh-my-zsh 2>/dev/null
