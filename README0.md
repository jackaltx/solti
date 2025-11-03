# SOLTI - Systems Oriented Laboratory Testing & Integration

## Overview

SOLTI provides a comprehensive framework for testing and integrating system components in a controlled environment. The project emphasizes methodical testing, system behavior analysis, and component integration.

This project is using an AI.  I keep a diary of where I am in the [development](Development) process.  MCP works is starting!

## Goal

I have done small lab clusters for a while. Not the high availability kind, but those that are built to task when/as desired.
The software and hardware technology half-life is real. The desirements and requirements alway grow tigher.

Lately the focus was on security testing. As a kinestic creative I learn best by doing. The prize is building out a flexible, repeatable, testable computer cluster.
In this exercise I wanted to learn ansible, containers, github and LLMs. These efforts started on [cluster monitoring](https://github.com/jackaltx/solti-monitoring)
to handle log and metric generation and collection.  The collection project is maturing, and I am starting on the ensemble work.  My tactical effort will
be to [DRY](https://en.wikipedia.org/wiki/Don%27t_repeat_yourself) the molecule testing pattern, then move onto tools I need soon.

I develop the parts based on need and  interesting.  Here is a list of sprints where my work led.

- Use molecule for testing the ansible deployments. Spent significant effort to keepii [DRY](https://en.wikipedia.org/wiki/Don%27t_repeat_yourself)
- Explore and abondon WAZUH, too heavy for my needs. I am leaving the work in for now.
- I don't care for how Docker likes to be in charge.  There are exensive examples of how to use PODMAN with systemctl. Rather than spin up VMs for testing, it is easier to run a podman service.
- Using PROXMOX, Linode and GITHUB for testing via molecule.
- Using Ansible to build up an ISPConfig VM locally and in Linode.

## Name Origin

- **S**ystems: Managing and testing system-of-systems
- **O**riented: Structured and purposeful approach
- **L**aboratory: Controlled testing environment
- **T**esting: Verification and validation
- **I**ntegration: Component interconnection and interaction

Named after [Sir Georg Solti](https://en.wikipedia.org/wiki/Georg_Solti), renowned for his precise and analytical conducting style.
His [Wagner](https://en.wikipedia.org/wiki/Der_Ring_des_Nibelungen_(Georg_Solti_recording)) works have held up to time.

## Project Structure

There is no one way to look at this project structure.  At the heart is about building
a flexible and testable cluster out of services writen by other people. To accomplish this
I am using the Ansible inventory to define the cluster interactions. Ansible roles are idempotent scripts
that install, configure, test the clusters intended functionality. This is our starting. ansible galaxy
collection structure concept.

```
jackaltx/
├── solti/monitoring/   # System monitoring and metrics collection
├── solti/conductor/    # Proxmox management and orchestration
├── solti/ensemble/     # Support tools and shared utilities
├── solti/containers/   # Testing containers
└── solti/score/        # Documentation and playbooks
```

To realize this, I use this logical repository structure on github

```
jackaltx/
├── solti-monitoring/   # System monitoring and metrics collection
├── solti-conductor/    # Proxmox management and orchestration
├── solti-ensemble/     # Support tools and shared utilities
├── solti-containers/   # Testing containers
└── solti-score/        # Documentation and playbooks
```

## Github Repository links

- [jackaltx/solti-monitoring](https://github.com/jackaltx/solti-monitoring)  
- jackaltx/solti-conductor/    # Proxmox management and orchestration
- [jackaltx/solti-ensemble](https://github.com/jackaltx/solti-ensemble)
- [jackaltx/solti-containers](https://github.com/jackaltx/solti-containers)
- jackaltx/solti-score

## Current Implementation Status

**Production Ready Projects:**

- ✅ **solti-monitoring**: Comprehensive metrics and logging
- ✅ **solti-containers**: Production-ready container services
- 🚧 **solti-ensemble**: Support tools (in development)
- 📋 **solti-conductor**: Proxmox management (planned)
- 📋 **solti-score**: Documentation (planned)

### solti-monitoring (Production Ready)

Current implementation includes:

- Metrics collection (Telegraf)
- Time-series storage (InfluxDB)
- Log aggregation (Loki)
- OpenTelemetry collection (Alloy)
- Shared configurations and utilities

### solti-containers (Production Ready)

**Status: Production Ready** - Comprehensive container deployment framework

Current implementation includes:

- **Elasticsearch**: Search and analytics with Elasticvue GUI
- **HashiVault**: Complete secrets management with multiple engines
- **Mattermost**: Team collaboration with PostgreSQL backend
- **Redis**: High-performance key-value store with GUI
- **Traefik**: Modern reverse proxy with TLS automation
- **MinIO**: S3-compatible object storage

**Key Features:**

- Rootless Podman deployment with systemd integration
- Cross-platform support (RHEL/CentOS and Debian-based)
- Standardized management scripts (`manage-svc.sh`, `svc-exec.sh`)
- Security-first design with SELinux support
- Consistent deployment patterns across all services

**Architecture Highlights:**

- Common `_base` role for shared functionality
- Quadlet-based systemd integration
- Automated service lifecycle management
- Comprehensive verification and health checking

**Container Services Integration:**

The containers project integrates with the monitoring stack:

- **Mattermost**: Receives monitoring alerts and notifications
- **Elasticsearch**: Stores and analyzes log data from monitoring
- **Redis**: Caches metrics and provides fast data access
- **HashiVault**: Manages secrets for monitoring components
- **Traefik**: Provides reverse proxy for monitoring dashboards

This creates a complete development and testing ecosystem where:

1. Monitoring collects metrics and logs
2. Containers provide supporting services
3. Everything is deployed consistently via Ansible
4. Services can be quickly spun up/down for testing

### solti-conductor (TBD)

Planned features:

- Proxmox VM management
- Resource orchestration
- Configuration management
- Deployment automation

### solti-ensemble (Starting)

Current implementation includes:

- Mariadb (MySQL)
- HashiVault (InfluxDB)
- Automated Certificate Management Environment (ACME)

Planned features:  (not now)

- NFS client management
- Common system configurations
- Shared security policies
- Cross-component utilities

### solti-score (TBD)

Documentation and playbooks:

- Architecture documentation
- Implementation guides
- Integration patterns
- Best practices

## Testing Philosophy

- Emphasis on controlled environments
- Systematic behavior analysis
- Component isolation capability
- Integration validation
- Performance measurement

**Container Testing:**

- Standardized verification tasks for all services
- Health checks and connectivity testing
- Service-specific functional validation
- Cross-platform compatibility testing

## Key Features

- Comprehensive monitoring
- Automated testing
- System integration
- Behavior analysis
- Performance metrics
- Log aggregation
- Configuration management

## Technology Stack

Current components:

- Ansible for automation
- Molecule for testing
- InfluxDB for metrics
- Loki for logs
- Telegraf for collection
- Alloy for OpenTelemetry
- Proxmox for virtualization

**Container Platform:**

- Podman 4.x+ for rootless containers
- Systemd with Quadlets for service management
- Cross-platform container networking

**Service Management:**

- Ansible collection with standardized roles
- Shell script wrappers for simplified operations
- Comprehensive verification and health checking

## Development Guidelines

- Modular design
- Clear separation of concerns
- Comprehensive testing
- Documented interfaces
- Version controlled components
- Consistent naming conventions

**Container Service Standards:**

- Follow established SOLTI container pattern
- Implement all four core lifecycle states
- Include comprehensive verification tasks
- Support both RHEL and Debian platforms
- Use consistent variable naming conventions

## Testing Methodology

- Unit testing with Molecule
- Integration testing across components
- Performance validation
- Behavior verification
- Security validation

## Deployment

- Automated via Ansible
- Environment-specific configurations
- Version-controlled deployments
- Rollback capabilities
- Monitoring integration

## Security Considerations

- Component isolation
- Access control
- Secure communications
- Audit logging
- Compliance validation

## Future Directions

- PCAP analysis integration
- Extended system feeders
- Enhanced automation
- Additional monitoring capabilities
- Extended testing frameworks

## Contributing

TBD:

- Contribution guidelines
- Code review process
- Testing requirements
- Documentation standards
- Version control workflow

## License

The concept is open. All my work will be MIT.

## Contact

Use github for now.

## Acknowledgments

- Sir Georg Solti - Name inspiration
- Open source community
- Project contributors
