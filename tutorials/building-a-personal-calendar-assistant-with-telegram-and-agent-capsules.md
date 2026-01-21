---
description: >-
  Build a Personal Calendar Assistant with Telegram and Agent Capsules
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

# Build a Personal Calendar Assistant with Telegram and Agent Capsules

Managing your calendar through multiple apps is tedious. You check Google Calendar on desktop, get notifications on mobile, and manually coordinate across platforms. What if you could schedule meetings, check availability, and get reminders through a single Telegram chat?

In this tutorial, you'll build a personal calendar assistant that handles your Google Calendar through natural conversation on Telegram. The assistant understands requests like "Schedule a team meeting tomorrow at 2pm" or "What's on my calendar this week?" without requiring you to manage servers, databases, or scaling infrastructure.

<video src=".gitbook/assets/telegram-agent-demo.mp4" controls autoplay muted loop playsinline></video>

## Agentic Infrastructure

Deploying AI agents to production requires managing extensive infrastructure:

- Provision servers like EC2 instances and configure load balancers
- Deploy and maintain vector databases (Pinecone, Weaviate, or Redis)
- Configure SSL/TLS certificates and API authentication
- Manage secrets securely
- Add monitoring and logging for observability and error tracking
- Configure autoscaling policies and resource limits

Code Capsules eliminates this burden. The platform handles infrastructure, databases, security, and scaling automatically, letting you focus on building Agent tools and features.

![Code Capsules Agent architecture](.gitbook/assets/telegram-agent-code-capsules-architecture.png)

## Prerequisites

To follow this tutorial, you need:

- A [GitHub account](https://github.com/) and [Git](https://git-scm.com/) installed
- A [Code Capsules](https://codecapsules.io/) account
- An LLM API key (this guide uses [Anthropic](https://www.anthropic.com/))

We use [this codebase](<to-repo-url>) as a starter project for kickstarting the development. It's based on the Code Capsules [templates](https://github.com/codecapsules-io/ai-agent-template), which you can read more about in our [docs](/docs/products/agent-capsule/templates).

## Set Up a Redis Capsule

The agents in this tutorial need a vector database. For simplicity, we use a Redis Capsule.

**Note:** This setup is not recommended for production. Redis is designed for temporary information and caching. For production deployments, consider dedicated vector databases like [Pinecone](https://www.pinecone.io/), [Weaviate](https://weaviate.io/), or [Qdrant](https://qdrant.tech/).

Follow the existing [guide to creating a Redis Capsule](/docs/database/redis).

Once you've created the Redis Capsule, copy the connection string from the **Capsule Details** page.

![Redis capsule connection string](.gitbook/assets/telegram-agent-redis-connection-string.png)

## Configure the Telegram Agent

To set up the Telegram agent, use the [project template](<project_template>) and create a new Telegram Agent Capsule by following the [guide to deploying an Agent Capsule](/docs/products/agent-capsule/deploy).

### Create a Telegram Bot

To create a Telegram Bot, open the [Telegram](https://telegram.org/) application and search for [BotFather](https://t.me/botfather). Start a conversation with BotFather and select `/newbot`. When prompted, give the bot a name, then a username. Once created, the bot provides you with a token. Copy this token and save it for later.

![Creating Telegram bot with BotFather](.gitbook/assets/telegram-agent-botfather-create-bot.png)

To verify the setup, start a conversation with the bot, but it won't respond yet.

Once you have the token, go to the Telegram Capsule **Config** page to add the following variables:
Go to the Telegram Capsule **Config** page to add the following variables.

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

When doing so, set the redirect URI to the URL of the Calendar Agent Capsule. To find it, open your Agent Capsule dashboard and copy the **Public URL**.

The redirect URI should be as follows: `{your_agent_capsule_public_url}/api/calendar/auth/callback`. For example: `https://agent-capsule-123.ovh-test.ccdns.co/api/calendar/auth/callback`.

![Agent Capsule public URI in dashboard](.gitbook/assets/telegram-agent-capsule-public-uri.png)

After completing setup, Google provides you with credentials such as the client ID and the client secret. Then, in the Agent **Config**, add the following variables after retrieving the Client ID and Client Secret from Google Cloud Platform.

Then, in the Code Capsules Agent **Config** page, add the following variables (pasting in the values of your Google Client ID and Client Secret).
```bash
GOOGLE_CALENDAR_CLIENT_ID=your_client_id
GOOGLE_CALENDAR_CLIENT_SECRET=your_client_secret
```

Your environment variables configuration should look as follows:

![Complete environment variables configuration](.gitbook/assets/telegram-agent-capsule-full-env-vars.png)

Test the configuration by clicking on the **Chat** tab, where you can make the following request:

```txt
Get the list of events in the calendar for February in the first 3 days.
```

The Agent should give you a link to click to authorize access to the Calendar API.

![Agent chat showing authorization link](.gitbook/assets/telegram-agent-chat-auth-link.png)

After granting access, you should see the following screen:

![Authorization success screen](.gitbook/assets/telegram-agent-auth-success.png)

After the validation, return to the **Chat** and tell the agent to proceed. You should receive a similar response to this:

![Agent chat calendar events response](.gitbook/assets/telegram-agent-chat-calendar-response.png)

## Test the Integration

To test the integration, go to Telegram and start a conversation with the bot. Ask the bot to retrieve your calendar events for a particular period. If the bot prompts you for login or authorization, click on the link and grant it access.

![Telegram bot authorization prompt](.gitbook/assets/telegram-agent-bot-auth-prompt.png)

After granting access, remind the Agent to continue.

![Telegram bot calendar events list](.gitbook/assets/telegram-agent-bot-calendar-list.png)

You can also add events to the calendar.

![Telegram bot adding calendar event](.gitbook/assets/telegram-agent-bot-add-event.png)

## Conclusion

In this tutorial, you built a Telegram bot that acts as an interface to a Code Capsules Agent with Google Calendar capabilities. The Agent uses an LLM to understand your requests and interact with your calendar through natural language.

This same pattern can enable you to build interesting integrations like:

- **Task Management Bots:** Connect [Todoist](https://todoist.com/), [Asana](https://asana.com/), or [Jira](https://www.atlassian.com/software/jira) to manage tasks through chat.
- **More Personal Assistants:** Combine multiple services like email, calendar, and notes in one conversational interface.
- **Customer Support Bots:** Integrate with CRM systems and knowledge bases to handle support queries.
- **Data Analysis Tools:** Query databases or analytics platforms using natural language.

The Agent Capsule architecture makes it easy to add new tools and capabilities without managing infrastructure. You can extend your bot by creating new tools that call external APIs, process data, and integrate with other services.

If you're interested in learning more about building with Agent Capsules, check out the [Code Capsules documentation](/docs/products/agent-capsule).
