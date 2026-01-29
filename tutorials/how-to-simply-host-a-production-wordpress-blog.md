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

You'll learn how to deploy WordPress infrastructure, configure a content review workflow, and set up production operations for backups, scaling, and monitoring.

## What You Need to Know

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

## Hosting a WordPress Blog on Code Capsules

To follow this tutorial, you need:

- A Code Capsules account.
- Some knowledge of WordPress configuration is required, as you will create an admin user.

### Create a Space

Spaces organize related Capsules. Click the **+** button on the dashboard to create a new Space.

![Create new Space button](.gitbook/assets/create-space-button.png)

Fill in the Space details and select the region closest to your target users to reduce latency for your visitors.

![Space details form with name and region fields](.gitbook/assets/space-details-form.png)

### Create the WordPress Capsule

Navigate to your new Space and click the **+** button to create a Capsule.

![Create Capsule button in Space view](.gitbook/assets/create-capsule-button.png)

Select **WordPress** as the Capsule type, and choose your Team and Space.

![WordPress Capsule type selection](.gitbook/assets/wordpress-capsule-selection.png)

Choose a plan based on your expected traffic. Use the [Code Capsules pricing calculator](https://app.codecapsules.io/pricing-calculator) to estimate costs for your monthly visitors and storage needs.

![WordPress Capsule pricing plan selection](.gitbook/assets/wordpress-pricing-plan.png)

On the deployment page, select **Default** – Code Capsules provides a ready WordPress instance.

The **Custom** option lets you deploy from your own Git repository if you have a customized WordPress setup.

![WordPress deployment method - default vs custom](.gitbook/assets/wordpress-deployment-method.png)

### Configure Database and Storage

In the next page, name the Capsule **Staging WordPress**.

Click the **+** button next to Database to create a new Database Capsule. This separates your MySQL database from your application server, when traffic spikes hit your WordPress application, your database continues responding normally. Choose a database plan that matches your content volume.

![WordPress Database Capsule configuration](.gitbook/assets/wordpress-database-configuration.png)

Click the **+** button next to Storage to create a Storage Capsule. This handles uploaded images, videos, and media files separately from your application server. Choose a storage plan based on your media library size.

![WordPress Storage Capsule configuration](.gitbook/assets/wordpress-storage-configuration.png)

Your configuration should show Staging WordPress with attached Database and Storage Capsules.

![WordPress configuration with Database and Storage attached](.gitbook/assets/wordpress-configuration-overview.png)

Click **Create Capsule**.

### Configure Your Domain (Optional)

Once the Capsule deploys, you'll see a default URL like `staging-wordpress-slug.ccdns.co`. Configure a custom domain for cleaner URLs.

![WordPress Capsule default URL](.gitbook/assets/wordpress-default-url.png)

Navigate to the **Domains** tab and click **+** to add a domain.

![Add custom domain button](.gitbook/assets/add-custom-domain-button.png)

You will be redirected to a page to enter the custom domain address. Enter your staging domain, for example, `staging.blog.yourdomain.com`.

![Custom domain entry form](.gitbook/assets/custom-domain-entry.png)

Code Capsules provides DNS instructions. Create a CNAME or ALIAS record with your DNS provider pointing to the provided hostname.

## WordPress for Production

With WordPress set up, you need to complete the WordPress site installation.

### Building Your Site Structure

After creating the Code Capsules, you need to configure WordPress. Visit your WordPress URL and select your language.

![WordPress language selection screen](.gitbook/assets/wordpress-language-selection.png)

Create your admin account. Use a strong password since this account has full site access.

![WordPress admin account creation form](.gitbook/assets/wordpress-admin-account-setup.png)

Once the installation is successful, you will see the following page.

![WordPress installation success message](.gitbook/assets/wordpress-installation-success.png)

Click **Log In** to verify the installation. You should see the WordPress admin dashboard.

![WordPress admin dashboard](.gitbook/assets/wordpress-admin-dashboard.png)

Navigate to the website home page. You should have a similar page.

![WordPress default homepage with Twenty Twenty-Five theme](.gitbook/assets/wordpress-default-homepage.png)

### Creating a Sample Post Section

To demonstrate the content review workflow, create a sample blog post in your staging environment.

Navigate to **Posts** → **Add New**.

![WordPress Add New Post editor screen with title and content fields](.gitbook/assets/wordpress-add-new-post.png)

Enter a post title and content. For this example, create a post titled "Welcome to Our Blog" with sample content about your company or services. Then, click **Publish** to make the post visible on your staging site. Visit your staging site to verify the post appears.

### Creating User Accounts

To create user accounts, navigate to **Users** and click **Add New User**.

![WordPress Users page with Add New User button](.gitbook/assets/wordpress-add-new-user-button.png)

Fill the form with user information and select a role.

![WordPress user creation form with role selection options](.gitbook/assets/wordpress-user-role-form.png)

On the **Role** field, select Admin, Contributor, Editor, or Author. These roles determine permissions for content creation and review in your staging-to-production workflow.

Your staging environment is ready. You can install themes, add plugins, and create content for review before pushing to production. Code Capsules has by default three Themes: Twenty Twenty-Five, Twenty Twenty-Four, and Twenty Twenty-Three. The active theme is Twenty Twenty-Five.

You can repeat the same steps to create a production environment. Make sure to name the Capsules accordingly.

## How to Manage Content Across Environments Effectively

Content review workflow with staging and production environments:

- The author of a post publishes a post in staging.
- The editor takes a review.
- The author makes changes.
- The editor validates the changes.
- Then, the editor gives the green signal for a push to production.

WordPress has no built-in push-to-production mechanism. Content migration solves this problem. Plugins like WP Synchro move content between staging and production. This approach requires:

- A costly license.
- Keys management.
- Knowing which files and databases tables to migrate.

Code Capsules provides a Migrate feature that lets you move content from one WordPress Capsule to another.

In your production WordPress Capsule (the target Capsule), navigate to the **Migrate** tab. Select your staging WordPress Capsule as the **Source Capsule**.

Click **Start Migration**. Code Capsules copies your database content, uploaded media files, installed plugins, and theme configurations from staging to production.

![WordPress migration source Capsule selection](.gitbook/assets/wordpress-migration-source-selection.png)

Once complete, your production environment will have identical content to the staging environment.

With this setup, writers create posts in staging, editors review the content, and you migrate approved changes to production with a single click.

## Managing Production WordPress

A production WordPress site requires maintenance, and the most important part of maintenance is backups, scaling, observability, and monitoring. Code Capsules provides features for each part.

### Backups

 A complete backup includes three components:

- **The Database:** Your MySQL database contains all your site's dynamic content, including posts, pages, comments, user accounts, and plugin settings.
- **The File System:** Your files include themes, plugins, WordPress core, the uploads directory with all images and media, your site's structure, and assets.
- **Off-Site Storage:** Backups stored on the same server as your live site provide no protection against hardware failures or hosting issues. Production backups require external storage.

The critical requirement is synchronization. Your database references files by path and URL. If you back up your database at 2 pm and your files at 3 pm, a blog post created at 2:30 pm may reference an image that doesn't exist in your file backup. Production backups must capture the database and files simultaneously.

#### How Code Capsules Handles Backups

Code Capsules implements infrastructure-level backups. Your Database and Storage Capsules maintain automatic daily snapshots with 30-day retention. These backups run outside WordPress, avoiding performance impact and resource limits.

Database and Storage backups capture the same point in time, ensuring a synchronized state. Restoration works regardless of database size, avoiding the 500 MB cPanel limitation that breaks manual restoration for production sites.

With migration and backup requirements established, the next question is cost. Different hosting approaches address these requirements with varying levels of automation, complexity, and price.

To handle backups, check the backup documentation for file storage and database storage.

### Scaling WordPress on Code Capsules

Websites scale either horizontally (more instances) or vertically (more resources per instance). Code Capsules uses vertical scaling. Monitor the **Metrics** tab to identify when your WordPress Capsule needs more resources. You can setup [alerts](/products/wordpress-capsule/alerting) to get notifications on:

- **High CPU Usage** - Alert when CPU usage exceeds 80%

- **High Memory Usage** - Notify when memory usage exceeds 80%

- **High Data Usage** - Alert when data usage exceeds 80%

- **CPU Throttle** - Notify when CPU is being throttled

Code Capsules handles scaling by letting you allocate more resources to the Capsule. Navigate to the **Scale** tab, click **Edit**, select **Custom**, and adjust allocated resources with the slider.

![WordPress Capsule Scale tab showing custom resource allocation slider](.gitbook/assets/wordpress-scale-tab-custom-resources.png)

You can learn more about scaling on WordPress in the [scaling documentation](/products/wordpress-capsule/scale).

### Observability and Monitoring

WordPress manages multiple systems: database, file storage, security, plugins, and website hosting. To ensure your site is always operational, monitoring is essential. WordPress provides no built-in monitoring or logging interface. Logs are accessible on the server via SSH or file access, requiring manual parsing and external monitoring tools.

Production WordPress observability requires:

- **Performance Metrics:** Track CPU usage, memory consumption, and request latency to identify bottlenecks before users experience slowdowns.
- **Application Logs:** Debug plugin conflicts, PHP errors, and database issues through centralized log access without SSH.
- **Alerts:** Receive notifications when errors spike, resources reach thresholds, or the site goes down.

Code Capsules provides these capabilities through the WordPress Capsule interface:

- [Monitoring](/products/wordpress-capsule/monitor) - View real-time metrics for CPU, memory, and traffic. Identify performance trends and resource constraints.

- [Logs](/products/wordpress-capsule/logs) - Access application logs directly from the dashboard. Filter by severity, search for specific errors, and troubleshoot issues without server access.

  ![WordPress Capsule logs interface showing application error logs](.gitbook/assets/wordpress-capsule-logs-interface.png)

- [Access Logs](/products/wordpress-capsule/logs) – Track actions performed by WordPress users in the admin interface.

  ![WordPress access logs view showing user activity in admin dashboard](.gitbook/assets/wordpress-access-logs-view.png)

- [Alerting](/products/wordpress-capsule/alerting) – Configure alerts for high CPU usage, error rates, or downtime. Receive notifications via email or webhook before users report problems.

- [Metrics](/products/wordpress-capsule/monitor) – To check resources usage on the machine.

  ![WordPress Capsule metrics dashboard showing CPU, memory, and resource usage](.gitbook/assets/wordpress-metrics-dashboard.png)

### Best Practices in WordPress

Production WordPress requires ongoing maintenance beyond infrastructure management:

- **Security:** Keep WordPress core, themes, and plugins updated. Security patches address vulnerabilities that attackers exploit.
- **Update Strategy:** WordPress releases regular updates. Code Capsules supports updates without issues, but always review changelogs before updating. Test updates on staging before applying to production.
- **Password Management:** Use strong, unique passwords for all WordPress accounts. Enable two-factor authentication where possible.
- **Backup Verification:** Test backup restoration quarterly to verify backups work when needed.
- **Plugin Audits:** Review installed plugins monthly. Remove unused plugins and update active ones.
- **Monitoring Schedule:**
  - Weekly: Review error logs and performance metrics
  - Monthly: Test staging-to-production migration workflow
  - Quarterly: Security audit and backup restoration test

## Conclusion

WordPress hosting doesn't require choosing between single-server fragility and AWS enterprise complexity. Code Capsules provides separated application, database, and storage layers with built-in staging-to-production migration.

With Code Capsules, your WordPress infrastructure can handle traffic spikes through auto-scaling, survive hardware failures through component separation, and deploy content changes with a one-click migration. You can focus on creating content instead of maintaining servers.

For production operations, Code Capsules provides:

- [Monitoring](https://docs.codecapsules.io/products/wordpress-capsule/monitor) for tracking performance metrics
- [Logs](https://docs.codecapsules.io/products/wordpress-capsule/logs) for debugging issues
- [Scaling rules](https://docs.codecapsules.io/products/wordpress-capsule/scale) for automatic capacity adjustments
- [Alerting](https://docs.codecapsules.io/products/wordpress-capsule/alerting) for proactive issue detection
