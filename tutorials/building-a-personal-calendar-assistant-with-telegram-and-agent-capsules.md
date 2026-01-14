---
description: >-
  Building a Personal Calendar Assistant with Telegram and Agent Capsules
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

# Building a Personal Calendar Assistant with Telegram and Agent Capsules

LLMs with tools allow you to build AI integrations with ease. Instead of just reasoning, your agents can now handle complex tasks from coding to ordering food, scheduling events, or managing your team on [Slack](https://slack.com/) and [Jira](https://www.atlassian.com/software/jira).

However, there's a challenge to running agents in production: infrastructure constraints. The complexity of setting up servers, selecting vector databases, managing security, and scaling costs can prevent agent projects from reaching production.

In this tutorial, you'll learn how to build a personal calendar assistant using Telegram and Agent Capsules from Code Capsules.

## Agentic infrastructure

When deploying AI agents to production, developers typically need to manage a mountain of infrastructure concerns. You have to provision servers like EC2 instances and configure load balancers. Then comes container orchestration with Dockerfiles and Kubernetes clusters.

You'll need to deploy and maintain vector databases, whether that's [Pinecone](https://www.pinecone.io/), [Weaviate](https://weaviate.io/), or [Redis](https://redis.io/). Security requires SSL/TLS certificates, API authentication, and careful management of secrets.

Add monitoring and logging for observability and error tracking, plus scaling configuration with auto-scaling policies and resource limits. All this complexity means developers spend more time wrestling with infrastructure than actually building agent capabilities, adding tools, refining prompts, or improving the user experience.

### Code Capsules Abstraction

Code Capsules eliminates this infrastructure burden entirely with Agent Capsules and other capsule types by handling GitHub repository connections, automatic deployments on code push, autoscaling based on traffic, managed vector store integration, LLM provider abstraction, SSL certificate management, API authentication, built-in monitoring and logging, and resource allocation.

The platform handles DevOps complexity, allowing developers to focus on building agent tools and features.

## Prerequisites

To follow this tutorial, you will need:

- A [GitHub account](https://github.com/) and [Git](https://git-scm.com/) installed.
- A [Code Capsules](https://codecapsules.io/) account.
- An LLM API key's information. For this tutorial, we are using [Anthropic](https://www.anthropic.com/).

The project we will use as a template can be found [here](<to-repo-url>). It's a codebase based on Code Capsules [templates](https://github.com/codecapsules-io/ai-agent-template), to allow developers to kick-start the development. You can read more [here](/docs/products/agent-capsule/templates).

## Redis Capsule Setup

The agents in this tutorial need a vector database. For simplicity, we'll use a Redis capsule.

**Note:** This setup is not recommended for production. Redis is designed for temporary information and caching. For production deployments, consider dedicated vector databases like [Pinecone](https://www.pinecone.io/), [Weaviate](https://weaviate.io/), or [Qdrant](https://qdrant.tech/).

Follow this existing [guide](/docs/database/redis) to create a Redis Capsule. Once created, copy the connection string from the capsule details page.

![Redis capsule connection string](.gitbook/assets/telegram-agent-redis-connection-string.png)

## Configuring the Telegram agent

To set up the Telegram agent, we will use the following [template](<project_template>). On the Code Capsules dashboard, follow the steps in this [guide](/docs/products/agent-capsule/deploy) to create a new Telegram agent capsule.

### Creating a Telegram Bot

To create a Telegram Bot, open the [Telegram](https://telegram.org/) application and search for [BotFather](https://t.me/botfather). Once found, start a conversation and select `/newbot`. When prompted, give the bot a name, then a username. Once created, the bot will provide you with a token. Copy this token and save it for later.

![Creating Telegram bot with BotFather](.gitbook/assets/telegram-agent-botfather-create-bot.png)

To make sure it's set up correctly, you can start a conversation with the bot, but it won't respond yet.

Once you have the token, go to the Telegram Capsule Config page to add the following variables.

```bash
TELEGRAM_BOT_TOKEN=your_bot_token
REDIS_URL=your_copied_connection_string
```

Paste the Telegram bot token and the Redis connection string.

![Telegram capsule environment variables configuration](.gitbook/assets/telegram-agent-capsule-env-vars.png)

With this configuration complete, the Telegram agent is ready. Let's configure the Calendar capabilities.

### Google API Calendar

markdownWe have steps for configuring the Google Calendar API [here](https://github.com/codecapsules-io/ai-calendar-agent-template?tab=readme-ov-file#setup). To ensure the agent can access the calendar, you must configure Google Cloud to integrate with it. First, visit the quickstart documentation [here](https://developers.google.com/workspace/calendar/api/quickstart/js). Then, scroll down to the **Enable the API** button.

![Enable Google Calendar API button](.gitbook/assets/telegram-agent-google-calendar-enable-api.png)

Clicking on it will redirect you to the Google Console platform page to enable the API. Enable and confirm.

![Google Console API enabled confirmation](.gitbook/assets/telegram-agent-google-calendar-api-enabled.png)

After that, in the configuration documentation, navigate to the **Go to Branding** button to configure the OAuth consent screen. Follow the steps on the Google documentation. If you can't select **Internal** for the audience, you can select **External** but you will have to add test users with the Google email address you are using.

![Google OAuth consent screen configuration](.gitbook/assets/telegram-agent-google-oauth-consent-screen.png)

Then, you will need to authorize credentials for a web application by clicking on the **Go to Clients** button.

![Google OAuth clients button](.gitbook/assets/telegram-agent-google-oauth-clients.png)

When doing so, configure the redirect URI to the URL of the Calendar Agent capsule. The redirect URI should be as follows: `{your_agent_capsule_public_url}/api/calendar/auth/callback`. Here is an example: `https://agent-capsule-123.ovh-test.ccdns.co/api/calendar/auth/callback`.

You can find the URI in the dashboard of the Agent capsule and the URI will be the Public URI.

![Agent capsule public URI in dashboard](.gitbook/assets/telegram-agent-capsule-public-uri.png)

Once you are done, Google will provuce you with credentials such as the client ID and the client secret. Then, in the Agent Config, add the following variavles following after retrieving the Client ID and client Secret from Google Cloud Platform.

```bash
GOOGLE_CALENDAR_CLIENT_ID=your_client_id
GOOGLE_CALENDAR_CLIENT_SECRET=your_client_secret
```

Your environment variables configuration should look like the following.

![Complete environment variables configuration](.gitbook/assets/telegram-agent-capsule-full-env-vars.png)

You can then test the configuration by clicking on the Chat tab where you will ask the following:

```txt
Get the list of events in the calendar for February in the first 3 days.
```

The agent will give you a link you click to authorize access to the Calendar API.

![Agent chat showing authorization link](.gitbook/assets/telegram-agent-chat-auth-link.png)

After giving access, you should see the following screen.

![Authorization success screen](.gitbook/assets/telegram-agent-auth-success.png)

After the validation, you can go back to the Chat and tell the agent to proceed. You should have a similar response.

![Agent chat calendar events response](.gitbook/assets/telegram-agent-chat-calendar-response.png)

## Testing the integration

To test the integration, go to Telegram and start a conversation with the bot. Ask the bot to retrieve calendar events for a particular period. If the bot prompts you for login or authorization, click on the link and grant access.

![Telegram bot authorization prompt](.gitbook/assets/telegram-agent-bot-auth-prompt.png)

After granting access, remind the agent to continue.

![Telegram bot calendar events list](.gitbook/assets/telegram-agent-bot-calendar-list.png)

You can also add events to the calendar.

![Telegram bot adding calendar event](.gitbook/assets/telegram-agent-bot-add-event.png)

## Conclusion

In this tutorial, you built a Telegram bot that acts as an interface to a Code Capsules agent with Google Calendar capabilities. The agent uses an LLM to understand your requests and interact with your calendar through natural language.

This same pattern can enable you to build interesting integrations like:

- **Task management bots**: Connect [Todoist](https://todoist.com/), [Asana](https://asana.com/), or [Jira](https://www.atlassian.com/software/jira) to manage tasks through chat.
- **More Personal assistants**: Combine multiple services like email, calendar, and notes in one conversational interface.
- **Customer support bots**: Integrate with CRM systems and knowledge bases to handle support queries.
- **Data analysis tools**: Query databases or analytics platforms using natural language.

The Agent Capsule architecture makes it easy to add new tools and capabilities without managing infrastructure. You can extend your bot by creating new tools that call external APIs, process data, or integrate with other services.

If you're interested in learning more about building with Agent Capsules, check out the [Code Capsules documentation](/docs/products/agent-capsule).
