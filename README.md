# SOLTI - Systems Oriented Laboratory Testing & Integration

> **Documentation Collection**
> *This directory contains the core documentation, philosophy, and architecture for the SOLTI ecosystem.*

## What is SOLTI?

SOLTI provides a comprehensive framework for testing and integrating system components in a controlled environment. The project emphasizes methodical testing, system behavior analysis, and component integration.

- **S**ystems: Managing and testing system-of-systems
- **O**riented: Structured and purposeful approach
- **L**aboratory: Controlled testing environment
- **T**esting: Verification and validation
- **I**ntegration: Component interconnection and interaction

Named after [Sir Georg Solti](https://en.wikipedia.org/wiki/Georg_Solti), renowned for his precise and analytical conducting style.

## Documentation Guide

### For Understanding SOLTI Philosophy
**Read: [solti.md](./solti.md)**
- The complete development journey and philosophy
- Why SOLTI exists and how it evolved
- Working with Claude AI as a pair programmer
- Testing philosophy and patterns
- Technology stack details

### For Current Development Status
**Read: [Development.md](./Development.md)**
- Current development diary
- What's being worked on now
- Recent changes and progress

### For Testing Methodology
**Read: [TestingConcept.md](./TestingConcept.md)** and **[TestingDesignPattern.md](./TestingDesignPattern.md)**
- Testing philosophy and concepts
- Design patterns for verification
- Multi-level verification structures

### For Implementation Examples
**Browse: [artifacts/](./artifacts/)**
- Team development guides
- Security assessment templates
- Grafana Alloy reference implementations

## Component Repositories

SOLTI is organized as multiple Ansible Galaxy collections, each maintained in separate GitHub repositories:

### Production Ready

**[solti-monitoring](https://github.com/jackaltx/solti-monitoring)** - ✅ Production Ready
- Comprehensive metrics and log collection
- Telegraf, InfluxDB, Loki, Alloy integration
- Fail2ban, Wazuh agent support
- Advanced testing frameworks

**[solti-containers](https://github.com/jackaltx/solti-containers)** - ✅ Production Ready
- Containerized development and testing services
- Elasticsearch, HashiVault, Mattermost, Redis, Traefik, MinIO
- Rootless Podman with systemd integration
- Standardized SOLTI container pattern

### In Development

**[solti-ensemble](https://github.com/jackaltx/solti-ensemble)** - 🚧 Active Development
- Infrastructure automation and security hardening
- MariaDB, Gitea, WireGuard
- AI-powered security auditing (claude_sectest)
- SSH hardening, fail2ban configuration

### Planned

**solti-conductor** - 📋 Planned
- Proxmox VM management and orchestration

**solti-score** - 📋 Planned
- Playbooks and operational documentation

## Key Features

- **Comprehensive Monitoring** - Metrics and log aggregation
- **Container Services** - Lightweight testing infrastructure
- **Security Focus** - Hardening and auditing roles
- **Automated Testing** - Molecule framework across multiple platforms
- **Cross-Platform** - Rocky Linux 9, Debian 12, Ubuntu 24
- **AI Integration** - Claude-powered security analysis

## Testing Philosophy

- Emphasis on controlled environments
- Systematic behavior analysis
- Component isolation capability
- Integration validation across collections
- Performance measurement
- 3D testing matrix: 3 distros × 3 platforms × multiple features

## Technology Stack

**Automation & Testing:**
- Ansible for infrastructure automation
- Molecule for testing framework
- Proxmox for virtualization

**Monitoring & Logging:**
- InfluxDB for metrics storage
- Loki for log aggregation
- Telegraf for metrics collection
- Alloy for OpenTelemetry

**Container Platform:**
- Podman 4.x+ for rootless containers
- Systemd with Quadlets for service management
- Cross-platform container networking

## Development Guidelines

- Modular design with clear separation of concerns
- Comprehensive testing using Molecule
- Documented interfaces and APIs
- Version controlled components
- Consistent naming conventions
- Security-first approach

## Get Started

1. **New to SOLTI?** Start with [solti.md](./solti.md) to understand the philosophy
2. **Need monitoring?** Go to [solti-monitoring](https://github.com/jackaltx/solti-monitoring)
3. **Need containers?** Go to [solti-containers](https://github.com/jackaltx/solti-containers)
4. **Need security/database?** Go to [solti-ensemble](https://github.com/jackaltx/solti-ensemble)

## License

MIT-0 - All SOLTI work is freely available without restriction.

## Contact

Use GitHub issues in the respective component repositories.

## Acknowledgments

- **Sir Georg Solti** - Name inspiration for precision and analytical approach
- **Claude AI** - Development assistant and pair programming partner
- **Open Source Community** - Foundation technologies
