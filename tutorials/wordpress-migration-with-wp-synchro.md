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

WordPress migration between staging and production is selective. When you migrate five approved articles and a new landing page, you must keep production's existing users, published posts, and live settings intact. Staging contains draft content, test users, and experimental configurations that live users should never see.

WordPress stores content in two places: the MySQL database (posts, pages, user accounts, settings) and the file system (themes, plugins, uploaded media). Selective migration means choosing which database records and files to copy without overwriting production data, then updating URLs to match the production environment. You risk copying the wrong tables and missing files, which breaks URLs.

This tutorial shows how to use WP Synchro to handle selective WordPress migration. The plugin lets you choose specific content to migrate (individual posts, pages, or media files) while preserving production data and automatically updating URLs.

## Migrating WordPress Content Using WP Synchro

WordPress stores data in two locations: the MySQL database and the file system. The database also stores URLs pointing to files.

![WordPress data storage split](.gitbook/assets/wordpress-data-storage-split.png)

Migration requires three coordinated steps: copying the database, transferring files, and updating all URLs to match the new environment.

![WordPress migration process](.gitbook/assets/wordpress-migration-process.png)

WordPress provides no built-in migration tool. WordPress users handle staging-to-production migrations with plugins such as [WP Synchro](https://wordpress.org/plugins/wpsynchro/), [UpdraftPlus](https://teamupdraft.com/updraftplus/), or [All-in-One WP Migration](https://wordpress.org/plugins/all-in-one-wp-migration/). These plugins automate database export/import, file transfer, and URL replacement.

WP Synchro offers straightforward setup. The free version supports basic migrations but limits database size to 10 MB. Production sites require the premium version at $99-$299 per year for extensive database support, selective sync, and conflict resolution.

### Installing WP Synchro

Install the plugin on both staging and production environments. The premium version requires manual zip file download.

![WP Synchro plugin upload](.gitbook/assets/wp-synchro-plugin-upload.png)

Get your license key from the WP Synchro dashboard.

![WP Synchro license key](.gitbook/assets/wp-synchro-license-key.png)

Upload the downloaded zip file to the **Add Plugins** page.

![Upload WP Synchro plugin zip](.gitbook/assets/wp-synchro-upload-zip.png)

After installation, add your license key in **WP Synchro → Licensing**.

![Add WP Synchro license key](.gitbook/assets/wp-synchro-add-license.png)

### Configuring Migration

Configure your setup in **WP Synchro → Setup** by enabling pushes for the production environment, then save the access key. The staging environment uses this access key to authenticate when pushing changes to production.

![Configure WP Synchro access key](.gitbook/assets/wp-synchro-access-key.png)

On the **WP Synchro → Overview** page, click **Add Migration**. Enter a name for the migration, select **Push this site to remote site** as the migration type, then enter your production site's full URL and paste the access key.

![Add migration in WP Synchro](.gitbook/assets/wp-synchro-add-migration.png)

Select one of the four migration options: **Migrate entire site**, **Migrate all files** (no database), **Migrate entire database** (no files), or **Custom migration**. Custom migration lets you select specific tables, files, posts, or comments to migrate.

![WP Synchro migration options](.gitbook/assets/wp-synchro-migration-options.png)

Click **Save** and execute the migration.

### Handling Conflicts

If content changed on production since your last sync, the plugin shows conflicts. You manually choose whether to keep production changes or overwrite them with staging content. Unlike Git, there's no automatic conflict resolution – you choose which complete version to keep.

![WP Synchro migration conflicts](.gitbook/assets/wp-synchro-migration-conflicts.png)

### Plugin Limitations

WP Synchro provides reliable migration for WordPress sites but creates operational challenges:

- The free version limits database size to 10 MB. Production sites need premium licenses at $99 to $299 per year.
- Configuration takes 20 minutes with database credentials, FTP access, and sync rules that need adjustment whenever your WordPress structure changes.
- The plugin can't merge changes. If someone edited production content while you worked on staging, you either overwrite production or cancel the migration.
- Anyone with access can view API keys and use them to push unauthorized changes to production.

## Why Use Code Capsules Instead?

Code Capsules eliminates plugin complexity with built-in WordPress migration. Deploy staging and production WordPress Capsules, then migrate content with one click.

Migrate content in three steps:

- Navigate to your production WordPress Capsule and open the **Migrate** tab
- Select your staging Capsule as the source
- Click **Start Migration**

Code Capsules handles database synchronization, file transfers, and URL updates automatically. No plugin installation, no license costs ($99 to $299 per year saved), no API key configuration, and no security risks from exposed credentials.

For the complete setup guide, see [How to Host a Production WordPress Blog on Code Capsules](/docs/tutorials/how-to-simply-host-a-production-wordpress-blog.md).

## Conclusion

WP Synchro handles WordPress migration but requires annual licensing ($99-$299), manual database configuration, and conflict resolution when staging and production diverge.

Code Capsules provides one-click migration without plugins, licensing fees, or API keys. For the complete production WordPress setup guide, see [How to Host a Production WordPress Blog on Code Capsules](/docs/tutorials/how-to-simply-host-a-production-wordpress-blog.md).
