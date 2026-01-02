.PHONY: build serve publish install clean help

# Default target
help:
	@echo "Available commands:"
	@echo "  make build     - Build the game to .rbxl file"
	@echo "  make serve     - Start Rojo server for live sync"
	@echo "  make publish   - Build and publish to Roblox"
	@echo "  make install   - Install all tools from foreman.toml"
	@echo "  make clean     - Remove build artifacts"
	@echo "  make format    - Format all Lua files with StyLua"
	@echo "  make lint      - Lint all Lua files with Selene"

# Build the game
build:
	@echo "Building game..."
	rojo build -o roblox-game-1.rbxl default.project.json
	@echo "✓ Build complete!"

# Start Rojo server
serve:
	@echo "Starting Rojo server..."
	rojo serve

# Build and publish to Roblox
publish: build
	@echo "Publishing to Roblox..."
	@./publish.sh

# Install tools
install:
	@echo "Installing tools..."
	foreman install
	@echo "✓ Tools installed!"

# Clean build artifacts
clean:
	@echo "Cleaning build artifacts..."
	rm -f roblox-game-1.rbxl
	rm -f sourcemap.json
	@echo "✓ Cleaned!"

# Format code
format:
	@echo "Formatting Lua files..."
	stylua src/
	@echo "✓ Formatting complete!"

# Lint code
lint:
	@echo "Linting Lua files..."
	selene src/
	@echo "✓ Linting complete!"
