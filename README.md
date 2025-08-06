# SOLTI - Systems Oriented Laboratory Testing & Integration

## Overview

SOLTI provides a comprehensive framework for testing and integrating system components in a controlled environment. The project emphasizes methodical testing, system behavior analysis, and component integration.

## Goal

I have done small lab clusters for a while. Not the high availability kind, but those that are built to task when/as desired.
The software and hardware technology half-life is real. The desirements and requirements alway grow tigher.

Lately the focus was on security testing. As a kinestic creative I learn best by doing. The prize is building out a flexible, repeatable, testable computer cluster.
In this exercise I wanted to learn ansible, containers, github and LLMs. These efforts started on [cluster monitoring](https://github.com/jackaltx/solti-monitoring)
to handle log and metric generation and collection.  The collection project is maturing, and I am starting on the ensemble work.  My tactical effort will
be to [DRY](https://en.wikipedia.org/wiki/Don%27t_repeat_yourself) the molecule testing pattern, then move onto tools I need soon.

## Claude as my pair programmer

Claude writes a lot of code quickly and has been very helpful.  It has been interesting to learn about my limits. Claude is tool, if you know what you want you can likley get it.  
But sometimes the journey will be rocky and hard.  You will explore areas you likley have not considered viable.  Sometimes that is a good thing.  Debugging with Claude can go far afield.
However, when I keep to my north star and focus on the goal the product looks good.

Claude wrote the first draft of this, and helped come up with tool ideas. Claude's writing is better than mine. The ability to review all the code and come up with a good readme has been fantastic.

Why Claude? Serendipity really. A smart young fellow showed me ChatGPT and it was cool.  A year later he showed me how he was using Claude.  After a couple of hours of exploration I signed up with a plan to do a years worth of coding ideas.  

That bright young fellow has moved onward. One of his reasons was how claude is sandboxed. It can't access the code directly.  I see changed in that staring.   I like the MCP concept, but I have not gotten it to work
outside of my Mac. I am sure it will all come togther when time is right.

Currently it only see's the "artifacts" that I have uploaded to it. It cannot run any of the code it generates, and it sure looks pretty.  Yet, the debugging sessions are infuriating.  Mostly because I am using the AI to teach me the language and sometine the application. It's often a two steps forward and many back.

There are times the AI looks at the artifacts  (or uploads) and other times not at all. There are moments of brilliance punctuated by moments of "you are wrong and this is why". The amount of energy it has to put forth is variable, and the results show it.

My main caution is "don't let it take you too far from your vision". You will need to pull in the reigns from time to time and focus on the "why". I have notices two distinct patterns emerge when debuging with the AI: the oak and willow.  

The oak path is on where it has decided the path to solving the problem is just a tweak away. It had no concept that the changes were gong to create a maintenance issue.  After all this is the job, deliver it and
move on. It is logical and given the speed it can deliver a possible solution when things change, that may be good enough.

The willow path bends to a will. More than once we have gone in circles and core issue was a deeper structurals issue. An example of that kind of issue is the Proxmox-ve LXC interface via command line interface, pct exec, does not create a shell which does not allow you to pipe over files.  This breaks ansible interface module for configuration. I got to learn several techniques for building an commmand, but none them can ever work (but I have an idea that I might try one day)

Finding balance requires me to learn how to work with this tool. The results are impressive and I am generally pleased with freults.

### Current Focus with Claudee

Work towards standardizing a reporting flow. We have now moved to more feature testing (i.e., logging, metrics) focus over three primary linux distros (i.e., rocky93, Debian12, Ubuntu24) with three computes (i.e., promox-ve, podman, github).   So to keep some orthogonality in this 3D matrix I want to keep the verify outputs to the feature (logging,...)  and separate the outputs into an assembly pipeline.

For each test run on github it create a short version for GIST output and Wiki Detailed report for all tagged versions and last three for the main branch. On github it will continue to put the files in verify_output/ in the saved output.

I have elected to move from GIST to mattermost.  Mainly because it is cool to use githubs computer to run tests, but is SLOW to develop and they are limited.  So I will do my regression testing locally.  Mattermost for notications and Elasticsearch for results.  

To support that I decided to create solti-containers. This is a patter for creates localhost services that have configured with some rigor and security in mind.  So, I took the ansible work and had the AI use that patter to create a few services.  These will be refined in attempt to create a reusable framework for adding the "next" one.  Which will be minio to support S3 buckets.

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
