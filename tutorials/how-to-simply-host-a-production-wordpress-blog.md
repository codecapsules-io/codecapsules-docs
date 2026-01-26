---
description: >-
  Learn how to deploy production WordPress with separated application, database, and storage layers, built-in staging-to-production migration, and auto-scaling without AWS complexity.
coverY: 0
layout:
  cover:
    visible: true
    size: hero
  title:
    visible: true
  description:
    visible: true
  tableOfContents:
    visible: true
  outline:
    visible: true
  pagination:
    visible: true
---

# How To (Simply) Host a Production WordPress Blog

The Amazon Web Services (AWS) WordPress reference architecture has become a meme in DevOps circles. The 2018 [best practices whitepaper](https://aws.amazon.com/blogs/architecture/wordpress-best-practices-on-aws/) recommends 11 services costing $500 to $1,500 monthly and assumes you have dedicated DevOps staff. The alternative is a single Amazon Lightsail instance where you handle operating system (OS) updates, security hardening, and MySQL tuning yourself.

Production WordPress needs infrastructure that falls between these extremes: reliable enough to handle traffic spikes and hardware failures, yet simple enough to manage without a DevOps team.

This guide demonstrates how to run a production WordPress site with:

- Separated application, database, and storage layers
- Staging and production environments with one-click migration
- Automatic scaling for traffic spikes
- Infrastructure-level backups

Learn about the operational challenges WordPress creates, the different hosting approaches that address them, and deploying a staging-to-production workflow.

## What You Need To Know 

Hosting WordPress in production is confusing because WordPress doesn't fit standard deployment workflows. You can't version-control content, staging-to-production migration isn't built-in, and backups require you to synchronize files and databases separately. Here's what you need to know to host a production WordPress site simply:

- **Separate Your WordPress Layers from the Start:** WordPress, MySQL, and file storage should run independently. When one layer fails or requires scaling, the others continue to operate.
- **Plan for Staging-to-Production Workflows:** WordPress has no built-in mechanism for migrating between environments. Either set up a plugin-based migration, which costs $99 to $299 per year with manual configuration, or use a hosting platform, like Code Capsules, that offers built-in one-click migrations. Without this, you have to manually recreate approved content or risk breaking production with direct edits.
- **Match Infrastructure to Your Team's Capacity:** A self-hosted VPS (starting from $10 per month) requires you to handle security patches, backups, and scaling. Managed WordPress removes operational work but limits flexibility and costs more (an average of $50 per month for basic plans). Always choose based on whether you have DevOps resources.

## The WordPress Production Problem

In a development team, the workflow for releasing changes usually looks like this:

![Developer workflow diagram](.gitbook/assets/developer-workflow.png)

Your developers write code locally, commit to GitHub, run automated tests, and deploy changes to staging for review. Only after stakeholder approval does anything touch production. Every change is tracked, every deployment is reversible, and nothing reaches your live site without multiple checkpoints.

WordPress doesn't work this way.

![WordPress workflow diagram](.gitbook/assets/wordpress-workflow.png)

WordPress splits data between files and the database, breaking Git workflows:

- You can commit theme changes to Git, but blog posts aren't in your repository.
- You can deploy code via a continuous integration and continuous delivery (CI/CD) pipeline, but database changes occur directly in production via the WordPress Admin dashboard.
- You can run tests on your code, but there's no automated testing for scenarios such as when someone installs a plugin that conflicts with your theme.
- You can roll back a bad deployment, but only file-system changes are rolled back; database modifications remain, so you can't recover from bad content changes.

The real consequences look like this: 

- Marketing installs a plugin on production. It conflicts with your theme, and the site breaks during business hours.
- A content creator deletes a popular post. You can't recover it because there is no Git history for database content.
- You want to test WordPress core updates on staging, but staging content is days behind production.

Your infrastructure may have version control and staging environments, but WordPress makes both nearly impossible without building custom tooling to synchronize databases and file systems between environments. WordPress migration, backups, and staging workflows each require specific approaches to work reliably in production.

## Using WordPress on Code Capsules

Code Capsules provides detailed deployment documentation for WordPress. This section covers setting up the staging-to-production workflow.

- **WordPress Deployment:** Follow the [WordPress deployment guide](https://docs.codecapsules.io/products/wordpress-capsule/deploy) to create your WordPress Capsule with an attached database and storage.
- **Creating Staging and Production Environments:** Deploy two identical WordPress setups, for example, one called `Staging WordPress` and another called `Production WordPress`. Each needs its own database and storage Capsules. This separation ensures staging changes don't affect production until you explicitly migrate them.
- **Configuring Custom Domains:** Navigate to the [**Domains**](https://docs.codecapsules.io/products/wordpress-capsule/domain) tab in each Capsule, then add your custom domains. Use subdomains like `staging.yourblog.com` for staging and `yourblog.com` for production. Configure DNS records for your domain with your domain provider using the instructions provided by Code Capsules.
- **Setting Up the Migration Workflow:** Once both environments are deployed, migrate content from staging to production using the [**Migrate**](https://docs.codecapsules.io/products/wordpress-capsule/migrate) tab in your production Capsule. Select staging as the source and start the migration. Code Capsules handles database synchronization, file transfer, and URL updates automatically.
- **Backup Verification:** Database and storage Capsules automatically back up daily. To confirm backup integrity, check the **Backups** tab in each Capsule, verify the retention settings, and test restoring the backup to a new Capsule.

For ongoing operations, refer to the [WordPress Capsule documentation](https://docs.codecapsules.io/products/wordpress-capsule) for monitoring, logs, and alerting configuration.

### Migrating Content from Staging to Production

In your production WordPress Capsule, navigate to the **Migrate** tab. Select your staging WordPress Capsule as the **Source Capsule**.

Click **Start Migration**. Code Capsules copies your database content, uploaded media files, installed plugins, and theme configurations from staging to production.

![WordPress migration source capsule selection](.gitbook/assets/wordpress-migration-source-selection.png)

Once complete, your production environment will have identical content to the staging environment.

With this setup, writers create posts in staging, editors review the content, and you migrate approved changes to production with a single click.

## Backups in WordPress

A production WordPress site requires comprehensive backups capturing the entire site state. A complete backup includes three components:

- **The Database:** Your MySQL database contains all your site's dynamic content, including posts, pages, comments, user accounts, and plugin settings.
- **The File System:** Your files include themes, plugins, WordPress core, the uploads directory with all images and media, your site's structure, and assets.
- **Off-Site Storage:** Backups stored on the same server as your live site provide no protection against hardware failures or hosting issues. Production backups require external storage.

The critical requirement is synchronization. Your database references files by path and URL. If you back up your database at 2 pm and your files at 3 pm, a blog post created at 2:30 pm may reference an image that doesn't exist in your file backup. Production backups must capture the database and files simultaneously.

### How Code Capsules Handles Backups

Code Capsules implements infrastructure-level backups. Your database and storage Capsules maintain automatic daily snapshots with 30-day retention. These backups run outside WordPress, avoiding performance impact and resource limits.

Database and storage backups capture the same point in time, ensuring a synchronized state. Restoration works regardless of database size, avoiding the 500 MB cPanel limitation that breaks manual restoration for production sites.

With migration and backup requirements established, the next question is cost. Different hosting approaches address these requirements with varying levels of automation, complexity, and price.

## WordPress Hosting Cost Breakdown

The cost of hosting a production WordPress site varies widely based on the approach. Understanding what you're paying for helps you evaluate whether the infrastructure matches your requirements.

### Single-Server WordPress Hosting

Single-server WordPress runs everything on one machine: web server, PHP, MySQL, and file storage. DigitalOcean Droplets and Amazon Lightsail offer this for $5 to $20 per month.

![Single server WordPress architecture](.gitbook/assets/single-server-wordpress.png)

With a single-server WordPress website, scaling requires handling several operational challenges:

- **Traffic Spikes:** When your marketing team sends a newsletter, 1,000 concurrent visitors means 1,000 PHP processes competing for CPU, while database connections exhaust MySQL's connection pool. Separating the application server from the database server allows each to scale independently based on resource demands.
- **Hardware Failures and Maintenance:** When the server reboots for system updates or a plugin update crashes PHP, your entire site goes offline. This requires redundancy across multiple servers or accepting downtime during failures.
- **Storage Scaling:** As your media library grows, you need to expand disk space. On a single server, this means upgrading to a larger instance and migrating all data. Separated storage scales file storage independently, without touching your application or database.

However, a single-server or self-hosted approach provides complete control. You choose your tech stack, install any software, and customize everything. The cost is your time, spent on tasks such as server administration, security patching, backup verification, and troubleshooting when issues arise.

Self-hosted VPS requires technical expertise. You need to understand Linux server administration, MySQL database tuning, PHP configuration, web server optimization, and security hardening. For teams with DevOps resources, this works. For teams focused on content and marketing, the maintenance overhead outweighs the cost savings.

### Managed WordPress Hosting

Managed WordPress providers like Kinsta and WP Engine handle server configuration, updates, security, and backups for you.

- **Kinsta** starts at $35 per month for a single site with 25,000 monthly visits, 10 GB storage, and automatic backups. This includes Cloudflare CDN, malware scanning, and staging environments. The plan scales to $675 per month for 250,000 visits and 100 GB storage.
- **WP Engine** starts at $20 per month for personal sites with 25,000 monthly visits and 10 GB storage. Business plans supporting 100,000 visits and staging environments begin at $50 per month. Enterprise plans reach over $500 per month.

These services provide convenience. You get WordPress optimized for performance without managing servers yourself. The tradeoff is limited control. You can't install custom server software, extensively modify PHP configurations, or integrate WordPress into your existing infrastructure automation.

### AWS Enterprise Architecture

AWS's reference architecture for production WordPress runs 11 services: CloudFront CDN, Application Load Balancer, EC2 Auto Scaling, Elastic File System, Aurora, ElastiCache, S3, NAT Gateways, and VPC networking. Monthly costs range from $500 to $1,500, depending on traffic.

![WordPress high availability architecture by Bitnami](.gitbook/assets/wordpress-aws-architecture.png)

This architecture provides enterprise-grade reliability and scale. You get distributed infrastructure, automatic failover, and performance optimization. The tradeoff is complexity. You need dedicated DevOps staff to monitor, maintain, and debug across all these services. Troubleshooting failures requires expertise in multiple AWS services simultaneously.

AWS also provides no built-in WordPress staging-to-production migration. You need expensive sync plugins (over $200 per year) or custom deployment scripts.

### Code Capsules

![Code Capsules WordPress architecture](.gitbook/assets/code-capsules-wordpress-architecture.png)

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
|-------------------------------------|--------------------------------------|----------------------------------------|-----------------------------------------------|----------------------------------------------|
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

WordPress hosting doesn't require choosing between single-server fragility and AWS enterprise complexity. Code Capsules provides separated application, database, and storage layers with built-in staging-to-production migration.

With Code Capsules, your WordPress infrastructure can handle traffic spikes through auto-scaling, survive hardware failures through component separation, and deploy content changes with a one-click migration. You can focus on creating content instead of maintaining servers.

For production operations, Code Capsules provides:

- [Monitoring](https://docs.codecapsules.io/products/wordpress-capsule/monitor) for tracking performance metrics
- [Logs](https://docs.codecapsules.io/products/wordpress-capsule/logs) for debugging issues
- [Scaling rules](https://docs.codecapsules.io/products/wordpress-capsule/scale) for automatic capacity adjustments
- [Alerting](https://docs.codecapsules.io/products/wordpress-capsule/alerting) for proactive issue detection
