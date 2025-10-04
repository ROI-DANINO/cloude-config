#!/bin/bash

# Claude Code Configuration Installer
# Symlinks project-level Claude configs to ~/.claude/

set -e

SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.claude" && pwd)"
TARGET_DIR="$HOME/.claude"

echo "Installing Claude Code configurations..."
echo "Source: $SOURCE_DIR"
echo "Target: $TARGET_DIR"
echo ""

# Create target directories if they don't exist
mkdir -p "$TARGET_DIR"

# Symlink context directory
if [ -d "$SOURCE_DIR/context" ]; then
    if [ -L "$TARGET_DIR/context" ] || [ -e "$TARGET_DIR/context" ]; then
        echo "⚠️  $TARGET_DIR/context already exists"
        read -p "Remove and replace? [y/N] " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            rm -rf "$TARGET_DIR/context"
            ln -s "$SOURCE_DIR/context" "$TARGET_DIR/context"
            echo "✓ Linked context/"
        else
            echo "⊘ Skipped context/"
        fi
    else
        ln -s "$SOURCE_DIR/context" "$TARGET_DIR/context"
        echo "✓ Linked context/"
    fi
fi

# Symlink agents directory
if [ -d "$SOURCE_DIR/agents" ]; then
    if [ -L "$TARGET_DIR/agents" ] || [ -e "$TARGET_DIR/agents" ]; then
        echo "⚠️  $TARGET_DIR/agents already exists"
        read -p "Remove and replace? [y/N] " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            rm -rf "$TARGET_DIR/agents"
            ln -s "$SOURCE_DIR/agents" "$TARGET_DIR/agents"
            echo "✓ Linked agents/"
        else
            echo "⊘ Skipped agents/"
        fi
    else
        ln -s "$SOURCE_DIR/agents" "$TARGET_DIR/agents"
        echo "✓ Linked agents/"
    fi
fi

# Symlink output-styles directory
if [ -d "$SOURCE_DIR/output-styles" ]; then
    if [ -L "$TARGET_DIR/output-styles" ] || [ -e "$TARGET_DIR/output-styles" ]; then
        echo "⚠️  $TARGET_DIR/output-styles already exists"
        read -p "Remove and replace? [y/N] " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            rm -rf "$TARGET_DIR/output-styles"
            ln -s "$SOURCE_DIR/output-styles" "$TARGET_DIR/output-styles"
            echo "✓ Linked output-styles/"
        else
            echo "⊘ Skipped output-styles/"
        fi
    else
        ln -s "$SOURCE_DIR/output-styles" "$TARGET_DIR/output-styles"
        echo "✓ Linked output-styles/"
    fi
fi

echo ""
echo "Installation complete!"
echo ""
echo "Usage:"
echo "  - Context files: Available via @-mention"
echo "  - Agents: Invoke with @agent-name"
echo "  - Output styles: Use with /style command or @-mention"
