# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Complete Justfile automation framework with 150+ recipes
- Podman Containerfile with Chainguard Wolfi base for supply chain security
- Nickel configuration system (config/ipv6-tools.ncl)
- Hurricane Electric tunnel integration (4 scripts)
- Deno web server (server.ts) with API endpoints
- Go CLI tools: ipv6-trace and ipv6-lookup
- AsciiDoc Justfile cookbook documentation
- RSR compliance: CODE_OF_CONDUCT.md, MAINTAINERS.md, CHANGELOG.md
- .well-known/ directory with security.txt, ai.txt, humans.txt
- TPCF documentation for tri-perimeter contribution framework
- Nix flake for reproducible builds
- RSR self-verification tool

### Changed
- Renamed LICENSE to licence.txt
- Expanded Justfile recipes from basic to comprehensive automation
- Enhanced security.md with RSR compliance requirements
- Updated CONTRIBUTING.md with RSR standards

## [0.1.0] - 2024-11-22

### Added
- Python IPv6 tools library (ipv6tools package)
  - IPv6Address and IPv6Network classes
  - Validation and format conversion
  - Subnet calculation and planning
  - Address generation (link-local, ULA, from MAC)
- CLI tools: ipv6-calc, ipv6-validate, ipv6-gen, ipv6-convert
- Shell scripts: ipv6-diag.sh, ipv6-config.sh
- Web application with 5 tools (validator, calculator, converter, generator, subnet planner)
- Go network tools: ipv6-ping, ipv6-scan
- Advanced features:
  - DNS tools (AAAA records, PTR lookups)
  - Security scanner with port scanning and audits
  - Performance benchmarking suite
  - Network simulator
- Comprehensive documentation:
  - README.adoc with installation and usage
  - TUTORIAL.md with detailed examples
  - IPv6_PRIMER.md educational resource
  - QUICKSTART.md for rapid onboarding
- Examples: basic_usage.py, network_planning.py, security_audit.py, dns_operations.py
- CI/CD pipeline with GitHub Actions
  - Multi-version Python testing (3.8-3.11)
  - Go builds and tests
  - Security scanning (Bandit, Safety, gosec)
  - Docker/Podman builds
- Docker and Podman support
- Makefile for build automation
- Comprehensive test suite (100+ tests)
  - Python unit tests with pytest
  - Go tests
  - Test coverage reporting

### Security
- security.md with vulnerability reporting procedures
- Security scanning in CI/CD pipeline
- Podman containerization with minimal attack surface
- Non-root container execution

## Release Types

### Version Numbering

We use Semantic Versioning (MAJOR.MINOR.PATCH):
- **MAJOR**: Incompatible API changes
- **MINOR**: Backwards-compatible new features
- **PATCH**: Backwards-compatible bug fixes

### Release Process

1. Update version in setup.py, __init__.py, etc.
2. Update this CHANGELOG.md
3. Create git tag: `git tag -a vX.Y.Z -m "Release X.Y.Z"`
4. Build packages: `just build-release`
5. Publish to PyPI: `just publish-pypi`
6. Create GitHub release with notes
7. Update container images

### Support Policy

- **Latest major version**: Full support (features + security)
- **Previous major version**: Security updates only (6 months)
- **Older versions**: Community support only

## Links

- [Repository](https://github.com/Hyperpolymath/ipv6-only)
- [Issue Tracker](https://github.com/Hyperpolymath/ipv6-only/issues)
- [Releases](https://github.com/Hyperpolymath/ipv6-only/releases)
- [PyPI](https://pypi.org/project/ipv6-only/)
