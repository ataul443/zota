#!/bin/sh

set -e

# Check for debug flag
DEBUG=false
if [ "$1" = "-d" ] || [ "$1" = "--debug" ]; then
    DEBUG=true
    shift
fi

# Debug function to show command and exit code
debug_cmd() {
    if [ "$DEBUG" = "true" ]; then
        echo "[DEBUG] Running: $*" >&2
    fi
    "$@"
    exit_code=$?
    if [ "$DEBUG" = "true" ]; then
        echo "[DEBUG] Exit code: $exit_code" >&2
    fi
    return $exit_code
}

INSTALL_DIR="$HOME/.zota"
SCRIPT_NAME="zota"
GITHUB_REPO="ataul443/zota"
# Get version from git tags, removing 'v' prefix
RELEASE_VERSION=$(git describe --tags --abbrev=0 2>/dev/null | sed 's/^v//' || echo "0.1.0")

echo "Installing zota..."

# Create installation directory
debug_cmd mkdir -p "$INSTALL_DIR"

# Copy zota script from current directory
echo "Installing zota script..."
if [ -f "./$SCRIPT_NAME" ]; then
    debug_cmd cp "./$SCRIPT_NAME" "$INSTALL_DIR/$SCRIPT_NAME"
else
    echo "Error: Could not find zota script in current directory" >&2
    exit 1
fi

# Update version in the downloaded script
debug_cmd sed -i.bak "s/VERSION=\"0.1.0\"/VERSION=\"$RELEASE_VERSION\"/" "$INSTALL_DIR/$SCRIPT_NAME"
debug_cmd rm -f "$INSTALL_DIR/$SCRIPT_NAME.bak"

# Make it executable
debug_cmd chmod +x "$INSTALL_DIR/$SCRIPT_NAME"

# Copy commands folder
if [ -d "./commands" ]; then
    echo "Copying commands folder..."
    debug_cmd cp -r "./commands" "$INSTALL_DIR/"
else
    echo "Error: commands folder not found" >&2
fi

# Copy agents folder
if [ -d "./agents" ]; then
    echo "Copying agents folder..."
    debug_cmd cp -r "./agents" "$INSTALL_DIR/"
else
    echo "Error: agents folder not found" >&2
fi

# Copy scripts folder
if [ -d "./scripts" ]; then
    echo "Copying scripts folder..."
    debug_cmd cp -r "./scripts" "$INSTALL_DIR/"
    debug_cmd chmod +x "$INSTALL_DIR/scripts/"*.sh
else
    echo "Error: scripts folder not found" >&2
fi

# Copy zota.md
if [ -f "./zota.md" ]; then
    echo "Copying zota.md..."
    debug_cmd cp "./zota.md" "$INSTALL_DIR/"
else
    echo "Error: zota.md not found" >&2
fi

# Function to add to PATH in a shell config file
add_to_path() {
    shell_config="$1"
    path_export="export PATH=\"\$HOME/.zota:\$PATH\""
    
    if [ -f "$shell_config" ]; then
        # Check if already in PATH
        if ! debug_cmd grep -q ".zota" "$shell_config"; then
            debug_cmd sh -c "echo '' >> '$shell_config'"
            debug_cmd sh -c "echo '# Added by zota installer' >> '$shell_config'"
            debug_cmd sh -c "echo '$path_export' >> '$shell_config'"
            echo "Added zota to PATH in $shell_config"
        else
            echo "zota already in PATH in $shell_config"
        fi
    fi
}

# Add to both .bashrc and .zshrc
debug_cmd add_to_path "$HOME/.bashrc"
debug_cmd add_to_path "$HOME/.zshrc"

# Create version info file
echo "Creating version info..."
cat > "$INSTALL_DIR/version.info" << EOF
Version: $RELEASE_VERSION
Commit: $(git rev-parse --short HEAD 2>/dev/null || echo "unknown")
Date: $(date -u +"%Y-%m-%dT%H:%M:%SZ")
Ref: main
EOF

# Export PATH for current session
export PATH="$HOME/.zota:$PATH"

echo ""
echo "zota has been installed successfully!"
echo ""
echo "Version: $RELEASE_VERSION"
echo ""
echo "Available commands:"
echo "  zota init             - Initialize zota in current directory"
echo "  zota new <name>       - Create a new project"
echo "  zota update [commit]  - Update zota to latest or specific version"
echo "  zota update-projects  - Update all registered projects"
echo "  zota list             - List all registered projects"
echo "  zota --version        - Show version info"
echo ""
echo "You need to restart your terminal or run:"
echo "  source ~/.bashrc  (for bash)"
echo "  source ~/.zshrc   (for zsh)"