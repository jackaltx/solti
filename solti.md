# SOLTI - Systems Oriented Laboratory Testing & Integration

## Overview

SOLTI provides a comprehensive framework for testing and integrating system components in a controlled environment. The project emphasizes methodical testing, system behavior analysis, and component integration with AI-powered development and analysis capabilities.

## Goal

I have done small lab clusters for a while. Not the HVAC kind, but those that are built to task when/as desired. The software and hardware technology half-life is real. The requirements and desires always grow tighter.

Lately the focus was on security testing. As a kinesthetic creative I learn best by doing. The prize is building out a flexible, repeatable, testable computer cluster. In this exercise I wanted to learn ansible, containers, GitHub and LLMs. These efforts started on [cluster monitoring](https://github.com/jackaltx/solti-monitoring) to handle log and metric generation and collection. The collection projects are maturing, featuring sophisticated testing frameworks, utility script ecosystems, and AI-powered analysis capabilities.

My tactical effort has been to [DRY](https://en.wikipedia.org/wiki/Don%27t_repeat_yourself) the molecule testing pattern, then move onto tools I need. Current focus includes standardizing reporting flows with feature testing across three primary Linux distros (Rocky 9.3, Debian 12, Ubuntu 24) and three compute environments (Proxmox-VE, Podman, GitHub).

## Architecture Overview

The SOLTI framework consists of integrated collections that work together:

### Current Production Collections

#### solti-monitoring: Comprehensive Monitoring Ecosystem

- **Metrics Pipeline**: Telegraf → InfluxDB with multi-storage backends
- **Logging Pipeline**: Alloy → Loki with S3/NFS support  
- **Security Integration**: Wazuh agents with intelligent service detection
- **Testing Framework**: Multi-environment validation (Podman, Proxmox, GitHub CI)
- **Utility Scripts**: `manage-svc.sh` and `svc-exec.sh` for operational efficiency

#### solti-ensemble: Infrastructure Automation & Security

- **Security Auditing**: Claude AI-powered analysis with Git-based versioning
- **Infrastructure**: MariaDB, NFS, SSH hardening with comprehensive testing
- **Development Tools**: VS Code, Gitea, Podman with lifecycle management
- **Network Services**: WireGuard VPN with secure key management

### Collections in Development

#### solti-conductor (Planned)

- Proxmox VM management and resource orchestration
- Configuration management and deployment automation

#### solti-containers (In Development)  

- Testing containers with configured security
- Reusable framework for service deployment (Mattermost, Elasticsearch, MinIO)

#### solti-score (Planned)

- Architecture documentation and implementation guides
- Integration patterns and best practices

## Claude as My Pair Programmer

Claude writes a lot of code quickly and has been very helpful. It has been interesting to learn about my limits. Claude is a tool - if you know what you want you can likely get it. But sometimes the journey will be rocky and hard. You will explore areas you likely have not considered viable. Sometimes that is a good thing. Debugging with Claude can go far afield. However, when I keep to my north star and focus on the goal, the product looks good.

Claude wrote the first draft of this, and helped come up with tool ideas. Claude's writing is better than mine. The ability to review all the code and come up with a good readme has been fantastic.

### AI-Powered Development Features

This project leverages Claude AI for:

- **Code Generation**: Rapid development of Ansible roles and playbooks
- **Security Analysis**: Professional security audit analysis with structured output
- **Documentation**: Comprehensive README and guide generation  
- **Testing**: Verification framework development
- **Configuration Versioning**: Git-based change tracking and rollback capabilities

**Current Focus with Claude**: Work towards standardizing a reporting flow with feature testing focus over our 3D matrix (distros × compute environments × features). Moving from GIST to Mattermost for notifications and Elasticsearch for results storage.

### Working with AI: Lessons Learned

My main caution is "don't let it take you too far from your vision". You will need to pull in the reins from time to time and focus on the "why". I have noticed two distinct patterns emerge when debugging with AI: the oak and willow.

**The Oak Path**: Decides the solution is just a tweak away with no concept that changes might create maintenance issues. Logical given the speed it can deliver solutions.

**The Willow Path**: Bends to will. More than once we have gone in circles where the core issue was a deeper structural problem.

Finding balance requires learning how to work with this tool. The results are impressive and I am generally pleased with the outcomes.

*Want to try professional AI-powered analysis? [Sign up for Claude with my referral](https://claude.ai/referral/T7Fxp0WbSQ) if ya want!*

## Name Origin

- **S**ystems: Managing and testing system-of-systems
- **O**riented: Structured and purposeful approach
- **L**aboratory: Controlled testing environment
- **T**esting: Verification and validation
- **I**ntegration: Component interconnection and interaction

Named after [Sir Georg Solti](https://en.wikipedia.org/wiki/Georg_Solti), renowned for his precise and analytical conducting style. His [Wagner](https://en.wikipedia.org/wiki/Der_Ring_des_Nibelungen_(Georg_Solti_recording)) works have held up to time.

## Project Structure

There is no one way to look at this project structure. At the heart is building a flexible and testable cluster out of services written by other people. To accomplish this I am using the Ansible inventory to define cluster interactions. Ansible roles are idempotent scripts that install, configure, and test the cluster's intended functionality using the ansible galaxy collection structure concept.

### Logical Structure

```
jackaltx/
├── solti/monitoring/   # System monitoring and metrics collection
├── solti/conductor/    # Proxmox management and orchestration
├── solti/ensemble/     # Support tools and shared utilities
├── solti/containers/   # Testing containers
└── solti/score/        # Documentation and playbooks
```

### Repository Implementation

```
jackaltx/
├── solti-monitoring/   # System monitoring and metrics collection
├── solti-conductor/    # Proxmox management and orchestration
├── solti-ensemble/     # Support tools and shared utilities
├── solti-containers/   # Testing containers
└── solti-score/        # Documentation and playbooks
```

## Current Status & GitHub Repository Links

### ✅ Production Ready

- **[solti-monitoring](https://github.com/jackaltx/solti-monitoring)** - *Production Ready*
  - Comprehensive monitoring with Telegraf, InfluxDB, Alloy, Loki
  - Multi-environment testing framework
  - Utility script ecosystem for operations
  - Security monitoring with Wazuh and Fail2Ban

- **[solti-ensemble](https://github.com/jackaltx/solti-ensemble)** - *Production Ready*  
  - Infrastructure automation with MariaDB, NFS, SSH hardening
  - Development tools: VS Code, Gitea, Podman, WireGuard
  - AI-powered security analysis with comprehensive guides
  - Git-based configuration versioning

### 🚧 In Development

- **[solti-containers](https://github.com/jackaltx/solti-containers)** - *In Development*
  - Testing containers with security-focused configurations
  - Mattermost, Elasticsearch, MinIO service frameworks

### 📋 Planned

- **solti-conductor** - *Planned* - Proxmox management and orchestration
- **solti-score** - *Planned* - Documentation and playbooks

## Key Features Implemented

### Advanced Testing Framework

- **Multi-Environment**: Podman containers, Proxmox VMs, GitHub CI
- **Verification Levels**: Component → Integration → System validation
- **Utility Scripts**: Operational efficiency with `manage-svc.sh` and `svc-exec.sh`
- **Git-Based Versioning**: Configuration change tracking and rollback

### Professional Security Integration

- **AI-Powered Analysis**: Claude integration for security assessments
- **Compliance Validation**: PCI DSS, NIST, CIS benchmark alignment
- **Audit Trails**: Complete configuration change history
- **Intelligent Recommendations**: Specific, actionable security guidance

### Operational Excellence

- **Multi-Storage Support**: Local, NFS, S3-compatible backends
- **Cross-Platform**: Debian/Ubuntu primary, Rocky Linux experimental
- **Lifecycle Management**: Complete install/configure/remove workflows
- **Performance Optimization**: Tuned configurations for production use

## Technology Stack

### Current Implementation

- **Ansible** for automation and orchestration
- **Molecule** for comprehensive testing across environments
- **InfluxDB** for time-series metrics storage
- **Loki** for efficient log aggregation and querying
- **Telegraf** for metrics collection from diverse sources
- **Alloy** for modern OpenTelemetry log collection
- **Proxmox** for virtualization and testing environments

### AI & Analysis

- **Claude AI** for code generation and security analysis
- **Git** for configuration versioning and change tracking
- **Structured Output** for automated analysis workflows

## Testing Philosophy

- **Controlled Environments**: Systematic testing across multiple platforms
- **Behavior Analysis**: Component isolation and integration validation
- **Performance Measurement**: Resource utilization and optimization
- **Security Validation**: Comprehensive audit and compliance checking
- **Operational Verification**: Real-world deployment scenario testing

## Development Guidelines

- **Modular Design**: Clear separation of concerns with focused roles
- **Comprehensive Testing**: Multi-level validation from unit to system
- **Documented Interfaces**: Complete documentation with usage examples
- **Version Controlled**: Git-based change management with rollback
- **Consistent Patterns**: Standardized naming and structure conventions
- **AI Integration**: Structured output for automated analysis workflows

## Installation

```bash
# Install monitoring collection
ansible-galaxy collection install jackaltx.solti_monitoring

# Install infrastructure collection  
ansible-galaxy collection install jackaltx.solti_ensemble
```

## Quick Start

```yaml
# Deploy complete monitoring stack
- hosts: monitoring_servers
  roles:
    - jackaltx.solti_monitoring.influxdb
    - jackaltx.solti_monitoring.loki

- hosts: all_servers
  roles:
    - jackaltx.solti_monitoring.telegraf
    - jackaltx.solti_monitoring.alloy
    - jackaltx.solti_ensemble.sshd_harden
```

## Security Considerations

- **Component Isolation**: Role-based access and service separation
- **Access Control**: Token-based authentication and authorization
- **Secure Communications**: TLS/SSL encryption where applicable
- **Audit Logging**: Comprehensive change tracking and monitoring
- **Compliance Validation**: Automated framework alignment checking

## Future Directions

- **Enhanced Automation**: Extended deployment and management capabilities
- **Additional Monitoring**: Expanded metrics and log source support
- **PCAP Analysis**: Network traffic analysis integration
- **Extended Testing**: Broader platform and scenario coverage
- **API Integration**: Programmatic management interfaces

## Contributing

Current focus on:

- Expanding cross-platform support
- Enhancing testing framework capabilities  
- Improving AI integration and analysis
- Developing additional utility scripts
- Creating comprehensive documentation

## License

MIT License - All SOLTI projects use MIT licensing for maximum flexibility.

## Contact

Use GitHub issues for project-related discussions and contributions.

## Acknowledgments

- **Sir Georg Solti** - Name inspiration for precision and analytical approach
- **Claude AI (Anthropic)** - AI development partnership and code generation
- **Open Source Community** - Foundation tools and continuous inspiration
- **Project Contributors** - Ongoing development and testing support
