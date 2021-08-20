# How Do I Add a Custom Domain to My Application?

If you have purchased a domain from a domain registrar, you may route any application hosted on Code Capsules free of charge. To add a custom domain, navigate to the Capsule containing the application which you'd like to add a custom domain to. Find and click on the "Overview" tab.

In the Overview tab, you can see your default Code Capsules URL under "Domains". Below, there is an "Add a Custom Domain" button. Click it. Then:

1. Save the IP address under "A Record Route".
2. Enter the root domain (no subdomain) of the domain you've purchased.
3. Click "Create Domain".

With the IP address saved previously, create an A record pointing to the IP address. Visit your domain registrar for further instructions on creating an A record. After creating an A record pointing to the IP address, allow up to four hours for the changes to propagate before your domain routes to your application. 

For further information on custom domains, refer to [this document](https://codecapsules.io/docs/reference/custom_domains/) explaining the ins and outs of adding custom domains and subdomains to your applications hosted on Code Capsules.