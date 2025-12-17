---
description: >-
  Migrate content between WordPress capsules with one-click synchronization of
  database, files, and configurations.
---

# Migration

Navigate to the **Migrate** tab in your destination WordPress capsule. Select the source capsule from the dropdown menu. Click **Start Migration** to begin the synchronization process.

![Migration Source Selection](../.gitbook/assets/wordpress-capsule/migrate/wordpress-migration-source-selection.png)

## What Gets Migrated

Code Capsules copies the complete WordPress environment from the source capsule:

* **Database content** – All posts, pages, comments, and user accounts.
* **Uploaded media files** – Images, videos, and documents from the storage capsule.
* **Installed plugins** – Active plugins and their configurations.
* **Theme configurations** – Active theme settings and customizations.

## After Migration

Once migration completes, the destination capsule contains identical content to the source capsule. The migration automatically updates internal URLs to match the destination capsule's domain.

Both capsules remain independent after migration. Changes made to the source capsule after migration won't affect the destination until you run another migration.

## Common Use Cases for Migration

* **Staging to Production:** Deploy approved content from staging to your live site.
* **Cloning Sites:** Duplicate a WordPress installation to create a new independent site.
