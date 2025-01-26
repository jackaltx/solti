# SOLTI - Systems Oriented Laboratory Testing & Integration

## Overview

SOLTI provides a comprehensive framework for testing and integrating system components in a controlled environment. The project emphasizes methodical testing, system behavior analysis, and component integration.

## Goal

I have done small lab clusters for a while. Not the HVAC kind, but those that are built to task when/as desired. 
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

Why Claude? Serendipity really. A smart young fellow showed me ChatGPT and it was cool.  A year later he showed me how he was using Claude.  After a couple of hours I signed up.  Now that bright
young fellow has moved on. His reason was that claude is sandboxed. It can't access the code and I cannot get their MCP to work on Windows or Linux. 
So it only see's the "artifacts" that I have uploaded to it. It cannot run any of the code it generates, but it sure looks pretty. Makes the debugging session that are infuriating. 
Sometimes it looks at the artifacts and other times not at all. My main caution is "don't let it take you too far from your vision". You will need to pull in the reigns from time to time and focus.  
More than once we have gone in circles and core issue was a deeper structurals issue. An example of that kind of issue is the Proxmox-ve LXC interface via command line interface, pct exec, does 
not create a shell which does not allow you to pipe over files.  This breaks ansible interface module for configuration. 
I got to learn several techniques for building an commmand, but none them can ever work (but I have an idea that I might try one day)

### Current Focus with Claudee

Work towards standardizing a reporting flow. We have now moved to more feature testing (i.e., logging, metrics) focus over three primary 
linux distros (i.e., rocky93, Debian12, Ubuntu24) with three computes (i.e., promox-ve, podman, github).   So to keep some orthogonality 
in this 3D matrix I want to keep the verify outputs to the feature (logging,...)  and separate the outputs into an assembly pipeline.  
For each test run on github I want a short version for GIST output and Wiki Detail report for all tagged version and last three for the 
main branch. On github it will continue to put the files in verify_output/  in the saved output.  How should we proceed?


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
