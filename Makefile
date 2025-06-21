.PHONY: help install generate lint format breaking clean

# Default target
help:
	@echo "Available commands:"
	@echo "  install    - Install buf CLI"
	@echo "  generate   - Generate code from proto files"
	@echo "  lint       - Lint proto files"
	@echo "  format     - Format proto files"
	@echo "  breaking   - Check for breaking changes"
	@echo "  clean      - Clean generated files"
	@echo "  mod-update - Update buf dependencies"

# Install buf CLI
install:
	@echo "Installing buf CLI..."
	@curl -sSL \
		"https://github.com/bufbuild/buf/releases/latest/download/buf-$(shell uname -s)-$(shell uname -m)" \
		-o "$$HOME/.local/bin/buf" && \
	chmod +x "$$HOME/.local/bin/buf"
	@echo "buf CLI installed successfully!"

# Generate code from proto files
generate:
	@echo "Generating code from proto files..."
	buf generate
	@echo "Code generation completed!"

# Lint proto files
lint:
	@echo "Linting proto files..."
	buf lint
	@echo "Linting completed!"

# Format proto files
format:
	@echo "Formatting proto files..."
	buf format -w
	@echo "Formatting completed!"

# Check for breaking changes
breaking:
	@echo "Checking for breaking changes..."
	buf breaking --against '.git#branch=main'
	@echo "Breaking changes check completed!"

# Clean generated files
clean:
	@echo "Cleaning generated files..."
	rm -rf gen/
	@echo "Clean completed!"

# Update buf dependencies
mod-update:
	@echo "Updating buf dependencies..."
	buf mod update
	@echo "Dependencies updated!"

# Show buf version
version:
	@echo "buf version:"
	buf --version

# Initialize new proto file
init-proto:
	@echo "Creating new proto file..."
	@read -p "Enter proto file name (without .proto): " name; \
	mkdir -p proto/$$name; \
	echo "syntax = \"proto3\";" > proto/$$name/$$name.proto; \
	echo "" >> proto/$$name/$$name.proto; \
	echo "package $$name.v1;" >> proto/$$name/$$name.proto; \
	echo "" >> proto/$$name/$$name.proto; \
	echo "option go_package = \"github.com/your-org/proto/gen/$$name/v1;$${name}v1\";" >> proto/$$name/$$name.proto; \
	echo "Proto file proto/$$name/$$name.proto created!" 