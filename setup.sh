#!/bin/bash

set -euo pipefail

echo "🔧 Starting workstation setup..."

# Install pipx if not present
if ! command -v pipx &>/dev/null; then
    echo "🐍 Installing pipx..."
    sudo dnf install pipx
    pipx ensurepath
fi

# Install Ansible if not present
if ! command -v ansible &>/dev/null; then
    echo "📦 Installing Ansible..."
    pipx install --include-deps ansible ansible-lint
    sudo dnf install python3-libdnf5
fi

# Install Ansible Galaxy requirements if present and not empty
if [[ -s requirements.yml ]]; then
    echo "⬇️  Installing Ansible Galaxy requirements..."
    ansible-galaxy install -r requirements.yml
fi

# Run the Ansible playbook
echo "🚀 Running Ansible playbook..."
ansible-playbook  main.yml --ask-become-pass