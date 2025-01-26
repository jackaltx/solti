# SOLTI - Systems Oriented Laboratory Testing & Integration

## Overview

SOLTI provides a comprehensive framework for testing and integrating system components in a controlled environment. The project emphasizes methodical testing, system behavior analysis, and component integration.

## Goal

I have done small lab clusters for a while. Not the HVAC kind, but those that are built to task when/as desired. 
The software and hardware technology half-life is real. The desirements and requirements alway grow tigher. 

In the last few years I was focused on security testing.  I am a kinestic creative, so I focus on how to build out a sustainable system.
For this exercise I want to learn ansible, containers, github and LLMs.  I have started on [cluster monitoring]([https://www.example.com](https://github.com/jackaltx/solti-monitoring)), both log and metric collection. 

The collection work is mature, and I am starting on the ensemble work.  My goal is to [DRY](https://en.wikipedia.org/wiki/Don%27t_repeat_yourself) the molecule testing pattern and add a few tools I need.

## Claude as my pair programmer

Claude writes a lot of code quickly and has been very helpful.  It has been interesting to learn about my limits. Claude is tool, if you know what you want you can likley get it.  
But sometimes the journey will be rocky and hard.  You will explore areas you likley have not considered viable.  Sometimes that is a good thing.  Debugging with Claude can go far afield.
However, when I keep to my north star and focus on the goal the product looks good.   

Claude wrote the first draft of this, and helped come up with tool ideas. Claude's writing is better than mine. The ability to review all the code and come up with a good readme has been fantastic.

Why Claude? Serendipity really. A smart young fellow showed me ChatGPT and it was cool.  A year later he showed me how he was using Claude.  After a couple of hours I signed up.  Now that bright
young fellow has moved on, but this is working well for me.  And the AI is just a tool getting me where I want to go.  

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
a flexible and testable cluster out of services writen by other people. To accomplis that
I am using the Ansible inventory to define the cluster interactions. Ansible roles are idempotent scripts 
that install, configure, test the clusters intended functionality. This is our starting. ansible galaxy 
collection structure concept. 

```
jackaltx/
├── solti/monitoring/   # System monitoring and metrics collection
├── solti/conductor/    # Proxmox management and orchestration
├── solti/ensemble/     # Support tools and shared utilities
└── solti/score/       # Documentation and playbooks
```
To realize this, I use this logical repository structure on github

```
jackaltx/
├── solti-monitoring/   # System monitoring and metrics collection
├── solti-conductor/    # Proxmox management and orchestration
├── solti-ensemble/     # Support tools and shared utilities
└── solti-score/       # Documentation and playbooks
```
### solti-monitoring

Current implementation includes:

- Metrics collection (Telegraf)
- Time-series storage (InfluxDB)
- Log aggregation (Loki)
- OpenTelemetry collection (Alloy)
- Shared configurations and utilities

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

## Development Guidelines

- Modular design
- Clear separation of concerns
- Comprehensive testing
- Documented interfaces
- Version controlled components
- Consistent naming conventions

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
