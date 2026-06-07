# IPv6-Only Tools - Comprehensive Justfile
# Advanced automation recipes for IPv6 networking toolkit

# Default recipe - show help
default:
    @just --list --unsorted

# ============================================================================
# SETUP & INSTALLATION
# ============================================================================

# Complete development environment setup
setup: install-deps install-python install-deno install-nickel setup-podman
    @echo "✓ Development environment ready"
    @just verify-setup

# Install all system dependencies
install-deps:
    @echo "Installing system dependencies..."
    sudo apt-get update || true
    sudo apt-get install -y python3 python3-pip go podman jq curl wget || true

# Install Python package and dependencies
install-python *FLAGS:
    @echo "Installing Python package..."
    pip install {{FLAGS}} -e .

# Install Python with dev dependencies
install-dev:
    @just install-python "-e .[dev]"

# Install Deno runtime
install-deno:
    @echo "Installing Deno..."
    curl -fsSL https://deno.land/install.sh | sh || echo "Deno may already be installed"

# Install Nickel language
install-nickel:
    @echo "Installing Nickel..."
    cargo install nickel-lang-cli || echo "Install Rust first: curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh"

# Setup Podman and pull Wolfi base image
setup-podman:
    @echo "Setting up Podman..."
    podman pull cgr.dev/chainguard/wolfi-base:latest || true

# Verify installation of all components
verify-setup:
    @echo "Verifying setup..."
    @python3 --version || echo "❌ Python not found"
    @deno --version || echo "❌ Deno not found"
    @go version || echo "❌ Go not found"
    @podman --version || echo "❌ Podman not found"
    @nickel --version || echo "⚠️  Nickel not found (optional)"

# ============================================================================
# PYTHON DEVELOPMENT
# ============================================================================

# Run all Python tests
test-python *ARGS:
    pytest tests/python/ {{ARGS}}

# Run tests with verbose output
test-python-verbose:
    @just test-python "-v"

# Run specific test file
test-file FILE:
    pytest tests/python/{{FILE}} -v

# Run tests with coverage
coverage *ARGS:
    pytest tests/python/ --cov=ipv6tools --cov-report=html --cov-report=term {{ARGS}}
    @echo "Coverage report: htmlcov/index.html"

# Run tests and open coverage report
coverage-view: coverage
    xdg-open htmlcov/index.html || open htmlcov/index.html || echo "Open htmlcov/index.html manually"

# Watch tests (requires pytest-watch)
watch-tests:
    pytest-watch tests/python/ -v

# ============================================================================
# GO DEVELOPMENT
# ============================================================================

# Build all Go tools
build-go: build-ping build-scan build-trace build-lookup

# Build IPv6 ping tool
build-ping:
    @echo "Building ipv6-ping..."
    cd src/go && go build -o ../../bin/ipv6-ping -ldflags="-s -w" ./cmd/ipv6-ping

# Build IPv6 scanner
build-scan:
    @echo "Building ipv6-scan..."
    cd src/go && go build -o ../../bin/ipv6-scan -ldflags="-s -w" ./cmd/ipv6-scan

# Build IPv6 traceroute
build-trace:
    @echo "Building ipv6-trace..."
    cd src/go && go build -o ../../bin/ipv6-trace -ldflags="-s -w" ./cmd/ipv6-trace

# Build IPv6 DNS lookup tool
build-lookup:
    @echo "Building ipv6-lookup..."
    cd src/go && go build -o ../../bin/ipv6-lookup -ldflags="-s -w" ./cmd/ipv6-lookup

# Run Go tests
test-go:
    cd src/go && go test -v ./...

# Run Go tests with coverage
test-go-coverage:
    cd src/go && go test -v -coverprofile=coverage.out ./...
    cd src/go && go tool cover -html=coverage.out -o coverage.html

# Build all Go tools with race detector
build-go-race:
    cd src/go && go build -race -o ../../bin/ipv6-ping-race ./cmd/ipv6-ping
    cd src/go && go build -race -o ../../bin/ipv6-scan-race ./cmd/ipv6-scan

