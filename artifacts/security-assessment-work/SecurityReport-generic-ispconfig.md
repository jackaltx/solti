# Production Web Hosting Server: Security and Configuration Assessment

**Server:** angela.example.com (hostname: angela)  
**IP Address:** 50.116.###.### (public), 10.#.#.1 (private)  
**Date:** March 22, 2025  
**Assessment Type:** Configuration and Security Analysis  

## Executive Summary

This assessment evaluates a mature production web hosting environment running ISPConfig on Debian 11 (Bullseye). The server hosts multiple websites and domains, provides extensive PHP version compatibility (PHP 5.6 through 8.4), and offers additional services including Git repository hosting. The system demonstrates proper security implementations, with active firewall, comprehensive fail2ban configurations, and TLS enforcement across all services. The server has been operational for an extended period (17+ weeks uptime) and shows evidence of active client usage with 13 configured virtual hosts and 14 DNS zones.

## 1. System Information and Configuration

### 1.1 System Details

| Component | Information |
|-----------|-------------|
| Hostname | angela |
| FQDN | angela.example.com |
| Operating System | Debian 11 (Bullseye) |
| Kernel | 5.10.0-33-amd64 |
| CPU | AMD EPYC 7713 64-Core Processor |
| Memory | 3.8 GB |
| Disk | 79 GB (46% used) |
| Uptime | 17 weeks, 3 days, 5 hours, 56 minutes |
| Control Panel | ISPConfig 3.2.12p1 |

### 1.2 Network Configuration

| Component | Details |
|-----------|---------|
| Primary Public IP | 50.116.###.###/24 |
| Private IP | 10.#.#.1/24 |
| IPv6 Support | Enabled |
| Open Ports | HTTP(S), Mail, DNS, SSH, FTP |

### 1.3 Hosted Services

| Service | Purpose | Status |
|---------|---------|--------|
| Web Hosting | Apache with 13 virtual hosts | Active |
| Email | Postfix/Dovecot with spam protection | Active |
| DNS | BIND with 14 zones | Active |
| FTP | Pure-FTPd with TLS | Active |
| Database | MariaDB (8 databases) | Active |
| Git Hosting | Gitea on port 3000 | Active |
| Monitoring | Telegraf agent | Active |
| Observability | Alloy (port 12345) | Active |

## 2. Security Assessment

### 2.1 Perimeter Security

| Control | Status | Notes |
|---------|--------|-------|
| Firewall | ACTIVE | UFW properly configured with specific rules |
| Intrusion Prevention | STRONG | 23 fail2ban jails configured for all key services |
| Service Exposure | CONTROLLED | Only necessary ports open |
| TLS Configuration | SECURE | Insecure protocols (SSLv2/3) disabled |

### 2.2 Authentication and Access Controls

| Control | Status | Notes |
|---------|--------|-------|
| SSH Access | SECURE | Protected by fail2ban |
| FTP Access | SECURE | TLS enabled, protected by fail2ban |
| Web Applications | MONITORED | Custom fail2ban rules for WordPress and phpMyAdmin |
| Email Authentication | BASIC | Only PLAIN authentication mechanism enabled |

### 2.3 Malware and Threat Protection

| Control | Status | Notes |
|---------|--------|-------|
| Antivirus | ACTIVE | ClamAV running (using 34.6% of memory) |
| Spam Filtering | LAYERED | Rspamd, RBL checks via Spamhaus, custom restrictions |
| Brute Force Protection | COMPREHENSIVE | Multiple fail2ban jails with recidive detection |
| Malicious Bot Protection | ACTIVE | Custom badbots and badbots-jkl fail2ban rules |

## 3. Communications and Network Analysis

### 3.1 IPv6 Configuration

| Component | Status | Notes |
|-----------|--------|-------|
| IPv6 Addresses | CONFIGURED | Global address (2600:3c00::f03c:93ff:fe51:279d) and link-local addresses |
| IPv6 Firewall | ACTIVE | UFW and fail2ban properly configured for IPv6 with equivalent rules to IPv4 |
| IPv6 Services | COMPLETE | All critical services (web, mail, SSH) listening on IPv6 interfaces |
| DNS over IPv6 | CONFIGURED | BIND listening on both IPv4 and IPv6 addresses |

