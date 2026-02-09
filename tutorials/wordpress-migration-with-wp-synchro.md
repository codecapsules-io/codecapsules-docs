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

# How To Use WP Synchro To Migrate WordPress Content Between Environments

WordPress disrupts most development workflows. There is no native system for migrating content between staging and production sites, and each site's data is stored in two separate locations:

![WordPress data storage split](.gitbook/assets/wordpress-data-storage-split.png)

- **The MySQL database** stores posts, pages, user accounts, and settings, as well as URL links to media in file storage.
- **The file system** stores themes, plugins, and uploaded media.

Copying approved content from your staging site to your production site requires selective migration to ensure that parts of each site remain unaffected by your changes.

- The production site contains existing users, published posts, and live settings that must stay intact.
- The staging site contains draft content, tests users, and experimental configurations that live users should never see.

Selective migration means choosing which database records and files to copy without overwriting production data, then updating URLs to match the production environment. You risk copying the wrong tables and missing files, which breaks URLs.

This tutorial demonstrates how to use WP Synchro to handle selective WordPress migration. The plugin lets you choose specific content to migrate (individual posts, pages, or media files) while preserving production data and automatically updating URLs.

## Migrating WordPress Content Using WP Synchro

Staging-to-production migration requires three coordinated steps in WordPress:

- Copying the database
- Transferring files
- Updating all URLs to match the new environment

![WordPress migration process](.gitbook/assets/wordpress-migration-process.png)

Without a built-in migration tool, many WordPress users add plugins such as [WP Synchro](https://wordpress.org/plugins/wpsynchro/), [UpdraftPlus](https://teamupdraft.com/updraftplus/), and [All-in-One WP Migration](https://wordpress.org/plugins/all-in-one-wp-migration/) to automate database exports and imports, file transfer, and URL replacement.

WP Synchro offers a straightforward setup. The free version supports basic migrations but limits the database size to 10 MB. Most production sites require the Pro version, at $99-$299 per year, for its extensive database support, selective sync options, and conflict resolution.

### Installing WP Synchro

Install the plugin on both your staging and production environments.

The Pro version requires a manual zip file download, which you can add to WordPress as follows:

- Download the zip file.

  ![WP Synchro plugin upload](.gitbook/assets/wp-synchro-plugin-upload.png)

- Copy your **License key** from the WP Synchro dashboard.

  ![WP Synchro license key](.gitbook/assets/wp-synchro-license-key.png)

- Return to your WordPress admin dashboard, navigate to the **Plugins** page, click **Upload Plugin**, and select your downloaded zip file.

  ![Upload WP Synchro plugin zip](.gitbook/assets/wp-synchro-upload-zip.png)

- When the plugin is installed, navigate to **WP Synchro → Licensing** in the sidebar, enter your license key, and click **Save License Key and Validate**.

  ![Add WP Synchro license key](.gitbook/assets/wp-synchro-add-license.png)

### Configuring Migration

Configure your setup in **WP Synchro → Setup** by enabling pushes for the production environment, then generate and save the access key. The staging environment uses this access key to authenticate when pushing changes to production.

![Configure WP Synchro access key](.gitbook/assets/wp-synchro-access-key.png)

On the **WP Synchro → Overview** page, click **Add Migration**. Enter a name for the migration, select **Push this site to remote site** as the migration type, then enter your production site's full URL and paste the access key.

![Add migration in WP Synchro](.gitbook/assets/wp-synchro-add-migration.png)

Select one of the four migration options:**Migrate entire site**, **Migrate all files** (no database), **Migrate entire database** (no files), or **Custom migration**. Custom migration lets you select specific tables, files, posts, or comments to migrate.

![WP Synchro migration options](.gitbook/assets/wp-synchro-migration-options.png)

Click **Save** and execute the migration.

### Handling Conflicts

If content has changed on production since your last sync, the plugin shows conflicts and you manually choose whether to keep production changes or overwrite them with staging content. Unlike Git, there's no automatic conflict resolution – you choose which complete version to keep.

![WP Synchro migration conflicts](.gitbook/assets/wp-synchro-migration-conflicts.png)

### Plugin Limitations

WP Synchro provides reliable migration for WordPress sites but creates operational challenges:

- The free version limits database size to 10 MB. Production sites need Pro licenses at $99 to $299 per year.
- It takes 20 minutes to configure database credentials, FTP access, and sync rules for the plugin. The configuration also needs adjustment whenever your WordPress structure changes.
- The plugin can't merge changes. If someone edited production content while you worked on staging, you either overwrite production or cancel the migration.
- Anyone with access can view API keys and use them to push unauthorized changes to production.

## Why Use Code Capsules Instead?

Code Capsules eliminates plugin complexity with built-in WordPress migration. Deploy staging and production WordPress Capsules, then migrate content with one click.

- Navigate to your production WordPress Capsule and open the **Migrate** tab.
- Select your staging Capsule as the source.
- Click **Start Migration**.

Code Capsules handles database synchronization, file transfers, and URL updates automatically. There's no need to install plugins, pay licensing costs (saving $99 to $299 per year ), configure API keys, or take on security risks from exposed credentials.

For the complete setup, see [How To (Simply) Host a Production WordPress Blog on Code Capsules](/docs/tutorials/how-to-simply-host-a-production-wordpress-blog.md).

## Conclusion

WP Synchro handles WordPress migration but requires annual licensing, manual database configurations, and conflict resolutions when staging and production diverge.

Code Capsules provides one-click migration without plugins, fees, or API keys. For the complete guide to setting up a WordPress production site, see [How To (Simply) Host a Production WordPress Blog](/docs/tutorials/how-to-simply-host-a-production-wordpress-blog.md).
