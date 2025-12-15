---
description: >-
  Configure custom domains for your WordPress capsule to replace the default
  Code Capsules URL.
---

# Domains

## Default URLs

<figure><img src="../.gitbook/assets/wordpress-capsule/domain/wordpress-default-url.png" alt=""><figcaption><p>Default WordPress URL</p></figcaption></figure>

When you deploy a WordPress capsule, Code Capsules assigns a default URL like `wordpress-slug.ccdns.co`. You can access your site immediately using this URL.

## Adding a Custom Domain

Navigate to the **Domains** tab in your WordPress capsule and click the **+** button.

<figure><img src="../.gitbook/assets/wordpress-capsule/domain/add-custom-domain-button.png" alt=""><figcaption><p>Add Custom Domain Button</p></figcaption></figure>

Enter your custom domain in the form.

<figure><img src="../.gitbook/assets/wordpress-capsule/domain/custom-domain-entry.png" alt=""><figcaption><p>Custom Domain Entry Form</p></figcaption></figure>

## Configuring DNS

Code Capsules provides DNS configuration instructions after you add a domain. You'll need to create a CNAME or ALIAS record with your DNS provider.

DNS propagation typically takes 15-60 minutes. Once complete, your WordPress site will be accessible at your custom domain.