The server has proper IPv6 configuration with a global address from the 2600:3c00::/32 range (likely Linode), suggesting this is a production server with full IPv6 connectivity. The firewall is appropriately configured with specific rules for IPv6 traffic, including fail2ban integration to block malicious activity.

### 3.2 Service Communication Patterns

| Service | Communication Type | Notes |
|---------|-------------------|-------|
| Rspamd | Internal DNS queries | 40+ active DNS lookups for spam filtering |
| Apache | Proxying to Gitea | Multiple connections to internal Gitea service |
| IMAP | Active client connections | Multiple external email clients connected |
| Telegraf | Metrics reporting | Connecting to monitoring endpoint (10.10.0.11:8086) |
| Alloy | Metrics collection | Internal connection to 10.10.0.11:3100 |
| PHP-FPM | Unix sockets | All PHP versions using Unix sockets for security |
| Dovecot | Inter-process | Using sockets for communication between components |
| SSH | Active session | One active SSH session from 68.116.154.158 |

Analysis of active connections reveals a sophisticated service architecture with proper security practices:

1. **Email Filtering**: Rspamd maintains numerous active DNS queries for real-time spam and malware detection, showing active email traffic processing.

2. **Layered Web Architecture**: Apache proxies to internal Gitea service on localhost:3000, providing secure access to Git repositories without directly exposing Gitea.

3. **Monitoring Infrastructure**: Connections to 10.10.0.11 for metrics reporting indicate a separate monitoring infrastructure on a private network segment.

4. **Security-Focused Configuration**: Use of Unix sockets for internal service communication (PHP-FPM, Dovecot, Redis) rather than TCP sockets improves security by reducing network exposure.

5. **Active Email Usage**: Multiple active IMAP connections from Microsoft email servers (40.99.238.109, 52.96.203.205, 52.96.16.189) indicate the server is actively used for email hosting.

### 3.3 Network Security Observations

| Observation | Security Implication |
|-------------|---------------------|
| Active fail2ban | 31+ blocked IPv6 addresses in recidive jail |
| Private network segment | 10.10.0.0/24 for internal services |
| Limited listening interfaces | Most services bound to loopback or specific interfaces |
| Socket usage | Extensive use of Unix sockets reduces network attack surface |
| Email client connections | Active IMAP sessions from external clients |

The server shows signs of ongoing security protection with numerous blocked IP addresses in the fail2ban recidive jail, indicating persistent attackers that have been successfully blocked. The network architecture employs proper segmentation with internal services isolated on private network segments.

## 4. Hosting Environment Analysis

### 4.1 Web Hosting Configuration

| Component | Status | Notes |
|-----------|--------|-------|
| Apache Configuration | OPTIMIZED | HTTP/2 enabled, security modules loaded |
| PHP Support | EXTENSIVE | PHP 5.6 through 8.4 with FPM for versions 5.6-8.2 |
| SSL Certificates | MANAGED | Let's Encrypt integration via acme.sh |
| Virtual Hosts | ACTIVE | 13 configured domains |

Hosted Domains:

- XXXXX.com (including ghost.lavweb.com, gitea.lavweb.com)
- YYY.net
- jackZZZZZZaltx.com
- SSSSSSSSSS.com
- thejuTTTTTnkymonkey.com
- AAAAAAAAAAAAA0.org

### 3.2 Database Environment

| Aspect | Details |
|--------|---------|
| MariaDB Version | 10.5.28 |
| Total Databases | 8 |
| Client Databases | 5 customer databases |
| System Databases | 3 (ISPConfig, phpMyAdmin, Roundcube) |

Client database usage suggests:

- WordPress installations (c1_wp, c2_wpdb)
- Ghost CMS (c1_ghost)
- Gitea repository hosting (c1_gitea)
- Bookstack documentation platform (c1_lavweb_bookstack)

### 3.3 Email Configuration