# ============================================================================
# RESCRIPT/DENO WEB DEVELOPMENT
# ============================================================================

# Build ReScript web application
build-rescript:
    @echo "Building ReScript application..."
    cd src/rescript && deno task build

# Run Deno web server
serve-web PORT="8000":
    @echo "Starting web server on http://localhost:{{PORT}}"
    cd src/web && deno run --allow-net --allow-read server.ts --port {{PORT}}

# Watch and rebuild ReScript on changes
watch-rescript:
    cd src/rescript && deno task watch

# Bundle web application for distribution
bundle-web:
    @echo "Bundling web application..."
    cd src/web && deno bundle app.ts bundle.js

# Check Deno code formatting
check-deno:
    deno fmt --check src/web/ src/rescript/

# Format Deno code
fmt-deno:
    deno fmt src/web/ src/rescript/

# Lint Deno code
lint-deno:
    deno lint src/web/ src/rescript/

# ============================================================================
# CODE QUALITY & LINTING
# ============================================================================

# Run all linters
lint: lint-python lint-go lint-shell lint-deno

# Lint Python code
lint-python:
    @echo "Linting Python..."
    flake8 src/python/ipv6tools/
    pylint src/python/ipv6tools/ || true

# Lint Go code
lint-go:
    @echo "Linting Go..."
    cd src/go && go vet ./...
    cd src/go && golint ./... || true

