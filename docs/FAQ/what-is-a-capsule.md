# What is a Capsule?

A Capsule provides the actual server for running your applications. Code Capsules offers two distinct Capsule types: Frontend Capsules and Backend Capsules.

- Frontend Capsules deploy Angular, React, Vue, or static content from the GitHub repository housing your application.

- Backend Capsules deploy Node.js, Java, or Python applications from the GitHub repository containing your code.

Capsules automatically build and deploy upon creation. One can monitor the build process by navigating to the "Logs" tab, or by pressing "View build log" under the "Build and Deploy" tab.

Upon deployment, an HTTPS subdomain is generated for the Capsule. The subdomain assigned to the app is available in the "Config" tab. Clicking on the subdomain will open the link in a new tab.

You can turn Capsules off by toggling the switch at the top right of the Capsule view (next to "Live Website").