#!/bin/bash

# Development container setup script for isa_container project
set -e

echo "🚀 Setting up isa_container development environment..."

# Ensure uv is in PATH
export PATH="$HOME/.cargo/bin:$PATH"

# Install project dependencies
echo "📦 Installing Python dependencies..."
cd /workspaces/isa_container

# Check if uv is available, if not install it
if ! command -v uv &> /dev/null; then
    echo "🐍 Installing uv (Python package manager)..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
    export PATH="$HOME/.cargo/bin:$PATH"
fi

# Sync dependencies
uv sync

# Create necessary directories
echo "📁 Creating necessary directories..."
mkdir -p .vscode

# Set proper permissions
echo "🔒 Setting permissions..."
chmod +x /workspaces/isa_container/.devcontainer/post_create.sh

# Create a sample .env file if it doesn't exist
if [ ! -f ".env" ]; then
    echo "🔐 Creating .env file from template..."
    cp .env.template .env
fi

echo "✅ Developer environment setup complete!"
echo ""
echo "🎯 Next steps:"
echo "1. Configure your .env file with actual credentials"
echo "2. Run 'uv run python -m src.main --help' to see available commands"
echo "3. Start coding! 🚀"
echo ""

echo "📝 Available commands:"
echo "  - uv sync                    # Install/update dependencies"
echo "  - uv run ruff check          # Lint code"
echo "  - uv run ruff format         # Format code"
echo "  - uv run pyright             # Type checking"
echo "  - uv run python -m src.main  # Run main application"