| Aspect | Details |
|--------|---------|
| Mail Hostname | angela.example.com |
| SMTP Security | TLS enforced, insecure protocols disabled |
| Spam Protection | Spamhaus RBL, Rspamd |
| Webmail | Roundcube |
| IMAP/POP3 | Secured with TLS |

### 3.4 DNS Hosting

| Aspect | Details |
|--------|---------|
| BIND Version | 9.16.50 |
| Total Zones | 14 |
| Security | Protected by fail2ban rules for refused DNS queries |

Managed domains include:

- JJJJJJJJJ.com, JJJJJJJJJJ.us
- LLLLLLL.com, example.com
- SSSSSSSSSS.com, SSSSSSSSSSSSS.org
- TTTTTTTTTTTTTTT.com
- VVVVVVVVVVVVVVVVVVVV.com
- GGGGGGGGGGGGGGGGGGGGG.com
- MMMMMMM.com
- LLLLLLLLLLLLL.com
- DDDDDDDDDDDDDDDDDDDDDD.org
- AAAAAAAAAAAAAAAAAAAAAAAA.com
- DDDDDDDDDDDDDDDDDD.com

## 4. Performance and Resource Utilization

### 4.1 Resource Allocation

| Process | CPU Usage | Memory Usage | Purpose |
|---------|-----------|--------------|---------|
| Alloy | 2.8% | 3.1% | Observability platform |
| Telegraf | 0.8% | 1.9% | Metrics collection |
| Fail2ban | 0.6% | 1.1% | Intrusion prevention |
| Gitea | 0.1% | 3.3% | Git repository hosting |
| Redis | 0.1% | 1.4% | In-memory data store |
| MariaDB | 0.1% | 5.9% | Database server |
| ClamAV | 0.0% | 34.6% | Antivirus scanning |

### 4.2 Observed Issues

| Issue | Severity | Recommendation |
|-------|----------|----------------|
| ClamAV Memory Usage | MEDIUM | Optimize ClamAV configuration to reduce memory footprint |
| Limited System Memory | LOW | Consider memory upgrade if adding more services or clients |
| High Process IDs | INFORMATIONAL | Indicative of long runtime; consider regular reboots |

## 5. Vulnerabilities and Recommendations

### 5.1 Critical Findings

*No critical findings identified*

### 5.2 High-Priority Findings

1. **Legacy PHP Versions**
   - Finding: PHP versions 5.6-7.3 are end-of-life with known security vulnerabilities
   - Risk: Potential for exploitation of known vulnerabilities in legacy applications
   - Recommendation: Encourage clients to upgrade to supported PHP versions; isolate legacy applications

### 5.3 Medium-Priority Findings

1. **Email Authentication**
   - Finding: Dovecot configured to use only PLAIN authentication
   - Risk: Potential exposure of credentials without stronger authentication methods
   - Recommendation: Enable additional secure authentication mechanisms

2. **Memory Allocation**
   - Finding: ClamAV consuming 34.6% of available system memory
   - Risk: Potential resource constraints during peak usage
   - Recommendation: Optimize ClamAV configuration or increase system memory

### 5.4 Low-Priority Findings

1. **Monitoring Configuration**
   - Finding: Monitoring tools (Telegraf, Alloy) consume notable system resources
   - Risk: Minor performance impact
   - Recommendation: Review and optimize data collection frequency if needed

## 6. NIST 800-53 Control Compliance Summary

| Control Family | Status | Notable Implementations |
|----------------|--------|-------------------------|
| Access Control (AC) | STRONG | Role-based access through ISPConfig, service authentication |
| Audit & Accountability (AU) | MODERATE | Service logging, but centralized audit unconfirmed |
| Configuration Management (CM) | STRONG | Consistent configuration across services |
| Contingency Planning (CP) | UNKNOWN | Backup strategies not evident in assessment |
| Identification & Authentication (IA) | MODERATE | Authentication present but improvements possible |
| Incident Response (IR) | MODERATE | Fail2ban provides automated response |
| Maintenance (MA) | STRONG | Evidence of regular updates (recent package versions) |
| Media Protection (MP) | UNKNOWN | Not assessed |
| Physical Protection (PE) | UNKNOWN | Not assessed |
| Risk Assessment (RA) | MODERATE | Security controls suggest risk awareness |
| System & Communications Protection (SC) | STRONG | TLS, firewall, and network segmentation |
| System & Information Integrity (SI) | STRONG | Malware protection, regular updates, monitoring |

