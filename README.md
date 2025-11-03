# SOLTI - Systems Oriented Laboratory Testing & Integration

> *Auto-generated from component repositories*
> *Last updated: 2025-09-30 18:24:59*

## Overview

SOLTI provides a comprehensive framework for testing and integrating system components in a controlled environment. The project emphasizes methodical testing, system behavior analysis, and component integration.

This project is using an AI.  I keep a diary of where I am in the [development](Development) process.  MCP works is starting!

## 🎯 Goal

I have done small lab clusters for a while. Not the high availability kind, but those that are built for expirament as desired/required to operate as needed.  The tools and techniques change continually with short half-lifes. The tasks always grow to fit the capabilities of the time.

Lately my focus has been on security testing. I am a kinestic creative, which means I learn best by doing. The prize I am
after is a is building out a flexible, repeatable, testable computer cluster that I can test and evolve. The skills I hopted to optain
were a command of  ansible, linux containers, github and LLMs. I took technologies I was usig to formalize [cluster monitoring](https://github.com/jackaltx/solti-monitoring) to handle log and metric generation and collection.  The collection project is maturing, and I am starting on the ensemble work.  

For now this is my tool and I develop the parts based on need and  interesting.  Here is a list of work product sprints.

- Use molecule for testing the ansible deployments. Spent significant effort to keep it  [DRY](https://en.wikipedia.org/wiki/Don%27t_repeat_yourself)
using shared data patterns and fancy clever loops.
- Explored and abondoned WAZUH, too heavy for my needs. I am leaving the work in for now/
- There are exensive examples of how to use PODMAN with systemctl. Rather than spin up VMs for testing, it is easier to run a podman service. (I don't care for how Docker likes to be in charge.)
- Molecule Distributed testing using PROXMOX, Linode and GITHUB.
- Using Ansible to build up an ISPConfig VM locally and in Linode.
- Explorations of fail2ban filtering
- Distributed Metrics Collecition via Telegraf and Influxdb V2.  (V3 pending!)
- Distributed Log Collection via Alloy and Loki.  

## 📦 Component Repositories

### [solti-monitoring](https://github.com/jackaltx/solti-monitoring)

**Status:** ✅ Production Ready

A comprehensive monitoring ecosystem for modern infrastructure, integrating metrics and log collection using Telegraf, InfluxDB, Alloy, and Loki. It adds in fail2ban for stand-alone detection/response. There is preliminary work on a WAZUH client for cluster monitoring.
This goal of this collection is to provided tested, deployment-ready roles with advanced testing frameworks and utility scripts for seamless operations.

Developers Note:  I developed in this folder initially. I have left some of the development
artifacts to help anyone interested.  A sanitized set of reference files: inventory.yml, group_vars, and playbooks.
The github molecule testing is too slow to be useful. Proxmox is ok for thoroughness.

---

### [solti-containers](https://github.com/jackaltx/solti-containers)

**Status:** ✅ Production Ready

> **A comprehensive Ansible collection for deploying containerized development and testing services using Podman, Quadlets, and systemd integration.**
Modern development requires lightweight, ephemeral services that can be quickly deployed, tested, and removed. Virtual machines are too heavy for rapid iteration cycles. This collection addresses the need for:

- **Consistent deployment patterns** across different services
- **Lightweight testing environments** using containers instead of VMs
- **Easy service lifecycle management** (prepare → deploy → verify → remove)

---

### [solti-ensemble](https://github.com/jackaltx/solti-ensemble)

**Status:** 🚧 In Development

A comprehensive collection of Ansible roles for infrastructure automation, security hardening, and development environment setup. Part of the SOLTI (Systems Oriented Laboratory Testing & Integration) ecosystem.
This collection provides battle-tested Ansible roles covering everything from security auditing to development tooling. Each role is designed with best practices, security, and maintainability in mind, featuring advanced testing frameworks and AI-powered analysis capabilities.
The collection provides integrated automation with clear patterns:

- **claude_sectest**: Multi-script security auditing with Git-based change tracking and Claude AI analysis
- **sshd_harden**: SSH daemon hardening with modern cryptographic algorithms

---

### [solti-conductor](https://github.com/jackaltx/solti-conductor)

**Status:** 📋 Planned

*This component is planned for future development*

---

### [solti-score](https://github.com/jackaltx/solti-score)

**Status:** 📋 Planned

*This component is planned for future development*

---

## 🎵 Name Origin

- **S**ystems: Managing and testing system-of-systems
- **O**riented: Structured and purposeful approach
- **L**aboratory: Controlled testing environment
- **T**esting: Verification and validation
- **I**ntegration: Component interconnection and interaction

Named after [Sir Georg Solti](https://en.wikipedia.org/wiki/Georg_Solti), renowned for his precise and analytical conducting style.
His [Wagner](https://en.wikipedia.org/wiki/Der_Ring_des_Nibelungen_(Georg_Solti_recording)) works have held up to time.

## 🧪 Testing Philosophy

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

## 🛠️ Technology Stack

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

## 🔒 Security Considerations

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

## 📄 License

The concept is open. All my work will be MIT.

## 📞 Contact

Use github for now.
