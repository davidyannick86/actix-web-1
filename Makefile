.PHONY: all build check clean doc run test watch release

# Default target
all: build

# Build the project in debug mode
build:
	cargo build

# Check if the project compiles
check:
	cargo check

# Clean build artifacts
clean:
	cargo clean

# Generate documentation
doc:
	cargo doc --no-deps
	cargo doc --open

# Run the project
run:
	cargo run

# Run tests
test:
	cargo test

# Watch for changes and rebuild
watch:
	cargo watch -x build

# Build with release optimization
release:
	cargo build --release

# Format code
fmt:
	cargo fmt

# Run clippy lints
lint:
	cargo clippy -- -D warnings

# Update dependencies
update:
	cargo update

# Build and run in release mode
run-release: release
	cargo run --release