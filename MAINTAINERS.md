<!--
SPDX-License-Identifier: CC-BY-SA-4.0
Copyright (c) Jonathan D.A. Jewell <j.d.a.jewell@open.ac.uk>
-->
# Maintainers

This document lists the maintainers of the IPv6-Only Tools project.

## Current Maintainers

### Lead Maintainer

* **Hyperpolymath** ([@Hyperpolymath](https://github.com/Hyperpolymath))
  - Role: Project Lead, Architecture
  - Focus: Overall direction, major features, releases
  - Contact: maintainer@ipv6-only.example.com
  - GPG: (To be added)

## Maintainer Responsibilities

Maintainers are responsible for:

1. **Code Review**: Reviewing and merging pull requests
2. **Issue Triage**: Categorizing and prioritizing issues
3. **Release Management**: Creating and publishing releases
4. **Security**: Responding to security issues
5. **Community**: Fostering inclusive community
6. **Documentation**: Keeping documentation current
7. **Quality**: Maintaining code quality standards
8. **Testing**: Ensuring test coverage and CI/CD health

## Areas of Focus

### Python Library (`src/python/ipv6tools/`)
* Maintainer: Hyperpolymath
* Focus: Core IPv6 address manipulation, validation, subnet calculation

### Go Tools (`src/go/`)
* Maintainer: Hyperpolymath
* Focus: Network tools (ping, scan, trace, lookup)

### Web Interface (`src/web/`)
* Maintainer: Hyperpolymath
* Focus: Deno/ReScript web application

### Documentation (`docs/`)
* Maintainer: Hyperpolymath
* Focus: AsciiDoc documentation, tutorials, guides

### Infrastructure
* Maintainer: Hyperpolymath
* Focus: CI/CD, containers, build systems

## Becoming a Maintainer

We welcome new maintainers! The process:

1. **Contribute**: Make regular, high-quality contributions
2. **Demonstrate**: Show expertise in a specific area
3. **Engage**: Help with reviews, issues, community support
4. **Nominate**: Current maintainer nominates you
5. **Approve**: Existing maintainers approve (consensus)
6. **Onboard**: Training on maintainer responsibilities

### Criteria

* **Technical Excellence**: Deep knowledge of project and domain
* **Judgment**: Makes sound technical and social decisions
* **Availability**: Commits to ongoing participation
* **Communication**: Clear, respectful communicator
* **Alignment**: Supports project values and goals

## Emeritus Maintainers

Former maintainers who have stepped down but retain honorary status:

(None yet - project is new)

## Decision Making

### Consensus Model

* **Minor Changes**: Any maintainer can approve and merge
* **Moderate Changes**: Two maintainer approvals required
* **Major Changes**: All maintainers must approve
* **Controversial**: If no consensus, lead maintainer decides

### What Requires Approval

* **Minor**: Bug fixes, documentation, tests
* **Moderate**: New features, refactoring, dependencies
* **Major**: Architecture changes, API changes, breaking changes
* **Critical**: Security fixes (expedited process)

## Communication Channels

* **GitHub Issues**: Bug reports, feature requests
* **GitHub Discussions**: General questions, ideas
* **Security**: security@ipv6-only.example.com
* **Private**: maintainers@ipv6-only.example.com

## Maintainer Guidelines

### Code Review

* **Timely**: Respond within 48 hours
* **Constructive**: Provide helpful feedback
* **Thorough**: Check code, tests, docs
* **Respectful**: Kind and professional

### Issue Management

* **Triage**: Label and prioritize within 24 hours
* **Respond**: Acknowledge within 48 hours
* **Close**: Explain closure reasons
* **Link**: Connect related issues

### Security

* **Confidential**: Keep security issues private
* **Timely**: Respond within 24 hours
* **Coordinated**: Follow disclosure timeline
* **Document**: Update security.md

### Release Process

1. Version bump in relevant files
2. Update CHANGELOG.md
3. Tag release (vX.Y.Z)
4. Build and test
5. Publish to PyPI, container registry
6. Create GitHub release with notes
7. Announce on social media

## Stepping Down

If a maintainer needs to step down:

1. Notify other maintainers
2. Document in-progress work
3. Transfer responsibilities
4. Move to emeritus status
5. Update this document

## Contact

For maintainer-related questions:
* Email: maintainers@ipv6-only.example.com
* GitHub: Open an issue with `@maintainers` mention

## Changes

This document is maintained by current maintainers and updated as needed.

Last updated: 2024-11-22
