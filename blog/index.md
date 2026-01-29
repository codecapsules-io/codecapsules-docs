# Production WordPress Hosting: Single Server vs AWS vs Managed vs Code Capsules

Production in WordPress can get quickly serious: AWS published a document suggesting that you move to their services, and from our calculations, you will be paying them 1500$ per month, just like that. However, you can also find hosting options starting at 5 per month for a single DigitalOcean droplet and for others.

The price difference reflects different approaches to reliability, scalability, and operational complexity. A $5 single-server setup requires manual security patches, backup scripts, and accepts downtime during traffic spikes. AWS's architecture provides enterprise reliability but needs dedicated DevOps staff to manage CloudFront, load balancers, auto-scaling groups, and distributed databases.

This comparison breaks down what you pay for with each hosting approach, helping you match infrastructure costs to your team's technical capacity and production requirements.

## Single-Server WordPress Hosting

Single-server WordPress runs everything on one machine: web server, PHP, MySQL, and file storage. DigitalOcean Droplets and Amazon Lightsail offer this for $5 to $20 per month.

![Single server WordPress architecture](../tutorials/.gitbook/assets/single-server-wordpress.png)

With a single-server WordPress website, scaling requires handling several operational challenges:

- **Traffic Spikes:** When your marketing team sends a newsletter, 1,000 concurrent visitors means 1,000 PHP processes competing for CPU, while database connections exhaust MySQL's connection pool. Separating the application server from the database server allows each to scale independently based on resource demands.
- **Hardware Failures and Maintenance:** When the server reboots for system updates or a plugin update crashes PHP, your entire site goes offline. This requires redundancy across multiple servers or accepting downtime during failures.
- **Storage Scaling:** As your media library grows, you need to expand disk space. On a single server, this means upgrading to a larger instance and migrating all data. Separated storage scales file storage independently, without touching your application or database.

However, a single-server or self-hosted approach provides complete control. You choose your tech stack, install any software, and customize everything. The cost is your time, spent on tasks such as server administration, security patching, backup verification, and troubleshooting when issues arise.

Self-hosted VPS requires technical expertise. You need to understand Linux server administration, MySQL database tuning, PHP configuration, web server optimization, and security hardening. For teams with DevOps resources, this works. For teams focused on content and marketing, the maintenance overhead outweighs the cost savings.

## Managed WordPress Hosting

Managed WordPress providers like Kinsta and WP Engine handle server configuration, updates, security, and backups for you.

- **Kinsta** starts at $35 per month for a single site with 25,000 monthly visits, 10 GB storage, and automatic backups. This includes Cloudflare CDN, malware scanning, and staging environments. The plan scales to $675 per month for 250,000 visits and 100 GB storage.
- **WP Engine** starts at $20 per month for personal sites with 25,000 monthly visits and 10 GB storage. Business plans supporting 100,000 visits and staging environments begin at $50 per month. Enterprise plans reach over $500 per month.

These services provide convenience. You get WordPress optimized for performance without managing servers yourself. The tradeoff is limited control. You can't install custom server software, extensively modify PHP configurations, or integrate WordPress into your existing infrastructure automation.

## AWS Enterprise Architecture

AWS's reference architecture for production WordPress runs 11 services: CloudFront CDN, Application Load Balancer, EC2 Auto Scaling, Elastic File System, Aurora, ElastiCache, S3, NAT Gateways, and VPC networking. Monthly costs range from $500 to $1,500, depending on traffic.

![WordPress high availability architecture by Bitnami](../tutorials/.gitbook/assets/wordpress-aws-architecture.png)

This architecture provides enterprise-grade reliability and scale. You get distributed infrastructure, automatic failover, and performance optimization. The tradeoff is complexity. You need dedicated DevOps staff to monitor, maintain, and debug across all these services. Troubleshooting failures requires expertise in multiple AWS services simultaneously.

AWS also provides no built-in WordPress staging-to-production migration. You need expensive sync plugins (over $200 per year) or custom deployment scripts.

## Code Capsules

![Code Capsules WordPress architecture](../tutorials/.gitbook/assets/code-capsules-wordpress-architecture.png)

Code Capsules WordPress hosting starts with separate application, database, and storage Capsules. Billing is based on actual resource usage.

A typical small production setup costs approximately $15 to $25 per month and includes:

- A WordPress application Capsule handling web traffic
- A MySQL database Capsule with automatic daily backups
- A storage Capsule for media files with backup retention

Staging environments add the same components, roughly doubling the cost for a complete staging-to-production setup, at $30 to $50 per month in total. This includes:

- Infrastructure-level backups
- One-click staging-to-production migration
- Auto-scaling for traffic spikes
- Separated application, database, and storage layers

 There are no plugin licensing costs, no DevOps staff requirements, and no complex AWS service configurations.

The hosting option you choose depends on your resources and need for control.

- If you have DevOps resources and need complete control, a self-hosted VPS or AWS provides maximum flexibility.
- If you're a small team focused on content rather than infrastructure, managed solutions eliminate maintenance overhead.
- If you sit between these extremes, Code Capsules provides managed infrastructure with staging and production workflows, without the premium pricing of fully managed WordPress hosts or the complexity of AWS enterprise architecture.

| Feature                             | Managed WordPress (Kinsta/WP Engine) | Self-Hosted VPS                        | AWS Enterprise                                | Code Capsules                                |
| ----------------------------------- | ------------------------------------ | -------------------------------------- | --------------------------------------------- | -------------------------------------------- |
| **Monthly Cost**                    | $35-100                              | $10-40                                 | $500-1,500                                    | Starting $30                                 |
| **Setup Time**                      | Minutes                              | Hours                                  | Days                                          | Minutes                                      |
| **DevOps Required**                 | No                                   | Yes                                    | Yes                                           | No                                           |
| **Staging Environment**             | Included                             | Manual setup                           | Manual setup                                  | Included                                     |
| **Staging-to-Production Migration** | Manual or plugins ($200+/year)       | Custom scripts                         | Custom scripts                                | One-click built-in                           |
| **Auto-scaling**                    | Limited                              | Manual                                 | Full control                                  | Automatic                                    |
| **Infrastructure Control**          | Limited                              | Complete                               | Complete                                      | Moderate                                     |
| **Backup Management**               | Automatic                            | Manual setup                           | Manual setup                                  | Automatic infrastructure-level               |
| **Database Size Limits**            | Plan-dependent                       | Server capacity                        | Unlimited                                     | Capsule plan                                 |
| **Performance Optimization**        | Managed by provider                  | Your responsibility                    | Your configuration                            | Platform-managed                             |
| **Security Updates**                | Managed by provider                  | Your responsibility                    | Your responsibility                           | Platform-managed                             |
| **Custom Server Software**          | No                                   | Yes                                    | Yes                                           | Limited                                      |
| **Best For**                        | Non-technical teams, simple sites    | Teams with DevOps, custom requirements | Enterprise with dedicated infrastructure team | Technical teams needing workflow integration |

## Conclusion

WordPress hosting costs reflect the trade-off between control, convenience, and operational overhead. You should choose based on your team's technical capacity, not just monthly cost. A $10 VPS becomes expensive when factoring in time spent on security patches, backup verification, and troubleshooting during outages. A $50 managed host becomes limiting when you need custom server configurations.

For a complete guide to setting up production WordPress on Code Capsules, see [How to Host a Production WordPress Blog](link-to-main-tutorial).