---
description: >-
  Build a personal calendar assistant with Telegram and Agent Capsules
cover: /broken/files/LZ9vKYmOY5gPQMepT9Cj
coverY: 0
layout:
  width: default
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
  metadata:
    visible: true
---

# Build a personal calendar assistant with Telegram and Agent Capsules

LLMs with tools allow you to build AI integrations with ease. Instead of just reasoning, your agents can now handle complex tasks, from coding to ordering food, scheduling events, or managing your team on [Slack](https://slack.com/) and [Jira](https://www.atlassian.com/software/jira).

However, infrastructure constraints pose a challenge to running agents in production. The complexity of setting up servers, selecting vector databases, managing security, and scaling costs can prevent agent projects from reaching production.

This tutorial demonstrates how to build a personal calendar assistant using Telegram and Agent Capsules from Code Capsules.

## Agentic infrastructure

When deploying AI agents to production, developers typically need to manage a mountain of infrastructure concerns:

- Provisioning servers, like EC2 instances
- Configuring load balancers
- Orchestrating containers with Dockerfiles and Kubernetes clusters
- Deploying and maintaing vector databases, like [Pinecone](https://www.pinecone.io/), [Weaviate](https://weaviate.io/), or [Redis](https://redis.io/)
- Meeting security requirements, like SSL/TLS certificates, API authentication, and careful management of secrets
- Adding monitoring and logging for observability and error tracking
- Scaling configuration with auto-scaling policies and resource limits

All this complexity means developers spend more time wrestling with infrastructure than actually building agent capabilities, adding tools, refining prompts, or improving the user experience.

### Code Capsules abstraction

Code Capsules eliminates this infrastructure burden entirely by using various Capsule types (such as Agent Capsules) to handle GitHub repository connections, automatic deployments on code push, autoscaling based on traffic, managed vector store integration, LLM provider abstraction, SSL certificate management, API authentication, built-in monitoring and logging, and resource allocation.

The platform handles DevOps complexity, allowing developers to focus on building agent tools and features.

## Prerequisites

To follow this tutorial, you need:

- A [GitHub account](https://github.com/) and [Git](https://git-scm.com/) installed
- A [Code Capsules](https://codecapsules.io/) account
- An LLM API key (this guide uses [Anthropic](https://www.anthropic.com/))

We use [this codebase](<to-repo-url>) as a starter project for kickstarting the development. It's based on the Code Capsules [templates](https://github.com/codecapsules-io/ai-agent-template), which you can read more about in our [docs](/docs/products/agent-capsule/templates).

## Set up a Redis Capsule

The agents in this tutorial need a vector database. For simplicity, we use a Redis Capsule.

**Note:** This setup is not recommended for production. Redis is designed for temporary information and caching. For production deployments, consider dedicated vector databases like [Pinecone](https://www.pinecone.io/), [Weaviate](https://weaviate.io/), or [Qdrant](https://qdrant.tech/).

Follow the existing [guide to creating a Redis Capsule](/docs/database/redis).

Once you've created the Redis Capsule, copy the connection string from the **Capsule Details** page.

![Redis capsule connection string](.gitbook/assets/telegram-agent-redis-connection-string.png)

## Configure the Telegram agent

To set up the Telegram agent, use the [project template](<project_template>) and create a new Telegram Agent Capsule by following the [guide to deploying an Agent Capsule](/docs/products/agent-capsule/deploy).

### Create a Telegram Bot

To create a Telegram Bot, open the [Telegram](https://telegram.org/) application and search for [BotFather](https://t.me/botfather). Start a conversation with BotFather and select `/newbot`. When prompted, give the bot a name, then a username. Once created, the bot provides you with a token. Copy this token and save it for later.

![Creating Telegram bot with BotFather](.gitbook/assets/telegram-agent-botfather-create-bot.png)

To make sure it's set up correctly, you can start a conversation with the bot, but it won't respond yet.

Once you have the token, go to the Telegram Capsule **Config** page to add the following variables:

```bash
TELEGRAM_BOT_TOKEN=your_bot_token
REDIS_URL=your_copied_connection_string
```

Paste the Telegram bot token and the Redis connection string as new **Environment Variables**.

![Telegram capsule environment variables configuration](.gitbook/assets/telegram-agent-capsule-env-vars.png)

The Telegram agent is now ready. Let's configure the calendar capabilities.

### Configure the Google Calendar API

We have steps for configuring the Google Calendar API [here](https://github.com/codecapsules-io/ai-calendar-agent-template?tab=readme-ov-file#setup). To ensure the agent can access the calendar, you must configure Google Cloud to integrate with it. 

First, visit the Google Calendar API [quickstart](https://developers.google.com/workspace/calendar/api/quickstart/js). Then, scroll down and click the **Enable the API** button.

![Enable Google Calendar API button](.gitbook/assets/telegram-agent-google-calendar-enable-api.png)

The button redirects you to the Google Console platform page to confirm your project and enable the API.

![Google Console API enabled confirmation](.gitbook/assets/telegram-agent-google-calendar-api-enabled.png)

After that, navigate to the **Configure the OAuth consent screen** section in the Google Calendar configuration doc. Click the **Go to Branding** button, and follow the steps in the Google documentation. If you can't select **Internal** for the audience, you can select **External** but you'll have to add test users with the Google email address you're using.

![Google OAuth consent screen configuration](.gitbook/assets/telegram-agent-google-oauth-consent-screen.png)

Then, authorize your web application credentials by clicking the **Go to Clients** button.

![Google OAuth clients button](.gitbook/assets/telegram-agent-google-oauth-clients.png)

When doing so, set the redirect URI to the URL of the Calendar Agent Capsule. The redirect URI should be as follows: `{your_agent_capsule_public_url}/api/calendar/auth/callback`. For example: `https://agent-capsule-123.ovh-test.ccdns.co/api/calendar/auth/callback`.

You can find the URI in the dashboard of the Agent Capsule, and the URI becomes the Public URI.

![Agent Capsule public URI in dashboard](.gitbook/assets/telegram-agent-capsule-public-uri.png)

Once you are done, Google provides you with your credentials, including the Client ID and the Client Secret, which you should copy. 

Then, in the Code Capsules Agent **Config** page, add the following variables (pasting in the values of your Google Client ID and Client Secret).
```bash
GOOGLE_CALENDAR_CLIENT_ID=your_client_id
GOOGLE_CALENDAR_CLIENT_SECRET=your_client_secret
```

Your environment variables configuration should look as follows:

![Complete environment variables configuration](.gitbook/assets/telegram-agent-capsule-full-env-vars.png)

You can then test the configuration by opening the **Chat** tab and sending the following prompt:

```txt
Get the list of events in the calendar for February in the first 3 days.
```

The agent gives you a link, which you click to authorize its access to the Google Calendar API.

![Agent chat showing authorization link](.gitbook/assets/telegram-agent-chat-auth-link.png)

After granting access, you should see the following screen:

![Authorization success screen](.gitbook/assets/telegram-agent-auth-success.png)

After the validation, return to the **Chat** and tell the agent to proceed. You should receive a similar response to this:

![Agent chat calendar events response](.gitbook/assets/telegram-agent-chat-calendar-response.png)

## Test the integration

To test the integration, go to Telegram and start a conversation with the bot. Ask the bot to retrieve your calendar events for a particular period. If the bot prompts you for login or authorization, click on the link and grant it access.

![Telegram bot authorization prompt](.gitbook/assets/telegram-agent-bot-auth-prompt.png)

After granting access, remind the agent to continue.

![Telegram bot calendar events list](.gitbook/assets/telegram-agent-bot-calendar-list.png)

You can also add events to the calendar.

![Telegram bot adding calendar event](.gitbook/assets/telegram-agent-bot-add-event.png)

## Conclusion

In this tutorial, you built a Telegram bot that acts as an interface to a Code Capsules agent with Google Calendar capabilities. The agent uses an LLM to understand your requests and interact with your calendar through natural language.

This same pattern can enable you to build interesting integrations like:

- **Task management bots:** Connect [Todoist](https://todoist.com/), [Asana](https://asana.com/), or [Jira](https://www.atlassian.com/software/jira) to manage tasks through chat.
- **More personal assistants:** Combine multiple services like email, calendar, and notes in one conversational interface.
- **Customer support bots:** Integrate with CRM systems and knowledge bases to handle support queries.
- **Data analysis tools:** Query databases or analytics platforms using natural language.

The Agent Capsule architecture makes it easy to add new tools and capabilities without managing infrastructure. You can extend your bot by creating new tools that call external APIs, process data, or integrate with other services.

If you're interested in learning more about building with Agent Capsules, check out the [Code Capsules documentation](/docs/products/agent-capsule).
