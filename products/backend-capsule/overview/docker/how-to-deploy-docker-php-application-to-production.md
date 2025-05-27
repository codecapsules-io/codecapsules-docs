---
description: Deploy your application with with PHP and Docker to Production on Code Capsules
---

# How to Deploy a PHP Docker Application to Production on Code Capsules

This guide will show you how to deploy your application built with PHP and Docker to Code Capsules. By the end of this guide, you'll have an application that looks like the one below which runs on the public internet, and you'll get a URL to share with your users.

## Set up

Code Capsules connects to GitHub repositories to deploy applications. To follow this guide, you'll need a [Code Capsules](https://codecapsules.io/) account and a [GitHub](https://github.com/) account.

To demonstrate how to deploy a PHP and Docker application with Code Capsules, we've provided some example starting code, which you can find on the [Code Capsules GitHub repository](https://github.com/codecapsules-io/demo-php-docker).

Sign in to GitHub, and fork the example application by clicking "Fork" at the top right of your screen and selecting your GitHub account as the destination.

## Create an Account with Code Capsules

If you don't already have an account, navigate to the [Code Capsules](https://codecapsules.io/) site and click the "Sign Up" button in the top right corner of the screen. Enter your details to create an account, or log in to an existing one.

If you've just signed up for an account, you'll be directed to a welcome page on your first login. Click on the "Go To Personal Team" button.

Alternatively, if you're signing in again, click on the "Spaces" tab.

Code Capsules gives every account a Personal Team by default. A Team is an environment for you to manage your Spaces and Capsules. For a better understanding of Teams, Spaces, and Capsules, take a look at [our explanation](../../../platform/platform.md).

## Create a Space for your App

Log in to your Code Capsules account and navigate to the "Spaces" tab. Once there, click the yellow `+` icon on the top right of the screen to add a new Space. 

Follow the prompts, choosing your region and giving your Space a name, then click "Create Space".

![space name](../../../.gitbook/assets/shared/space-name.png)

Example instructions to go with numbered annotations
1. Choose a team — you can use a default "personal" team if you're the only person working on this project, or a named team if you're collaborating with others
2. This should remind you of the project, for example "customer-api" or "notetaking-app"
3. Choose a country close to where most of your users will be
4. If you're already using a specific cloud, you can choose that here, otherwise pick any one.

## Create the Capsule

A [Capsule](https://codecapsules.io/docs/FAQ/what-is-a-capsule/) provides the server for hosting an application on Code Capsules.

1. Choose "Docker Capsule", your Team and Space.
2. Choose your payment plan.
3. Click the GitHub button and give access to the repository you forked at the start of the tutorial.
4. Choose the GitHub repository you forked.
5. Press "Next".
6. Click "Create Capsule".


Code Capsules will automatically build your application when you've finished creating the Capsule. While the build is in progress, you can view the log by clicking "View Build Progress" next to the "Building Capsule" message.

Once your application is live, you can view the build log by selecting the "Deploy" tab and clicking the "View build log" link in the "Builds" section.

![Build logs](../../../.gitbook/assets/backend-capsule/backend-capsule-build-logs.png)

Once the build is complete, navigate to the "Config" tab and edit the "Capsule parameters" section. Enter "80" as the port number and click on "Save".

![Network Port](../../../.gitbook/assets/shared/network-port-80.png)


## View Application

Restart your capsule by toggling the radio button in the top right off and on again.

Once the build is complete, click the "URL" link in the "Details" tab and you should see your deployed application, navigate to the `/api` route to view it.

![Deployed App](../../../.gitbook/assets/backend-capsule/deploy/docker-php.png)
