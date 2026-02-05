
# Production WordPress Hosting: Single Server vs AWS Architecture vs Managed Solutions vs Code Capsules

The cost of hosting a WordPress production site ranges from $5 single-server setups to AWS's 11-service architecture costing $500 to $1,500 monthly. The AWS [2018 reference architecture](https://aws.amazon.com/blogs/architecture/wordpress-best-practices-on-aws/) assumes you have dedicated DevOps staff to manage CloudFront, load balancers, auto-scaling groups, and distributed databases.

The price difference reflects different approaches to reliability, scalability, and operational complexity. A $5 single-server setup requires manual security patches, backup scripts, and accepts downtime during traffic spikes. The $1,500 AWS architecture provides enterprise reliability but needs dedicated DevOps staff to manage 11 separate services.

This comparison breaks down what you pay for with each hosting approach, so that you can choose infrastructure to suit your team's technical capacity, budget, and production requirements.

## Self-Hosted VPS

By hosting WordPress on a single virtual private server (VPS), you can run everything on one machine: web server, PHP, MySQL, and file storage. DigitalOcean Droplets and Amazon Lightsail offer this for $5 to $20 per month.

![Single server WordPress architecture](../tutorials/.gitbook/assets/single-server-wordpress.png)

Scaling a single-server WordPress site creates operational challenges:

- **Traffic Spikes:** When your marketing team sends a newsletter, 1,000 concurrent visitors means 1,000 PHP processes competing for CPU, while database connections exhaust the MySQL connection pool. Separating the application server from the database server allows each to scale independently based on resource demands.
- **Hardware Failures and Maintenance:** When the server reboots for system updates or a plugin update crashes PHP, your entire site goes offline. This requires adding redundancy across multiple servers or accepting downtime during failures.
- **Storage Scaling:** As your media library grows, you need to expand disk space. On a single server, this means upgrading to a larger instance and migrating all data. Separated storage scales the file system independently, without touching your application or database.

Single-server hosting provides complete control. You choose your tech stack, install any software, and customize everything. The cost is your time: hours spent on server administration, security patching, backup verification, and troubleshooting.

Single-server hosting works for teams with DevOps resources who can handle Linux administration, MySQL tuning, and security hardening. For teams focused on content and marketing, the maintenance overhead outweighs the cost savings.

## Managed WordPress Solutions

Managed WordPress providers like Kinsta and WP Engine handle server configuration, updates, security, and backups.

**Kinsta** starts at $35 per month for a single site with 25,000 monthly visits, 10 GB storage, and automatic backups. This includes Cloudflare CDN, malware scanning, and staging environments. The plan scales to $675 per month for 250,000 visits and 100 GB storage.

**WP Engine** starts at $20 per month for personal sites with 25,000 monthly visits and 10 GB storage. Business plans supporting 100,000 visits and staging environments begin at $50 per month. Enterprise plans exceed $500 per month.

Managed WordPress provides convenience. You get WordPress optimized for performance without managing servers. The tradeoff is limited control. You can't install custom server software, extensively modify PHP configurations, or integrate WordPress into existing infrastructure automation.

## AWS Enterprise Architecture

The AWS [reference architecture for WordPress](https://aws.amazon.com/blogs/architecture/wordpress-best-practices-on-aws/)  runs 11 services: CloudFront CDN, Application Load Balancer, EC2 Auto Scaling, Elastic File System, Aurora, ElastiCache, S3, NAT Gateways, and VPC networking. Monthly costs range from $500 to $1,500, depending on traffic.

![WordPress high availability architecture by Bitnami](../tutorials/.gitbook/assets/wordpress-aws-architecture.png)

This architecture provides enterprise-grade reliability and scale. You get distributed infrastructure, automatic failover, and performance optimization.

The tradeoff is complexity. You need dedicated DevOps staff to monitor, maintain, and debug the services. Troubleshooting failures requires expertise in multiple AWS services simultaneously.

AWS provides no built-in WordPress staging-to-production migration. You need expensive sync plugins (over $200 per year) or custom deployment scripts.

## Code Capsules

Code Capsules provides separate infrastructure layers for WordPress in the form of independent application, database, and storage Capsules.

![Code Capsules WordPress architecture](../tutorials/.gitbook/assets/code-capsules-wordpress-architecture.png)

Code Capsules billing is based on actual resource usage. A production setup for 10,000-25,000 monthly visitors costs approximately $15 to $25 per month and includes:

- A WordPress Capsule for handling web traffic
- A MySQL Database Capsule with automatic daily backups
- A Storage Capsule for media files with backup retention

Staging environments add the same components, roughly doubling the cost for a complete staging-to-production setup, at $30 to $50 per month total. This includes:

- Infrastructure-level backups
- One-click staging-to-production migration
- Auto-scaling for traffic spikes
- Separated application, database, and storage layers

There are no plugin licensing costs, no DevOps staff requirements, and no complex AWS service configurations.

## Comparison Table

| Feature                             | Managed Solutions                    | Self-Hosted VPS                        | AWS Enterprise                                | Code Capsules                                |
| ----------------------------------- | ------------------------------------ | -------------------------------------- | --------------------------------------------- | -------------------------------------------- |
| **Monthly Cost**                    | $35-100                              | $10-40                                 | $500-1,500                                    | $30-$50                                      |
| **Setup Time**                      | Minutes                              | Hours                                  | Days                                          | Minutes                                      |
| **DevOps Required**                 | No                                   | Yes                                    | Yes                                           | No                                           |
| **Staging Environment**             | Included                             | Manual setup                           | Manual setup                                  | Included                                     |
| **Staging-to-Production Migration** | Manual or plugins ($200+/year)       | Custom scripts                         | Custom scripts                                | One-click built-in                           |
| **Auto-Scaling**                    | Limited                              | Manual                                 | Full control                                  | Automatic                                    |
| **Infrastructure Control**          | Limited                              | Complete                               | Complete                                      | Moderate                                     |
| **Backup Management**               | Automatic                            | Manual setup                           | Manual setup                                  | Automatic infrastructure-level               |
| **Database Size Limits**            | Plan-dependent                       | Server capacity                        | Unlimited                                     | Capsule plan                                 |
| **Performance Optimization**        | Managed by provider                  | Your responsibility                    | Your configuration                            | Platform-managed                             |
| **Security Updates**                | Managed by provider                  | Your responsibility                    | Your responsibility                           | Platform-managed                             |
| **Custom Server Software**          | No                                   | Yes                                    | Yes                                           | Limited                                      |
| **Best For**                        | Non-technical teams, simple sites    | Teams with DevOps, custom requirements | Enterprise with dedicated infrastructure team | Technical teams needing workflow integration |

## Conclusion

The hosting option you choose depends on your resources and need for control.

- If you have DevOps resources and need complete control, a self-hosted VPS or AWS provides maximum flexibility.
- If you're a small team focused on content rather than infrastructure, managed solutions eliminate maintenance overhead.
- If you sit between these extremes, Code Capsules provides managed infrastructure and a staging-to-production workflow without the premium pricing of fully managed WordPress hosts or the complexity of AWS enterprise architecture.

For a complete guide to setting up WordPress sites on Code Capsules, see [How To (Simply) Host a Production WordPress Blog](/docs/tutorials/how-to-simply-host-a-production-wordpress-blog.md).
