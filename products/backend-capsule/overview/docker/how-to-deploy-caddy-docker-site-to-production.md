---
description: Publish a Caddy Docker site using its source code on GitHub.
---

# How to Deploy a Caddy Docker Site to Production on Code Capsules

Deploy a Caddy Docker site and learn how to host frontend code on Code Capsules.

## Set up

Code Capsules connects to GitHub repositories to deploy applications. To follow this guide, you'll need a [Code Capsules](https://codecapsules.io/) account and a [GitHub](https://github.com/) account.

To demonstrate how to deploy a Bootstrap site with Code Capsules, we've provided an example application, which you can find on the [Code Capsules GitHub repository](https://github.com/codecapsules-io/hello-caddy).

Sign in to GitHub, and fork the example application by clicking "Fork" at the top-right of your screen and selecting your GitHub account as the destination.

## Create an Account with Code Capsules

If you don't already have an account, navigate to the [Code Capsules](https://codecapsules.io/) site and click the "Sign Up" button in the top right corner of the screen. Enter your details to create an account, or log in to an existing one.

If you've just signed up for an account, you'll be directed to a welcome page on your first login. Click on the "Go To Personal Team" button.

Alternatively, if you're signing in again, click on the "Spaces" tab.

Code Capsules gives every account a Personal Team by default. A Team is an environment for you to manage your Spaces and Capsules. For a better understanding of Teams, Spaces, and Capsules, take a look at [our explanation](../../../platform/platform.md).

## Create a Space for your App

Log in to your Code Capsules account and navigate to the "Spaces" tab. Once there, click the yellow `+` icon on the top right of the screen to add a new Space. 

Follow the prompts, choosing your region and giving your Space a name, then click "Create Space".

![space name](../../.gitbook/assets/shared/space-name.png)

Example instructions to go with numbered annotations
1. Choose a team — you can use a default "personal" team if you're the only person working on this project, or a named team if you're collaborating with others
2. This should remind you of the project, for example "customer-api" or "notetaking-app"
3. Choose a country close to where most of your users will be
4. If you're already using a specific cloud, you can choose that here, otherwise pick any one.

## Create the Capsule

A [Capsule](https://codecapsules.io/docs/FAQ/what-is-a-capsule/) provides the server for hosting an application on Code Capsules.

Navigate to the "Space" containing your recently created Data Capsule and click the yellow `+` icon on the top right of the screen. Follow the instructions below to create a Backend Capsule:

1. Choose "Docker Capsule", your Team and Space.
3. Click the GitHub button and give access to the repository you forked at the start of the tutorial.
4. Choose the GitHub repository you forked.
4. Press "Next".
5. Enter "Dockerfile" as the input in the "Dockerfile location" field.
6. Leave the "Docker build context" field blank.
7. Click "Create Capsule".

Code Capsules will automatically build your application when you've finished creating the Capsule. While the build is in progress, you can view the log by clicking "View Build Progress" next to the "Building Capsule" message.

Once your application is live, you can view the build log by selecting the "Deploy" tab and clicking the "View build log" link in the "Builds" section.

![Build logs](../../.gitbook/assets/backend-capsule/backend-capsule-build-logs.png)

## View Application

Once the build is complete, click the "URL" link in the "Config" tab and you should see your deployed application.

![Deployed App](../../.gitbook/assets/backend-capsule/deploy/caddy-docker-site.png)
