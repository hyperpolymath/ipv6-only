<!--
SPDX-License-Identifier: MPL-2.0
Copyright (c) Jonathan D.A. Jewell <j.d.a.jewell@open.ac.uk>
-->
# Contributing to IPv6-Only Tools

Thank you for your interest in contributing to the IPv6-Only project! This document provides guidelines for contributing.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Setup](#development-setup)
- [Making Changes](#making-changes)
- [Testing](#testing)
- [Submitting Changes](#submitting-changes)
- [Coding Standards](#coding-standards)

## Code of Conduct

- Be respectful and inclusive
- Focus on constructive feedback
- Help others learn and grow
- Follow professional standards

## Getting Started

### Prerequisites

- Python 3.8 or higher
- Go 1.20 or higher (for Go tools)
- Git

### Fork and Clone

```bash
# Fork the repository on GitHub
# Then clone your fork
git clone https://github.com/YOUR_USERNAME/ipv6-only.git
cd ipv6-only

# Add upstream remote
git remote add upstream https://github.com/Hyperpolymath/ipv6-only.git
```

## Development Setup

### Python Development

```bash
# Create virtual environment
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate

# Install in development mode
pip install -e ".[dev]"

# Verify installation
pytest tests/
```

### Go Development

```bash
cd src/go

# Install dependencies
go mod download

# Build tools
go build ./cmd/ipv6-ping
go build ./cmd/ipv6-scan

# Run tests
go test ./...
```

## Making Changes

### Branch Naming

Use descriptive branch names:

- `feature/add-ipv6-tool` - New features
- `fix/validation-bug` - Bug fixes
- `docs/update-readme` - Documentation updates
- `refactor/optimize-subnet` - Refactoring
- `test/add-dns-tests` - Test additions

### Commit Messages

Follow conventional commits:

```
type(scope): short description

Longer description if needed.

- Bullet points for details
- Multiple lines OK

Fixes #123
```

Types:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation
- `test`: Tests
- `refactor`: Code refactoring
- `perf`: Performance improvement
- `style`: Code style/formatting
- `chore`: Maintenance

Examples:

```
feat(dns): add AAAA record batch lookup

Implement batch DNS lookup functionality for multiple hostnames.
Includes error handling and timeout support.

- Add batch_lookup method to IPv6DNSTools
- Add tests for batch operations
- Update documentation

Closes #45
```

```
fix(validator): handle zone IDs correctly

Zone IDs were not being validated properly for link-local addresses.
Now validates both address and zone ID format.

Fixes #67
```

## Testing

### Python Tests

```bash
# Run all tests
pytest

# Run with coverage
pytest --cov=ipv6tools --cov-report=html

# Run specific test file
pytest tests/python/test_address.py

# Run specific test
pytest tests/python/test_address.py::TestIPv6Address::test_valid_address
```

### Writing Tests

Always add tests for new features:

```python
def test_new_feature():
    """Test description."""
    # Arrange
    input_data = "test"

    # Act
    result = function_to_test(input_data)

    # Assert
    assert result == expected_value
```

### Test Coverage

Aim for:
- Core functionality: 95%+ coverage
- Utilities: 90%+ coverage
- CLI tools: 80%+ coverage

## Submitting Changes

### Before Submitting

1. **Update documentation** if needed
2. **Add tests** for new functionality
3. **Run all tests** and ensure they pass
4. **Check code style**:
   ```bash
   # Python
   black src/python/ipv6tools/
   flake8 src/python/ipv6tools/

   # Go
   gofmt -w src/go/
   go vet ./...
   ```
5. **Update CHANGELOG** if applicable

### Pull Request Process

1. **Update your fork**:
   ```bash
   git fetch upstream
   git checkout main
   git merge upstream/main
   ```

2. **Create feature branch**:
   ```bash
   git checkout -b feature/my-feature
   ```

3. **Make changes and commit**:
   ```bash
   git add .
   git commit -m "feat(scope): description"
   ```

4. **Push to your fork**:
   ```bash
   git push origin feature/my-feature
   ```

5. **Create Pull Request** on GitHub

### Pull Request Template

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Documentation update
- [ ] Performance improvement
- [ ] Refactoring

## Testing
- [ ] Tests added/updated
- [ ] All tests pass
- [ ] Manual testing completed

## Checklist
- [ ] Code follows style guidelines
- [ ] Documentation updated
- [ ] CHANGELOG updated (if applicable)
- [ ] No breaking changes (or documented)

## Related Issues
Fixes #(issue)
```

## Coding Standards

### Python

Follow PEP 8 and these guidelines:

```python
# Good: Clear function with docstring
def calculate_subnet(network: str, prefix: int) -> List[str]:
    """
    Calculate subnets from network.

    Args:
        network: Network in CIDR notation
        prefix: New prefix length

    Returns:
        List of subnet strings

    Raises:
        ValueError: If prefix is invalid
    """
    # Implementation
    pass

# Good: Type hints
def validate_address(addr: str) -> Tuple[bool, Optional[str]]:
    """Validate IPv6 address."""
    pass

# Good: Meaningful names
is_valid = validate_ipv6(address)
subnet_list = calculate_subnets(network)

# Bad: Unclear names
x = validate_ipv6(address)
l = calculate_subnets(network)
```

### Go

Follow Go conventions:

```go
// Good: Clear function with comment
// ScanPort scans a single port on the given address.
// Returns true if port is open, false otherwise.
func ScanPort(address string, port int) bool {
    // Implementation
}

// Good: Error handling
result, err := ScanPort(addr, port)
if err != nil {
    return fmt.Errorf("scan failed: %w", err)
}

// Good: Naming
isOpen := ScanPort(address, port)
portList := GetOpenPorts(address)
```

### Documentation

- **All public functions** must have docstrings
- **Include examples** for complex features
- **Document parameters** and return values
- **Note exceptions** that may be raised

### Error Handling

```python
# Good: Specific error messages
if not is_valid_ipv6(address):
    raise ValueError(f"Invalid IPv6 address: {address}")

# Good: Preserve stack trace
try:
    result = risky_operation()
except ValueError as e:
    raise ValueError(f"Operation failed: {e}") from e

# Bad: Bare except
try:
    result = operation()
except:  # Don't do this
    pass
```

## Project Structure

```
ipv6-only/
├── src/
│   ├── python/          # Python package
│   │   └── ipv6tools/
│   ├── go/              # Go tools
│   ├── web/             # Web application
│   └── scripts/         # Shell scripts
├── tests/               # Test files
├── docs/                # Documentation
├── examples/            # Usage examples
└── docker/              # Docker files
```

### Adding New Features

1. **Create module** in appropriate directory
2. **Add tests** in corresponding test directory
3. **Update __init__.py** to export new functionality
4. **Add documentation** in docs/
5. **Add example** in examples/
6. **Update README** if it's a major feature

## Security

### Reporting Vulnerabilities

**Do NOT** open public issues for security vulnerabilities.

Instead, email: security@ipv6-only.example.com

Include:
- Description of vulnerability
- Steps to reproduce
- Potential impact
- Suggested fix (if any)

### Security Guidelines

When contributing:
- Validate all input
- Handle errors gracefully
- Don't expose sensitive information
- Use secure defaults
- Consider IPv6-specific attacks (NDP spoofing, extension headers, etc.)

## Performance

### Benchmarking

When optimizing:

```bash
# Run benchmarks before changes
python -m ipv6tools.benchmark -n 10000 > before.txt

# Make changes

# Run benchmarks after changes
python -m ipv6tools.benchmark -n 10000 > after.txt

# Compare results
diff before.txt after.txt
```

### Performance Guidelines

- Use generators for large datasets
- Cache expensive computations
- Avoid premature optimization
- Profile before optimizing
- Document performance characteristics

## Documentation

### Code Comments

```python
# Good: Explains why, not what
# Use compressed format for storage efficiency
address = compress_address(input_addr)

# Bad: States the obvious
# Compress the address
address = compress_address(input_addr)
```

### Updating Docs

When adding features:

1. Update relevant docs in `docs/`
2. Add examples in `examples/`
3. Update README if needed
4. Update TUTORIAL for user-facing features

## Community

### Getting Help

- **Documentation**: Check docs/ first
- **Issues**: Search existing issues
- **Discussions**: Use GitHub Discussions for questions
- **IRC**: #ipv6-only on Libera.Chat (if available)

### Helping Others

- Answer questions in issues
- Review pull requests
- Improve documentation
- Share examples and use cases

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

## Recognition

Contributors will be:
- Listed in CONTRIBUTORS.md
- Mentioned in release notes
- Credited in documentation

Thank you for contributing to IPv6-Only Tools!
