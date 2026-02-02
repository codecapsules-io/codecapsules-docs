---
description: >-
  Learn how to deploy blog content to a WordPress production site with separated application, database, and storage layers, built-in staging-to-production migration, and autoscaling without AWS complexity.
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

The Amazon Web Services (AWS) WordPress reference architecture has become a meme in DevOps circles. The 2018 [best practices whitepaper](https://aws.amazon.com/blogs/architecture/wordpress-best-practices-on-aws/) recommends you use 11 services costing $500 to $1,500 monthly, and assumes you have dedicated DevOps staff. The alternative is to use a single Amazon Lightsail instance, where you handle operating system (OS) updates, security hardening, and MySQL tuning yourself.

Production WordPress needs infrastructure that falls between these extremes: reliable enough to handle traffic spikes and hardware failures, yet simple enough to manage without a DevOps team.

This guide demonstrates how to run a production WordPress site with:

- Separate application, database, and storage layers
- One-click migration between staging and production environments
- Automatic scaling for traffic spikes
- Infrastructure-level backups

You'll learn how to deploy WordPress infrastructure, configure a content review workflow, and set up production operations for backing up, scaling, and monitoring your data.

## The WordPress Production Problem

In a development team, the workflow for releasing changes usually looks like this:

![Developer workflow diagram](.gitbook/assets/developer-workflow.png)

Your developers write code locally, commit to GitHub, run automated tests, and deploy changes to staging for review. Only after stakeholder approval does anything touch production. Every change is tracked, every deployment is reversible, and nothing reaches your live site without multiple checkpoints.

WordPress doesn't work this way.

![WordPress workflow diagram](.gitbook/assets/wordpress-workflow.png)

WordPress splits data between files and the database, breaking Git workflows:

- You can commit theme changes to Git, but blog posts aren't in your repository.
- You can deploy code via a continuous integration and continuous delivery (CI/CD) pipeline, but you need to make database changes directly in the production site, via the WordPress Admin dashboard.
- You can run tests on your code, but there's no automated testing for scenarios such as when someone installs a plugin that conflicts with your theme.
- You can roll back a bad deployment, but WordPress only rolls back file-system changes; database modifications remain, so you can't recover from bad content changes.

The split between files and database creates production problems such as:

- Marketing installs a plugin on production. It conflicts with your theme, and the site breaks during business hours.
- A content creator deletes a popular post. You can't recover it because there is no Git history for database content.
- You want to test WordPress core updates on staging, but staging content is days behind production.

Your infrastructure may have version control and staging environments, but WordPress breaks standard workflows. Version control can't track database content, and staging environments drift out of sync with production without custom synchronization tooling.

WordPress migration, backups, and staging workflows each require specific approaches to work reliably in production.

## What You Need To Know

Due to WordPress limitations we discussed above, here's what you need to know to host a production WordPress site simply:

- **Separate Your WordPress Layers from the Start:** WordPress, MySQL, and file storage should run independently. When one layer fails or requires scaling, the others continue to operate.
- **Plan for Staging-to-Production Workflows:** WordPress has no built-in mechanism for migrating between environments. Either set up a plugin-based migration, which costs $99 to $299 per year with manual configuration, or use a hosting platform, like Code Capsules, that offers built-in one-click migrations. Without this, you have to manually recreate approved content or risk breaking production with direct edits.
- **Match Infrastructure to Your Team's Capacity:** A self-hosted VPS (starting from $10 per month) requires you to handle security patches, backups, and scaling. Managed WordPress removes operational work but limits flexibility and costs more (an average of $50 per month for basic plans). Always choose based on whether you have DevOps resources.

### Hosting Options For WordPress Sites

WordPress hosting options range from $5 single-server VPS setups to $1,500 AWS enterprise architectures:

- Self-hosted VPS provides complete control but requires Linux administration and manual backup management. 
- AWS delivers maximum reliability but needs dedicated DevOps staff to manage 11 separate services. 
- Managed WordPress providers remove server management but limit customization, and cost $35 to $100 per month.

For a detailed comparison of hosting costs and trade-offs, see [WordPress Hosting Cost Comparison](link).

### Why This Guide Uses Code Capsules

Code Capsules solves specific production WordPress problems: separated infrastructure layers prevent single points of failure, built-in migration eliminates $99-$299 annual plugin costs, and infrastructure-level backups keep databases and files synchronized.

Production WordPress requires content review workflows. Writers create posts in staging, editors review and approve them, and then the changes migrate to production. WordPress provides no built-in migration mechanism. Plugin-based solutions like WP Synchro require licensing costs, API key management, and manual selection of files and database tables to migrate.

Code Capsules provides one-click migration between WordPress Capsules, automatically handling database synchronization, file transfers, and URL updates.

## Hosting a WordPress Blog on Code Capsules

To follow this tutorial, you need:

- A Code Capsules account.
- Some knowledge of WordPress configuration is required, as you will create an admin user.

### Create a Space

Spaces organize related Capsules.

On your Code Capsules dashboard, navigate to the **Spaces** tab and click the **+** button to create a new Space.

![Create new Space button](.gitbook/assets/create-space-button.png)

Fill in the Space details and select the region closest to your target users to reduce latency for your visitors.

![Space details form with name and region fields](.gitbook/assets/space-details-form.png)

### Create the WordPress Capsule

This guide assumes you've already deployed a WordPress Capsule following the [WordPress Capsule deployment documentation](/wordpress#create-the-capsule). After completing that deployment, you should have:

- A WordPress application Capsule running the latest WordPress version
- A MySQL Database Capsule storing posts, users, and settings
- A Storage Capsule handling uploaded media files
- A default URL like `your-wordpress-slug.ccdns.co`

### Configure Your Domain (Optional)

Once the Capsule deploys, you'll see a default URL like `staging-wordpress-slug.ccdns.co`. You can configure a custom domain for cleaner URLs.

![WordPress Capsule default URL](.gitbook/assets/wordpress-default-url.png)

Navigate to the **Domains** tab and click **+** to add a domain.

![Add custom domain button](.gitbook/assets/add-custom-domain-button.png)

On the domain configuration page, enter your staging domain, for example, `staging.blog.yourdomain.com`.

![Custom domain entry form](.gitbook/assets/custom-domain-entry.png)

Code Capsules provides DNS instructions. Create a CNAME or ALIAS record with your DNS provider pointing to the provided hostname.

## Creating The WordPress Staging Site

With the WordPress Capsule deployed, let's complete the WordPress installation for the staging environment first.

### Building The Site Structure

After creating the Code Capsules, you need to configure the staging WordPress site. Visit your WordPress URL and select your language.

![WordPress language selection screen](.gitbook/assets/wordpress-language-selection.png)

Create your admin account. Use a strong password since this account has full site access.

![WordPress admin account creation form](.gitbook/assets/wordpress-admin-account-setup.png)

Once the installation is successful, you will see the following page.

![WordPress installation success message](.gitbook/assets/wordpress-installation-success.png)

Click **Log In** to verify the installation. You should see the staging WordPress admin dashboard.

![WordPress admin dashboard](.gitbook/assets/wordpress-admin-dashboard.png)

Navigate to the website home page. You should have a similar page.

![WordPress default homepage with Twenty Twenty-Five theme](.gitbook/assets/wordpress-default-homepage.png)

Code Capsules includes three default WordPress themes: Twenty Twenty-Five (active), Twenty Twenty-Four, and Twenty Twenty-Three. These are blog-focused templates that display posts on the homepage by default.

To change themes, navigate to **Appearance** → **Themes**.

![WordPress Themes page showing available themes](.gitbook/assets/wordpress-themes-page.png)

### Creating User Accounts

To create user accounts, navigate to **Users** and click **Add New User**.

![WordPress Users page with Add New User button](.gitbook/assets/wordpress-add-new-user-button.png)

Fill the form with user information and select a role.

![WordPress user creation form with role selection options](.gitbook/assets/wordpress-user-role-form.png)

From the **Role** dropdown, select **Admin**, **Contributor**, **Editor**, or **Author**. These roles determine permissions for content creation and review in your staging-to-production workflow.

Your staging environment is ready. You can install themes, add plugins, and create content for review before pushing to production.

### Creating a Sample Post Section

To demonstrate the content review workflow, create a sample blog post in your staging environment.

Navigate to **Posts** → **Add New**.

![WordPress Add New Post editor screen with title and content fields](.gitbook/assets/wordpress-add-new-post.png)

Enter a post title and content. For this example, create a post titled "Welcome to Our Blog" with sample content about your company or services. Then, click **Publish** to make the post visible on your staging site. Visit your staging site to verify the post appears.

## Creating the Production WordPress Site

Create a second WordPress Capsule for production using the same process from the [WordPress Capsule deployment documentation](/wordpress). Use clear naming to distinguish environments:

- **Capsule name:** Production WordPress
- **Database Capsule:** Production WordPress Database  
- **Storage Capsule:** Production WordPress Storage
- **Domain:** `yourblog.com` (or `blog.yourdomain.com`)

This separates production data completely from staging. Changes in staging won't affect production until you explicitly migrate them.

## How to migrate content from staging to production using Code Capsules

In your production WordPress Capsule (the target Capsule), navigate to the **Migrate** tab. Select your staging WordPress Capsule as the **Source Capsule**.

Click **Start Migration**. Code Capsules copies your database content, uploaded media files, installed plugins, and theme configurations from staging to production.

![WordPress migration source Capsule selection](.gitbook/assets/wordpress-migration-source-selection.png)

Once complete, your production environment will have identical content to the staging environment.

## Managing Production WordPress

A production WordPress site requires maintenance, and the most important parts are backups, scaling, observability, and monitoring. Code Capsules provides features for each part.

### Backups

Production WordPress requires synchronized backups of both database (posts, users, settings) and file storage (themes, plugins, media). Code Capsules provides infrastructure-level backups through automatic daily snapshots with 30-day retention for Database and Storage Capsules.

To configure and manage backups:

- [Database Capsule Backups](/products/backups) – Configure retention and restore database snapshots
- [Storage Capsule Backups](/products/storage/backups) – Manage file storage backup settings

Test backup restoration quarterly to verify backups work when needed.

### Scaling WordPress on Code Capsules

Websites scale either horizontally (more instances) or vertically (more resources per instance). Code Capsules uses vertical scaling.

Code Capsules handles scaling by letting you allocate more resources to the Capsule. Navigate to the **Scale** tab, click **Edit**, select **Custom**, and adjust allocated resources with the slider.

![WordPress Capsule Scale tab showing custom resource allocation slider](.gitbook/assets/wordpress-scale-tab-custom-resources.png)

You can learn more about scaling on WordPress in the [scaling documentation](/products/wordpress-capsule/scale).

### Observability and Monitoring

Code Capsules provides the following capabilities through the WordPress Capsule dashboard admin:

- [Monitoring](/products/wordpress-capsule/monitor) – View real-time metrics for CPU, memory, and traffic. Identify performance trends and resource constraints.

- [Logs](/products/wordpress-capsule/logs) – Access application logs directly from the dashboard. Filter by severity, search for specific errors, and troubleshoot issues without server access.

  ![WordPress Capsule logs interface showing application error logs](.gitbook/assets/wordpress-capsule-logs-interface.png)

- [Access Logs](/products/wordpress-capsule/logs) – Track actions performed by WordPress users in the admin interface.

  ![WordPress access logs view showing user activity in admin dashboard](.gitbook/assets/wordpress-access-logs-view.png)

- [Alerting](/products/wordpress-capsule/alerting) – Configure alerts for high CPU usage, error rates, or downtime. Receive notifications via email or webhook before users report problems.

- [Metrics](/products/wordpress-capsule/monitor) – To check resources usage on the machine.

  ![WordPress Capsule metrics dashboard showing CPU, memory, and resource usage](.gitbook/assets/wordpress-metrics-dashboard.png)

### Best Practices in WordPress

A WordPress production site requires ongoing maintenance beyond infrastructure management:

- **Security:** Keep WordPress core, themes, and plugins up to date. Security patches address vulnerabilities that attackers exploit.
- **Update Strategy:** WordPress releases regular updates. Code Capsules supports updates without issues, but always review changelogs before updating. Test updates on staging before applying to production.
- **Password Management:** Use strong, unique passwords for all WordPress accounts. Enable two-factor authentication where possible.
- **Backup Verification:** Test backup restoration quarterly to verify backups work when needed.
- **Plugin Audits:** Review installed plugins monthly. Remove unused plugins and update active ones.
- **Monitoring Schedule:**
  - Weekly: Review error logs and performance metrics
  - Monthly: Test staging-to-production migration workflow
  - Quarterly: Security audit and backup restoration test

## Conclusion

Hosting a WordPress production site doesn't require choosing between single-server fragility and AWS enterprise complexity. Code Capsules provides built-in staging-to-production migration and separate application, database, and storage layers.

With Code Capsules, your WordPress infrastructure can handle traffic spikes through auto-scaling, survive hardware failures through component separation, and deploy content changes with a one-click migration. You can focus on creating content instead of maintaining servers.

For production operations, Code Capsules provides:

- [Monitoring](https://docs.codecapsules.io/products/wordpress-capsule/monitor) for tracking performance metrics
- [Logs](https://docs.codecapsules.io/products/wordpress-capsule/logs) for debugging issues
- [Scaling rules](https://docs.codecapsules.io/products/wordpress-capsule/scale) for automatic capacity adjustments
- [Alerting](https://docs.codecapsules.io/products/wordpress-capsule/alerting) for proactive issue detection
