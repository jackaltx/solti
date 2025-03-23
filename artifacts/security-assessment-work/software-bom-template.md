# Software Bill of Materials (BOM)

## 1. Service Inventory

| Service Name | Version | Description | Deployment Location | Owner/Team | Status |
|--------------|---------|-------------|---------------------|------------|--------|
| Service A    | 1.2.3   | User authentication service | AWS EC2 | Auth Team | Production |
| Service B    | 2.0.1   | Payment processing | GCP Kubernetes | Payments Team | Production |
| Service C    | 0.9.5   | Inventory management | On-prem VM | Inventory Team | Development |

## 2. Non-Service Components

### Libraries and Frameworks
| Name | Version | License | Used By (Services) | Purpose |
|------|---------|---------|-------------------|---------|
| Spring Boot | 2.7.0 | Apache 2.0 | Service A, Service B | Application framework |
| React | 18.2.0 | MIT | Service C (Frontend) | UI framework |
| Lodash | 4.17.21 | MIT | Service C (Frontend) | JavaScript utility library |

### Databases
| Name | Version | Type | Used By (Services) | Purpose |
|------|---------|------|-------------------|---------|
| PostgreSQL | 14.5 | SQL | Service A | User data storage |
| MongoDB | 5.0.9 | NoSQL | Service B | Transaction data |
| Redis | 7.0.4 | In-memory | Service A, Service B | Caching layer |

### Infrastructure Components
| Name | Version | Type | Used By (Services) | Purpose |
|------|---------|------|-------------------|---------|
| NGINX | 1.22.0 | Web Server | All services | Load balancing |
| RabbitMQ | 3.10.7 | Message Broker | Service B, Service C | Async communication |
| Elasticsearch | 8.4.0 | Search Engine | Service C | Search functionality |

### Third-Party APIs
| Name | Version | Provider | Used By (Services) | Purpose |
|------|---------|----------|-------------------|---------|
| Stripe API | v2022-08-01 | Stripe | Service B | Payment processing |
| Google Maps API | v3 | Google | Service C | Location services |

## 3. Relationship Mapping

### Service Dependencies
```
Service A → Service B: User verification for payments
Service B → Service C: Inventory availability check
```

### Service to Non-Service Relationships
```
Service A → PostgreSQL: Stores user data
Service A → Redis: Session caching
Service B → MongoDB: Transaction storage
Service B → Stripe API: Payment processing
Service C → Elasticsearch: Product search
```

### Data Flow Diagram (High-Level)
```
[Users] → [Service A] → [Service B] → [Stripe API]
                     ↓
                [Service C] → [MongoDB]
```

## 4. Security and Compliance Information

### Vulnerability Tracking
| Component | Known Vulnerabilities | Patch Status | Risk Level |
|-----------|----------------------|--------------|------------|
| Spring Boot 2.7.0 | CVE-2022-xxxx | Patched | Low |
| PostgreSQL 14.5 | None known | N/A | Low |

### Compliance Requirements
| Service | Compliance Standards | Last Audit Date | Status |
|---------|---------------------|-----------------|--------|
| Service A | GDPR, SOC2 | 2022-06-15 | Compliant |
| Service B | PCI DSS, SOC2 | 2022-07-20 | Compliant |

## 5. Change Management

### Recent Updates
| Date | Component | Change Description | Change Owner |
|------|-----------|-------------------|--------------|
| 2022-08-10 | Service B | Updated to v2.0.1 - Fixed payment timeout issue | Payments Team |
| 2022-08-05 | MongoDB | Upgraded from 5.0.8 to 5.0.9 | Ops Team |

### Planned Updates
| Target Date | Component | Planned Change | Owner |
|-------------|-----------|---------------|-------|
| 2022-09-15 | Service A | Upgrade to v1.3.0 | Auth Team |
| 2022-10-01 | NGINX | Upgrade to 1.23.1 | Ops Team |

## 6. Backup and Recovery Information
| Component | Backup Frequency | Retention Period | Recovery Time Objective |
|-----------|------------------|-----------------|-------------------------|
| PostgreSQL | Daily | 30 days | 4 hours |
| MongoDB | Daily | 30 days | 4 hours |
| Service Configurations | Weekly | 90 days | 12 hours |
