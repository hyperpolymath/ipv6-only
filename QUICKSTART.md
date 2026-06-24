<!--
SPDX-License-Identifier: CC-BY-SA-4.0
Copyright (c) Jonathan D.A. Jewell <j.d.a.jewell@open.ac.uk>
-->
# IPv6-Only Tools - Quick Start Guide

Get started with IPv6-Only Tools in 5 minutes!

## Installation

### Option 1: Install from Source

```bash
git clone https://github.com/Hyperpolymath/ipv6-only.git
cd ipv6-only
pip install -e .
```

### Option 2: Using Docker

```bash
docker pull ipv6-only:latest
docker run -it --rm ipv6-only
```

## First Steps

### 1. Validate an IPv6 Address

```python
from ipv6tools import validate_ipv6

valid, error = validate_ipv6("2001:db8::1")
print(f"Valid: {valid}")  # Valid: True
```

### 2. Work with Addresses

```python
from ipv6tools import IPv6Address

addr = IPv6Address("2001:db8::1")
print(f"Compressed: {addr.compressed}")
print(f"Expanded: {addr.exploded}")
print(f"Type: {addr.get_address_type()}")
```

### 3. Calculate Subnets

```python
from ipv6tools import IPv6SubnetCalculator

calc = IPv6SubnetCalculator("2001:db8::/32")
subnets = calc.divide_into_subnets(4)

for subnet in subnets:
    print(subnet.network)
```

### 4. Generate Addresses

```python
from ipv6tools.utils import generate_link_local, mac_to_ipv6_link_local

# Random link-local
ll = generate_link_local()
print(f"Link-local: {ll}")

# From MAC address
ipv6 = mac_to_ipv6_link_local("00:11:22:33:44:55")
print(f"From MAC: {ipv6}")
```

## Command-Line Tools

### Network Calculator

```bash
# Get network information
ipv6-calc 2001:db8::/32 --info

# Divide into subnets
ipv6-calc 2001:db8::/32 --divide 16
```

### Address Validator

```bash
# Validate addresses
ipv6-validate 2001:db8::1 fe80::1%eth0
```

### Address Generator

```bash
# Generate link-local
ipv6-gen link-local

# Generate from MAC
ipv6-gen from-mac 00:11:22:33:44:55
```

### Diagnostics (requires sudo)

```bash
# Full diagnostics
sudo ./src/scripts/ipv6-diag.sh

# Quick connectivity check
./src/scripts/ipv6-diag.sh --quick
```

## Web Interface

Simply open `src/web/index.html` in your browser for a graphical interface with:
- Address validator
- Network calculator
- Format converter
- Address generator
- Subnet planner

All tools run locally - no server needed!

## Advanced Features

### DNS Operations

```python
from ipv6tools.dns import IPv6DNSTools

dns = IPv6DNSTools()

# Lookup AAAA records
addresses = dns.lookup_aaaa("google.com")
print(f"IPv6 addresses: {addresses}")

# Check dual-stack support
result = dns.compare_dual_stack("cloudflare.com")
print(f"Has IPv6: {result['has_ipv6']}")
```

### Security Scanning

```python
from ipv6tools.security import IPv6SecurityScanner

scanner = IPv6SecurityScanner()

# Quick scan
results = scanner.quick_scan("2001:db8::1")
for result in results:
    print(f"Port {result.port}: {result.service}")

# Security audit
audit = scanner.security_audit("2001:db8::1")
print(f"Open ports: {audit.open_ports}")
print(f"Vulnerabilities: {audit.vulnerabilities}")
```

### Performance Benchmarking

```bash
# Run benchmarks
python -m ipv6tools.benchmark

# Quick benchmark
python -m ipv6tools.benchmark --quick

# With comparisons
python -m ipv6tools.benchmark --compare
```

### Network Simulation

```python
from ipv6tools.simulator import IPv6NetworkSimulator

sim = IPv6NetworkSimulator()

# Create network
network = sim.create_network("2001:db8::/64", num_hosts=5)

# Generate report
print(sim.generate_report())
```

## Common Tasks

### Task 1: Plan a New Network

```python
from ipv6tools import IPv6SubnetCalculator

# You have a /48, divide for departments
allocation = IPv6SubnetCalculator.recommend_allocation(
    "2001:db8::/48",
    {
        "Engineering": 10,
        "Sales": 5,
        "IT": 3,
    }
)

for dept, subnets in allocation.items():
    print(f"\n{dept}:")
    for subnet in subnets:
        print(f"  {subnet.network}")
```

### Task 2: Check IPv6 Support of Websites

```python
from ipv6tools.dns import IPv6DNSTools

dns = IPv6DNSTools()

websites = ["google.com", "facebook.com", "github.com"]

for site in websites:
    has_ipv6 = dns.has_ipv6(site)
    status = "✓" if has_ipv6 else "✗"
    print(f"{status} {site}")
```

### Task 3: Audit Security

```python
from ipv6tools.security import IPv6SecurityScanner

scanner = IPv6SecurityScanner()
audit = scanner.security_audit("2001:db8::1")

# Check results
if audit.vulnerabilities:
    print("⚠️ Vulnerabilities found!")
    for vuln in audit.vulnerabilities:
        print(f"  - {vuln}")
else:
    print("✓ No major vulnerabilities")
```

## Examples

Check the `examples/` directory for complete examples:

- `basic_usage.py` - Core functionality examples
- `network_planning.py` - Enterprise network planning
- `security_audit.py` - Security audit examples
- `dns_operations.py` - DNS operations examples

Run an example:

```bash
cd examples
python basic_usage.py
python network_planning.py
```

## Testing

### Run Tests

```bash
# All tests
make test

# Python tests only
make test-python

# With coverage
make coverage
```

### Run Examples

All examples are in the `examples/` directory and can be run directly:

```bash
python examples/basic_usage.py
```

## Documentation

- **Tutorial**: `docs/TUTORIAL.md` - Comprehensive guide
- **IPv6 Primer**: `docs/IPv6_PRIMER.md` - Learn IPv6 basics
- **API Docs**: See docstrings in code
- **Contributing**: `CONTRIBUTING.md` - Contribution guidelines

## Getting Help

- **Documentation**: Check `docs/` directory
- **Examples**: See `examples/` directory
- **Issues**: https://github.com/Hyperpolymath/ipv6-only/issues

## Next Steps

1. Read the [Tutorial](docs/TUTORIAL.md) for detailed examples
2. Try the [Examples](examples/)
3. Check out the [IPv6 Primer](docs/IPv6_PRIMER.md) to learn more
4. Explore the Web Interface at `src/web/index.html`

## Cheat Sheet

```python
# Import everything
from ipv6tools import *

# Create address
addr = IPv6Address("2001:db8::1")

# Create network
net = IPv6Network("2001:db8::/32")

# Calculate subnets
calc = IPv6SubnetCalculator("2001:db8::/32")
subnets = calc.divide_into_subnets(4)

# Generate addresses
ll = generate_link_local()
ula = generate_unique_local()

# Validate
valid, error = validate_ipv6("2001:db8::1")

# Compress/Expand
compressed = compress_address("2001:0db8::0001")
expanded = expand_address("2001:db8::1")
```

Happy IPv6 networking! 🌐
