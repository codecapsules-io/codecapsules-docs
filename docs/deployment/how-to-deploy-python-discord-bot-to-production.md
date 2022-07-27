---
title: Deploy a Python Discord Bot
description: A guide to deploying a Python Discord Bot from GitHub.
hide:
  - navigation
---

# How to Deploy a Python Discord Bot to Production on Code Capsules in 5 Minutes

Deploy a Python Discord Bot and learn how to host backend code on Code Capsules.

## Set up

Code Capsules connects to GitHub repositories to deploy applications. To follow this guide, you’ll need a [Code Capsules](https://codecapsules.io/) account and a [GitHub](https://github.com/) account.

To demonstrate how to deploy a Python Discord Bot with Code Capsules, we’ve provided an example bot which you can find on the [Code Capsules GitHub repository](https://github.com/codecapsules-io/python-discord-echobot).

Sign in to GitHub, and fork the example bot repository by clicking "Fork" at the top-right of your screen and selecting your GitHub account as the destination.

## Create a Space for your Bot

Log in to your Code Capsules account and navigate to the "Spaces" tab. Once there, click the "Create A New Space For Your Apps" button. 

Follow the prompts, choosing your region and giving your Space a name, then click "Create Space".

![space name](../assets/deployment/express/space-name.png)

## Link to GitHub

To link to GitHub, click your profile image at the top right of the Code Capsules screen and find the "GitHub" button under "GitHub Details".

![GitHub button](../assets/deployment/express/git-button.png)

Click the "GitHub" button, select your GitHub username, and do the following in the dialog box that appears:

1. Select "Only Select Repositories".
2. Choose the GitHub repository we forked.
3. Press "Install & Authorize".

![Install & authorize github](../assets/deployment/express/github-integration.png)

## Add Repository to Team

Select "Team Settings" in the top navigation bar to switch to the Team Settings tab.

Click on the "Modify" button under the "Team Repos" section. An "Edit Team Repos" screen will slide in from the right. Click "Add" next to the bot repo, and then "Confirm". All the Spaces in your Team will now have access to this repo.

![Edit Team Repos](../assets/deployment/python/team-repos.gif)

## Register the Bot

You'll need a Discord user account before you can create a Discord bot. Head over to Discord and create an account if you don't already have one.

When you've signed in to Discord, follow the steps below:

1. Click on the "+" icon in the left toolbar to create a server to contain your channels.
![Create a Server](../assets/deployment/discord/plus-icon.png)
2. Navigate to the [Application Page](https://discord.com/developers/applications).
3. Click on the "New Application" button.
4. Give the application a name and click "Create".
5. Go to the "Bot" tab and click "Add Bot". Confirm your decision by clicking, "Yes, do it!"
![New Application](../assets/deployment/discord/add-bot.png)
6. Click the "Copy" button under the "TOKEN" section to copy your bot's token. 
![Bot Token](../assets/deployment/discord/token.png)
7. Go to the "OAuth2/URL Generator" tab and select the "bot" option under the "Scopes" section. 
![Bot Option](../assets/deployment/discord/bot-option.png)
8. Select all the text permission options under the "Bot Permissions" section.
![Text Permissions](../assets/deployment/discord/text-permissions.png)
9. Click the "Copy" button under the, "Generated URL" section
![Url](../assets/deployment/discord/url.png)
10. Paste the url you copied in the previous step in another browser tab and add the bot to the server you created in the first step. Click "Continue" to confirm your changes. 

After actioning these steps, your bot will now have access to all the channels in the server you added it to.

## Create the Capsule

A [Capsule](https://codecapsules.io/docs/FAQ/what-is-a-capsule/) provides the server for hosting an application on Code Capsules.

Navigate to the "Spaces" tab and open the Space you’ll be using.

Click the "Create a New Capsule for Your Space" button, and follow the instructions below:

1. Choose "Backend Capsule".
2. Under "Product", select "Sandbox".
3. Choose the GitHub repository you forked.
4. Press "Next".
5. Leave "Run Command" blank.
6. Click "Create Capsule".

Code Capsules will automatically build your application when you’ve finished creating the Capsule. While the build is in progress, you can view the log by clicking "View Build Progress" next to the "Building Capsule" message.

Once your application is live, you can view the build log by selecting the "Deploy" tab and clicking the "View build log" link in the "Builds" section.

![Build logs](../assets/deployment/express/backend-capsule-build-logs.png)

## Add a `TOKEN` Environment Variable

Once the build is complete, you have to add a `TOKEN` environment variable on the "Configure" tab under the "Capsule parameters" section. Assign it the value of the token you copied in step 6 of the [Register the Bot](#register-the-bot) section above. 

![Add a `TOKEN` Environment Variable](../assets/deployment/discord/token-env-var.png)

Confirm your changes by clicking on "Update Capsule", then restart your Capsule by toggling the radio button in the top right off and on again.

## Chat with the Bot

The bot will be able to respond to messages after Code Capsules finishes building it. When this is done, you cand send messages in the general channel of your Discord server and the bot will echo them.

If you’d like to deploy another application in a different language or framework, take a look at our other [deployment guides](/docs/deployment/).