---
title: Create a NodeJS Telegram Bot 
description: Learn how to build a Telegram bot in NodeJS that messages you current ethereum prices and host it on Code Capsules
---

# Create and Host a NodeJS Telegram Bot on Code Capsules

Social media bots allow you to automate responses and reactions to posts or messages sent to the bot.

In this tutorial, we're going to look at how to create a Telegram bot in `NodeJS` and host it on Code Capsules by extending a boilerplate NodeJS Express application that has been provided by Code Capsules. 

## Getting Started

Navigate to the [Express.js deployment guide](../deployment/how-to-deploy-express-application-to-production.md) and follow the instructions outlined there to deploy the boilerplate application. You will need to clone the forked repository to your local development environment to extend the functionality of the boilerplate application and make a Telegram bot. 

We need to install the `node_modules` for the boilerplate application before we can run it locally. To do this, navigate to the project's root folder in a terminal or command prompt window and run `npm install` there. 

After actioning the steps above, run `npm start` in the project's root folder to see how it looks.

## Register a Bot Account 

Before you can create a Telegram bot, you need to create a Telegram user account first. Head over to [their site](https://telegram.org/) and create an account if you don't already have one. 

When you've created an account, search for "BotFather" (a bot for managing all other Telegram bots) and start a new chat with it. Follow the steps below to register a new bot with the BotFather:

1. Type `/start` and press send.
2. Type `/newbot` and press send.
3. Choose a name for your bot.
4. Choose a username for your bot that ends in `bot`. 

The BotFather will respond with a message containing your newly created bot's access token after sending it your bot's username. This access token will allow the application we're going to extend shortly to access the Telegram API and tell your bot what to do upon receiving different messages from users. 

To confirm that your bot was indeed created successfully, search for the bot's username. You should be able to see it and start a conversation with it but right now it won't respond as we haven't written the bot's logic yet. 

## Create the Bot Logic

Your bot's access token is sensitive data and shouldn't be written plainly in code. This is because anyone with access to it can control your bot how they please so it's important to store it where it's safe and secure.  

Environment variables are perfect for this scenario as they allow us to reference sensitive information in code using variables. Create a `.env` file in the project's root folder and add the line below to it, replacing `<YOUR_BOT_TOKEN>` with the actual access token you were issued with by the BotFather. 

```
BOT_TOKEN=<YOUR_BOT_TOKEN>
```

Next, install the package for loading environment variables by running the command below from a terminal window in the project's root folder.

```
npm install dotenv
```