## 7. Conclusion

This server represents a mature, production-grade web hosting environment delivering multiple services to various clients. The configuration demonstrates strong security practices with an active firewall, comprehensive intrusion prevention, and proper TLS implementation across all services. The extensive PHP version support (5.6-8.4) indicates a focus on compatibility for diverse client requirements, while additional services like Gitea provide enhanced functionality beyond basic web hosting.

The system has been operational for an extended period (17+ weeks) and shows evidence of active use with multiple virtual hosts, DNS zones, and client databases. While the legacy PHP versions present a security consideration, the overall security posture is robust with layered defenses against common threats.

The server's configuration suggests it is operated by a professional hosting provider (evidenced by the lavweb.com and example.com domains) serving multiple clients with diverse requirements ranging from standard web hosting to specialized applications like Ghost CMS and Bookstack documentation.

---

## Appendix A: Software Bill of Materials (BOM)

### 1. Core Services

| Service Name | Version | Description | Status |
|--------------|---------|-------------|--------|
| ISPConfig | 3.2.12p1 | Hosting control panel | Running |
| MariaDB | 10.5.28 | Database server | Running |
| Apache | 2.4.62 | Web server | Running |
| Postfix | 3.5.25 | Mail transfer agent | Running |
| Dovecot | 2.3.13 | IMAP/POP3 server | Running |
| Bind9 | 9.16.50 | DNS server | Running |
| Pure-FTPd | 1.0.49 | FTP server | Running |
| ClamAV | 1.0.7 | Antivirus engine | Running |
| Rspamd | 3.11.1 | Email spam filter | Running |
| Redis | 6.0.16 | In-memory data store | Running |
| Fail2ban | 0.11.2 | Intrusion prevention | Running |
| UFW | Debian 11 version | Firewall | Active |

### 2. PHP Environment

| Component | Version | Description | Status |
|-----------|---------|-------------|--------|
| PHP | 5.6.40 | Legacy PHP version | FPM Running |
| PHP | 7.0.33 | Legacy PHP version | FPM Running |
| PHP | 7.1.33 | Legacy PHP version | FPM Running |
| PHP | 7.2.34 | Legacy PHP version | FPM Running |
| PHP | 7.3.33 | Legacy PHP version | FPM Running |
| PHP | 7.4.33 | Legacy PHP version | FPM Running |
| PHP | 8.0.30 | PHP version | FPM Running |
| PHP | 8.1.32 | PHP version | FPM Running |
| PHP | 8.2.28 | PHP version | FPM Running |
| PHP | 8.3.19 | PHP version | Installed |
| PHP | 8.4.5 | PHP version | Installed |

### 3. Web Applications

| Application | Version | Description | Status |
|-------------|---------|-------------|--------|
| phpMyAdmin | 5.2.2 | Database management | Installed |
| Roundcube | 1.4.15 | Webmail client | Installed |
| Gitea | Latest | Git repository hosting | Running |
| Ghost | Unknown | Blog platform | Running |
| WordPress | Unknown | Content management | Multiple instances |
| Bookstack | Unknown | Documentation platform | Running |
| acme.sh | 3.1.0 | Let's Encrypt client | Installed |

### 4. Monitoring and Observability

| Tool | Version | Description | Status |
|------|---------|-------------|--------|
| Telegraf | Unknown | Metrics collection agent | Running |
| Alloy | Unknown | Observability platform | Running (port 12345) |

### 5. Security Components

| Component | Description | Status |
|-----------|-------------|--------|
| Fail2ban | Intrusion prevention with 23 jails | Active |
| UFW | Uncomplicated Firewall | Active with configured rules |
| ClamAV | Antivirus scanning | Active |
| Rspamd | Spam filtering | Active |
| Postgrey | Greylisting policy server | Active |