# Lint shell scripts
lint-shell:
    @echo "Linting shell scripts..."
    shellcheck src/scripts/*.sh || true

# Format all code
format: format-python format-go fmt-deno

# Format Python code
format-python:
    @echo "Formatting Python..."
    black src/python/ipv6tools/
    isort src/python/ipv6tools/

# Format Go code
format-go:
    @echo "Formatting Go..."
    cd src/go && gofmt -w .

# Type check Python
typecheck-python:
    mypy src/python/ipv6tools/

# Run security checks
security: security-python security-go

# Security scan Python
security-python:
    @echo "Scanning Python for security issues..."
    bandit -r src/python/ipv6tools/ -f json -o security-python.json || true
    safety check || true

# Security scan Go
security-go:
    @echo "Scanning Go for security issues..."
    cd src/go && gosec ./... || true

# ============================================================================
# RSR COMPLIANCE
# ============================================================================

# Run RSR (Rhodium Standard Repository) compliance verification
rsr-verify:
    @echo "Running RSR compliance verification..."
    python src/python/ipv6tools/rsr_verify.py

# Run RSR verification with JSON output
rsr-verify-json:
    @echo "Running RSR compliance verification (JSON)..."
    python src/python/ipv6tools/rsr_verify.py --json

# ============================================================================
# BENCHMARKING & PERFORMANCE
# ============================================================================

# Run Python benchmarks
benchmark ITERATIONS="10000":
    python -m ipv6tools.benchmark -n {{ITERATIONS}}

# Quick benchmark
benchmark-quick:
    @just benchmark 1000

# Comprehensive benchmark with comparison
benchmark-full:
    python -m ipv6tools.benchmark -n 50000 --compare

# Profile Python code
profile SCRIPT:
    python -m cProfile -o profile.stats {{SCRIPT}}
    python -c "import pstats; p = pstats.Stats('profile.stats'); p.sort_stats('cumulative'); p.print_stats(20)"

# Benchmark Go tools
benchmark-go:
    cd src/go && go test -bench=. -benchmem ./...

# ============================================================================
# PODMAN CONTAINER OPERATIONS
# ============================================================================

# Build Podman container with Wolfi base
container-build TAG="latest":
    @echo "Building container with Chainguard Wolfi..."
    podman build -f Containerfile -t ipv6-only:{{TAG}} .

# Run container interactively
container-run TAG="latest":
    podman run -it --rm --name ipv6-tools ipv6-only:{{TAG}}

# Run container with IPv6 networking
container-run-ipv6 TAG="latest":
    podman run -it --rm --name ipv6-tools --network slirp4netns:enable_ipv6=true ipv6-only:{{TAG}}

# Execute command in running container
container-exec CMD:
    podman exec -it ipv6-tools {{CMD}}

# Build and push to registry
container-push REGISTRY TAG="latest":
    @just container-build {{TAG}}
    podman tag ipv6-only:{{TAG}} {{REGISTRY}}/ipv6-only:{{TAG}}
    podman push {{REGISTRY}}/ipv6-only:{{TAG}}

# Scan container for vulnerabilities
container-scan TAG="latest":
    podman run --rm -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy image ipv6-only:{{TAG}}

# Export container to tarball
container-export TAG="latest" FILE="ipv6-only.tar":
    podman save -o {{FILE}} ipv6-only:{{TAG}}
    @echo "Container exported to {{FILE}}"

# Clean up containers and images
container-clean:
    podman container prune -f
    podman image prune -f

# ============================================================================
# NICKEL CONFIGURATION MANAGEMENT
# ============================================================================

# Generate configuration from Nickel
config-generate:
    @echo "Generating configurations from Nickel..."
    nickel export < config/ipv6-tools.ncl > config/generated/config.json
    nickel export --format yaml < config/ipv6-tools.ncl > config/generated/config.yaml

# Validate Nickel configuration
config-validate:
    @echo "Validating Nickel configuration..."
    nickel typecheck config/ipv6-tools.ncl

# Query Nickel configuration
config-query FIELD:
    nickel query config/ipv6-tools.ncl {{FIELD}}

# Generate network configs from templates
config-network SITE:
    nickel export < config/networks/{{SITE}}.ncl > config/generated/{{SITE}}-network.json

# ============================================================================
# DOCUMENTATION
# ============================================================================

# Build all AsciiDoc documentation
docs-build:
    @echo "Building AsciiDoc documentation..."
    asciidoctor docs/*.adoc -D build/docs/

# Build specific doc
docs-build-file FILE:
    asciidoctor docs/{{FILE}}.adoc -o build/docs/{{FILE}}.html

# Build documentation as PDF
docs-pdf:
    asciidoctor-pdf docs/*.adoc -D build/docs/pdf/

# Watch and rebuild docs on changes
docs-watch:
    @echo "Watching docs for changes..."
    ls docs/*.adoc | entr just docs-build

# Validate AsciiDoc syntax
docs-validate:
    @echo "Validating AsciiDoc..."
    find docs -name "*.adoc" -exec asciidoctor --safe-mode secure -o /dev/null {} \;

# Generate man pages
docs-man:
    @echo "Generating man pages..."
    asciidoctor -b manpage docs/man/*.adoc -D build/man/

# Serve docs locally
docs-serve PORT="8080":
    @just docs-build
    cd build/docs && python3 -m http.server {{PORT}}

# ============================================================================
# TESTING & VALIDATION
# ============================================================================

# Run all tests
test: test-python test-go test-integration

# Run integration tests
test-integration:
    @echo "Running integration tests..."
    pytest tests/integration/ -v

# Run end-to-end tests
test-e2e:
    @echo "Running E2E tests..."
    pytest tests/e2e/ -v --browser firefox

# Test CLI tools
test-cli:
    @echo "Testing CLI tools..."
    ./tests/cli/test-all.sh

# Test web interface
test-web:
    cd src/web && deno test --allow-net --allow-read

# Validate all examples run without error
test-examples:
    @echo "Testing examples..."
    for f in examples/*.py; do echo "Testing $f"; python "$f" || exit 1; done

# ============================================================================
# HURRICANE ELECTRIC INTEGRATION
# ============================================================================

# Setup Hurricane Electric tunnel
he-setup TUNNEL_ID USER PASS:
    @echo "Setting up HE tunnel {{TUNNEL_ID}}..."
    ./scripts/he-tunnel-setup.sh {{TUNNEL_ID}} {{USER}} {{PASS}}

# Update HE tunnel endpoint
he-update-endpoint TUNNEL_ID:
    @echo "Updating HE tunnel endpoint..."
    ./scripts/he-update-endpoint.sh {{TUNNEL_ID}}

# Check HE tunnel status
he-status:
    @echo "Checking HE tunnel status..."
    ./scripts/he-check-status.sh

# Get HE certification progress
he-cert-status USER:
    @echo "Checking IPv6 Certification progress..."
    ./scripts/he-cert-check.sh {{USER}}

# Run HE connectivity tests
he-test:
    @echo "Testing HE tunnel connectivity..."
    ping6 -c 4 2001:470:0:76::2

# ============================================================================
# NETWORK OPERATIONS
# ============================================================================

# Comprehensive network diagnostics
diag:
    @echo "Running IPv6 diagnostics..."
    sudo ./src/scripts/ipv6-diag.sh

# Quick connectivity check
diag-quick:
    ./src/scripts/ipv6-diag.sh --quick

# Show IPv6 configuration
net-show:
    sudo ./src/scripts/ipv6-config.sh show

# Enable IPv6
net-enable:
    sudo ./src/scripts/ipv6-config.sh enable

# Enable privacy extensions
net-privacy:
    sudo ./src/scripts/ipv6-config.sh enable-privacy

# Configure static address
net-static IFACE ADDR PREFIX:
    sudo ./src/scripts/ipv6-config.sh static {{IFACE}} {{ADDR}} {{PREFIX}}

# Scan network for IPv6 hosts
net-scan NETWORK:
    ./bin/ipv6-scan -n {{NETWORK}} -p 80,443,22

# Ping IPv6 address
net-ping ADDR COUNT="4":
    ./bin/ipv6-ping -c {{COUNT}} {{ADDR}}

# ============================================================================
# CLI TOOL OPERATIONS
# ============================================================================

# Calculate subnet information
calc NETWORK *FLAGS:
    python -m ipv6tools.cli calc {{NETWORK}} {{FLAGS}}

# Validate IPv6 addresses
validate *ADDRS:
    python -m ipv6tools.cli validate {{ADDRS}}

# Generate IPv6 addresses
generate TYPE *FLAGS:
    python -m ipv6tools.cli generate {{TYPE}} {{FLAGS}}

# Security audit
audit TARGET *FLAGS:
    python -m ipv6tools.security {{TARGET}} {{FLAGS}}

# DNS operations
dns HOSTNAME *FLAGS:
    python -m ipv6tools.dns {{HOSTNAME}} {{FLAGS}}

# Network simulation
simulate PREFIX HOSTS="5":
    python -m ipv6tools.simulator -n {{PREFIX}} -H {{HOSTS}}

# ============================================================================
# EXAMPLES & DEMONSTRATIONS
# ============================================================================

# Run all examples
examples:
    @just example-basic
    @just example-planning
    @just example-security
    @just example-dns

# Run basic usage example
example-basic:
    python examples/basic_usage.py

# Run network planning example
example-planning:
    python examples/network_planning.py

# Run security audit example
example-security:
    python examples/security_audit.py

# Run DNS operations example
example-dns:
    python examples/dns_operations.py

# ============================================================================
# BUILD & RELEASE
# ============================================================================

# Build everything
build: build-go build-rescript build-python-dist

# Build Python distribution
build-python-dist:
    @echo "Building Python package..."
    python -m build

# Build for release (all platforms)
build-release: clean
    @just build
    @just docs-build
    @just docs-pdf
    @just container-build release

# Create release archive
release VERSION:
    @echo "Creating release {{VERSION}}..."
    git tag -a v{{VERSION}} -m "Release {{VERSION}}"
    @just build-release
    tar czf ipv6-only-{{VERSION}}.tar.gz bin/ build/docs/ README.adoc
    @echo "Release archive: ipv6-only-{{VERSION}}.tar.gz"

# Publish to PyPI
publish-pypi:
    @echo "Publishing to PyPI..."
    python -m twine upload dist/*

# ============================================================================
# MAINTENANCE & CLEANUP
# ============================================================================

# Clean all build artifacts
clean:
    @echo "Cleaning build artifacts..."
    rm -rf build/
    rm -rf dist/
    rm -rf bin/
    rm -rf htmlcov/
    rm -rf .pytest_cache/
    rm -rf *.egg-info/
    find . -type d -name __pycache__ -exec rm -rf {} + 2>/dev/null || true
    find . -type f -name "*.pyc" -delete
    find . -type f -name "*.pyo" -delete
    find . -type f -name "*.coverage" -delete
    rm -f profile.stats
    rm -f security-*.json

# Deep clean including dependencies
clean-all: clean container-clean
    rm -rf venv/
    rm -rf node_modules/ 2>/dev/null || true
    rm -rf .nickel_cache/ 2>/dev/null || true

# Update dependencies
update-deps:
    pip install --upgrade -r requirements.txt
    cd src/go && go get -u ./...

# Check for outdated dependencies
check-deps:
    pip list --outdated
    cd src/go && go list -u -m all

# ============================================================================
# DEVELOPMENT WORKFLOWS
# ============================================================================

# Pre-commit checks
pre-commit: format lint test-python test-go
    @echo "✓ Pre-commit checks passed"

# Continuous integration simulation
ci: clean install-dev lint test coverage security
    @echo "✓ CI checks passed"

# Full validation before release
validate-release: ci test-integration test-examples docs-build
    @echo "✓ Release validation passed"

# Development watch mode (Python)
dev-watch:
    @echo "Starting development watch mode..."
    ls src/python/ipv6tools/*.py tests/python/*.py | entr -c just test-python

# ============================================================================
# REPORTING & ANALYTICS
# ============================================================================

# Generate test report
report-tests:
    pytest tests/python/ --html=report.html --self-contained-html
    @echo "Test report: report.html"

# Generate coverage badge
report-coverage-badge:
    coverage-badge -o coverage.svg -f

# Generate complexity report
report-complexity:
    @echo "Code complexity report..."
    radon cc src/python/ipv6tools/ -a -nb

# Generate maintainability index
report-maintainability:
    radon mi src/python/ipv6tools/ -nb

# Count lines of code
report-loc:
    @echo "Lines of code:"
    @find src -name "*.py" -o -name "*.go" -o -name "*.ts" | xargs wc -l | tail -1

# ============================================================================
# UTILITIES
# ============================================================================

# Show project statistics
stats:
    @echo "Project Statistics:"
    @echo "=================="
    @just report-loc
    @echo ""
    @echo "Python files: $(find src/python -name '*.py' | wc -l)"
    @echo "Go files: $(find src/go -name '*.go' | wc -l)"
    @echo "Test files: $(find tests -name '*.py' | wc -l)"
    @echo "Documentation: $(find docs -name '*.adoc' | wc -l)"

# Find TODO comments
todos:
    @echo "TODO items:"
    @rg -n "TODO|FIXME|XXX|HACK" src/ || echo "No TODOs found"

# Check IPv6 connectivity
check-ipv6:
    @echo "Checking IPv6 connectivity..."
    ping6 -c 1 2001:4860:4860::8888 && echo "✓ IPv6 works" || echo "✗ IPv6 not available"

# Generate development environment info
info:
    @echo "Development Environment:"
    @echo "======================="
    @python3 --version 2>/dev/null || echo "Python: Not installed"
    @go version 2>/dev/null || echo "Go: Not installed"
    @deno --version 2>/dev/null || echo "Deno: Not installed"
    @podman --version 2>/dev/null || echo "Podman: Not installed"
    @just --version 2>/dev/null || echo "Just: Not installed"
