# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

SOLTI (Systems Oriented Laboratory Testing & Integration) is a comprehensive framework for testing and integrating system components in controlled environments. This repository serves as the central documentation and planning hub for a multi-repository project that includes:

- **solti-monitoring**: Metrics collection (Telegraf, InfluxDB, Loki, Alloy)
- **solti-containers**: Container services (Elasticsearch, Mattermost, Redis, etc.)
- **solti-ensemble**: Support tools and shared utilities
- **solti-conductor**: Proxmox management (planned)
- **solti-score**: Documentation and playbooks (planned)

## Architecture Philosophy

The project follows a "cluster-of-services" approach using Ansible inventory to define cluster interactions. Each component is designed to be:
- Idempotent (Ansible roles)
- Testable (Molecule framework)
- Modular and reusable
- Cross-platform compatible (RHEL/CentOS and Debian-based)

## Key Concepts

### Testing Strategy
- **Molecule-based testing** with hierarchical report structures
- **Progressive data collection** from basic service status to performance metrics
- **NoSQL-ready structure** designed for future pattern analysis and machine learning integration
- **Master report structure** that accumulates test results across multiple verification phases

### Verification Pattern
The project uses a sophisticated verification system with a `verify_master_report` structure:
```yaml
verify_master_report:
  metadata:
    timestamp: ISO8601
    distribution: string
    molecule_scenario: string
    run_id: epoch
  capabilities:
    metrics: {...}
    logs: {...}
```

### Container Strategy
- **Rootless Podman deployment** with systemd integration
- **Quadlet-based systemd integration** for service management
- **Standardized management scripts** (`manage-svc.sh`, `svc-exec.sh`)
- **Common `_base` role** for shared functionality across container services

## Development Workflow

Since this repository has no traditional build system (no package.json, Makefile, etc.), development focuses on:

1. **Documentation and Planning**: This repo contains strategic documentation and artifacts
2. **Testing Design**: Molecule testing strategies and verification patterns
3. **Architecture Documentation**: Cross-project integration patterns
4. **Security Analysis**: Assessment scripts and security reporting templates

## Related Repositories

When working on implementation:
- Check the appropriate sub-repository for actual Ansible roles and code
- This repository contains **planning documents** and **artifacts**, not executable code
- The `artifacts/` directory contains examples and reference implementations

## File Structure

- `artifacts/`: Contains example configurations, security assessments, and team documentation
- `*.md` files: Strategic documentation and design patterns
- `TestingConcept.md` and `TestingDesignPattern.md`: Core testing philosophy and implementation patterns

## Working with Testing

The project emphasizes a data-driven approach to testing with structures that support:
- Pattern recognition and analysis
- Future machine learning integration
- Hierarchical result organization
- Multiple data formats (text, binary, external URIs)

When modifying test structures, maintain backward compatibility and consider the evolution path toward automated analysis and test generation.

## Security Focus

This project includes defensive security components:
- Security assessment scripts in `artifacts/security-assessment-work/`
- Network analysis and monitoring capabilities
- Log analysis and pattern detection for security events

Always follow security best practices and never introduce code that exposes secrets or creates security vulnerabilities.