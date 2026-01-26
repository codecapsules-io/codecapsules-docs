---
description: >-
  Learn how to migrate WordPress content between staging and production environments using WP Synchro plugin, including database synchronization, file transfers, and conflict resolution.
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

# How to Migrate WordPress Content Between Environments Using WP Synchro

WordPress migration between staging and production is selective, not wholesale. When you need to migrate five approved articles and a new landing page while keeping production's existing users, published posts, and live settings intact, you can't just copy everything. Staging contains draft content, test users, and experimental configurations that live users should never see.

WordPress stores content in two places: the MySQL database (posts, pages, user accounts, settings) and the file system (themes, plugins, uploaded media). Selective migration means choosing which database records and files to copy without overwriting production data, then updating URLs to match the production environment. There is a high risk of copying the wrong tables and missing files, which can lead to broken URLs.

This tutorial shows how to use WP Synchro to handle selective WordPress migration. The plugin lets you choose specific content to migrate (individual posts, pages, or media files) while preserving production data and automatically updating URLs.

## How Does Migration Work in WordPress?

WordPress migration is more complex than deploying typical web applications, because WordPress stores data in two separate locations:

- Your application code, themes, plugins, and configuration files live in the file system.
- Your content, blog posts, comments, user accounts, and plugin settings live in the MySQL database.
- Uploaded media like images, videos, and PDFs live in the file system, but the database stores the URLs pointing to these files.

![WordPress data storage split](.gitbook/assets/wordpress-data-storage-split.png)

Migration requires three coordinated steps: copying the database, transferring files, and updating all URLs to match the new environment.

![WordPress migration process](.gitbook/assets/wordpress-migration-process.png)

WordPress has no built-in migration tool, so you need to use plugins most of the time.

## Migrating WordPress Content Using a Plugin

Most WordPress users handle staging-to-production migrations with plugins such as [WP Synchro](https://wordpress.org/plugins/wpsynchro/), [UpdraftPlus](https://teamupdraft.com/updraftplus/), or [All-in-One WP Migration](https://wordpress.org/plugins/all-in-one-wp-migration/). These plugins automate the three-step process: database export/import, file transfer, and URL replacement.

WP Synchro offers the most straightforward setup. The free version supports basic migrations but limits the database size to 10 MB. Production sites require the premium version at $99-$299 per year for extensive database support, selective sync, and conflict resolution. The setup process looks like this:

- Install the plugin on both the staging and production environments. The premium version requires you to download the zip file manually.

  ![WP Synchro plugin upload](.gitbook/assets/wp-synchro-plugin-upload.png)

- Get your license key:

  ![WP Synchro license key](.gitbook/assets/wp-synchro-license-key.png)

- Upload the downloaded zip file to the **Add Plugins** page.

  ![Upload WP Synchro plugin zip](.gitbook/assets/wp-synchro-upload-zip.png)

- After installation, add your license key in **WP Synchro → Licensing**.

  ![Add WP Synchro license key](.gitbook/assets/wp-synchro-add-license.png)

- Configure your setup in **WP Synchro → Setup** by enabling pushes for the production environment, then save the access key. The staging environment uses this access key to authenticate when pushing changes to production.

  ![Configure WP Synchro access key](.gitbook/assets/wp-synchro-access-key.png)

- On the **WP Synchro → Overview** page, click **Add Migration**. Enter a name for the migration, select **Push this site to remote site** as the migration type, then enter your production site's full URL and paste the access key.

![Add migration in WP Synchro](.gitbook/assets/wp-synchro-add-migration.png)

- Select one of the four migration options: **Migrate entire site**, **Migrate all files** (no database), **Migrate entire database** (no files), or **Custom migration**. Custom migration lets you select specific tables, files, posts, or comments to migrate.

  ![WP Synchro migration options](.gitbook/assets/wp-synchro-migration-options.png)

- **Save** and execute the migration.

If any content has changed on the production since your last sync, the plugin shows conflicts. You manually choose whether to keep production changes or overwrite them with staging content. Unlike Git, there's no automatic conflict resolution – you choose which complete version to keep.

![WP Synchro migration conflicts](.gitbook/assets/wp-synchro-migration-conflicts.png)

WP Synchro provides a reliable migration workflow for WordPress sites. However, plugin-based migration creates several operational challenges:

- The free version limits the database size to 10 MB. Production sites need premium licenses at $99 to $299 per year.
- Configuration takes 20 minutes with database credentials, File Transfer Protocol (FTP) access, and sync rules that need adjustment whenever your WordPress structure changes.
- If someone edited production content while you worked on staging, the plugin can't merge changes. You either overwrite production or cancel the migration.
- Anyone with access can view the API keys and use them to push unauthorized changes to your production site.

## Why Use Code Capsules Instead?

Code Capsules provides built-in migration between WordPress environments. Deploy staging and production WordPress Capsules, then migrate content with one click.

Migrating content requires two steps:

* Navigate to your production WordPress Capsule and open the Migrate tab
* Select your staging Capsule as the source
* Click Start Migration

Code Capsules handles database synchronization, file transfers, and URL updates automatically. No plugin installation, no license costs ($99 to $299 per year saved), no API key configuration, and no security risks from exposed credentials.

For the complete setup guide, see [How to Host a Production WordPress Blog on Code Capsules](link-to-document-1).

## Conclusion

WordPress migration plugins like WP Synchro provide a working solution for moving content between staging and production environments. However, this approach requires annual licensing costs ($99-$299), manual configuration of database credentials and sync rules, and periodic troubleshooting when conflicts arise during migration.

Hosting your WordPress website on Code Capsules offers one-click staging-to-production migration without plugins, licensing fees, or manual configuration. The migration process handles database synchronization, file transfers, and URL updates automatically.

To learn more about WordPress on Code Capsules, check out the official [documentation](/products/wordpress-capsule/deploy).
