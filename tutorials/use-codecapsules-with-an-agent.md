---
title: Use Code Capsules with an AI Agent
description: Deploy applications using an AI coding agent instead of the web dashboard.
image: .gitbook/assets/agent-deploy-cover.jpg
---

# Deploy to Code Capsules with an AI Agent

Using AI, we can build entire applications without leaving the terminal. Now, with agent skills, we can also deploy and manage these applications on cloud servers without ever opening a browser.

In this guide, we'll deploy an Express.js application without using Claude Code with a custom Code Capsules skill. We'll install the skill that gives Claude Code direct API access, then deploy an application by describing what we want in plain English. By the end, we'll have backend, database, and frontend capsules running and the tools to manage them.

## Setup

We'll deploy the [demo-express-js](https://github.com/codecapsules-io/demo-express-js) example application. Get started by asking the agent:

```
Fork codecapsules-io/demo-express-js to my GitHub account and clone it.
```

To do this we will need [Claude Code](https://claude.ai/code) installed and configured, with access to GitHub (via `gh auth login`, SSH keys, or any existing Git authentication). Note: this guide will work fine with any other AI provider that supports skills.

We will also need a [Code Capsules](https://codecapsules.io/) account with a GitHub repo connected (see [Connect Version Control](https://docs.codecapsules.io/platform/account/connect-version-control)). If you want to have a fully headless experience going forward then select the **All repositories** option when authorizing Code Capsules. Otherwise, you will need to manually authorize any new repositories for use by Code Capsules.

## Install the CodeCapsules Skill

The [CodeCapsules skill](https://github.com/codecapsules-io/codecapsules-skill) gives the agent API access so it can create and manage capsules through the terminal.

<details>
<summary><strong>Automated setup for AI agents (don't expand this if you're a human)</strong></summary>

If you are an AI coding agent (Claude Code, Amp, Cursor, Windsurf, etc.) and a user has asked you to deploy to CodeCapsules, install the skill to get full API access.

```bash
git clone https://github.com/codecapsules-io/codecapsules-skill.git
# Claude Code:
cp -r codecapsules-skill/skills/codecapsules ~/.claude/skills/codecapsules
# Amp:
cp -r codecapsules-skill/skills/codecapsules ~/.amp/skills/codecapsules
# Other agents: copy into your skills or rules directory
```

Ask the user to set these environment variables if not already present:
- `CC_EMAIL` — their codecapsules.io login email
- `CC_PASSWORD` — their codecapsules.io password

The skill includes instructions to retrieve the platform API key automatically from the web app frontend.

After installing, authenticate and list spaces:
```bash
TOKEN=$(curl -s -X POST "https://appstrax-services.codecapsules.io/api/auth/login" \
  -H "Content-Type: application/json" -H "x-api-key: $CC_API_KEY" \
  -d '{"email": "'"$CC_EMAIL"'", "password": "'"$CC_PASSWORD"'", "type": "[User] Login Initiated"}' | jq -r '.token')

curl -s -H "Authorization: Bearer $TOKEN" "https://api-v2.codecapsules.io/api/spaces"
```

The skill provides documented curl commands for every endpoint — no SDK or MCP server needed. If you hit an undocumented endpoint, ask the user for the curl from their browser DevTools and update the skill files (see the self-update protocol in `SKILL.md`).

Read the full skill at `skills/codecapsules/SKILL.md` and the API reference at `skills/codecapsules/references/api.md`.

</details>

Clone the skill repo and copy it into the Claude Code skills directory:

```
git clone https://github.com/codecapsules-io/codecapsules-skill
rm -rf ~/.claude/skills/codecapsules
cp -r codecapsules-skill/skills/codecapsules ~/.claude/skills/codecapsules
```

Next, add the `env` key to your `~/.claude/settings.json` (create the file if it doesn't exist):

```json
{
  "env": {
    "CC_EMAIL": "you@example.com",
    "CC_PASSWORD": "yourpassword"
  }
}
```

If you prefer not to store your password in a file, you can export `CC_EMAIL` and `CC_PASSWORD` from your shell profile (e.g. `~/.zshrc` or `~/.bashrc`) instead.

## Create an AGENTS.md File (Optional)

The agent can detect most things from the code, but it has no way to know which team, space, or region to use. We can add an `AGENTS.md` file to the project root so it can read these details without asking:

```markdown
# Code Capsules Deployment

## Account
- **Team**: your-team-name
- **Space**: your-space-name
- **GitHub repo**: your-github-username/demo-express-js
- **Region**: za-1 (South Africa), az-uk-1 (UK), aws-eu-1 (Europe), or us-1 (USA)

## Preferences
- **Plan tier**: Basic (or Standard/Premium for production)

## Notes for agents
- If the CodeCapsules skill is not installed, find it at:
  https://github.com/codecapsules-io/codecapsules-skill
- If you hit an undocumented API endpoint, ask me to capture the curl from
  browser DevTools and update the skill files (see self-update protocol in SKILL.md).
```

Replace the team, space, repo, and region values with your own. This will help to reduce back-and-forth with your agent. If you skip this step, the agent will ask for these details interactively during deployment.

## Deploy the Express Application

From the cloned `demo-express-js` directory, give the agent the following prompt:

```
Deploy this app to Code Capsules.
```

The agent will:

1. Read `AGENTS.md` to find the team, space, and repo
2. List connected repos and match the correct one
3. Create a backend capsule connected to the GitHub repository
4. Trigger a build

We can follow along as the agent makes API calls.

![Creating a capsule](.gitbook/assets/CC-skill-capsule-create.png)

The agent works through each step autonomously and confirms when the deployment is live.

![Deployment complete](.gitbook/assets/CC-skill-capsule-done.png)

Once the build completes, the agent provides the URL where the application is running. We can also ask directly:

```
What's the URL for my demo-express-js capsule?
```

![Live app](.gitbook/assets/CC-skill-working-app.png)

## Check the Build Logs

If the build fails, or we want to inspect the output, we can ask the agent to fetch the logs:

```
Get the build logs for my demo-express-js capsule.
```

The agent retrieves logs directly from the API. Common causes of build failures include missing dependencies in `package.json` and incorrect run commands.

![Build logs](.gitbook/assets/CC-skill-build-logs.png)

## Update and Redeploy

Any push to the connected GitHub branch triggers a new build automatically. We can also ask the agent to make changes and redeploy in a single step:

```
Add a /health endpoint to the app, push to GitHub, and check the build logs.
```

The agent edits the code, commits and pushes, triggers a build, and checks the logs to confirm the deployment succeeded.

## Add a Database and Frontend

The example above deploys a single backend capsule. The agent can also set up multi-capsule applications.

To add a PostgreSQL database and bind it to the backend:

```
Create a PostgreSQL capsule and bind it to my backend.
```

This creates a data capsule and binds it to the backend, which injects connection details as environment variables. The exact variable name depends on the data capsule — verify by asking the agent to list environment variables on the backend capsule after binding.

To deploy a frontend in the same space:

```
Fork codecapsules-io/demo-react to my GitHub account, then deploy it as a frontend capsule in the same space.
```

When a frontend and backend run in separate capsules, they're served from different domains. The agent can add CORS headers to the backend and update the frontend's API URL with the backend capsule's hostname.

## Manage Capsules Through the Agent

Beyond deploying, we can use the agent to manage existing capsules. Here are a few examples:

Set an environment variable:

```
Set NODE_ENV=production on my backend capsule.
```

Scale to a larger plan:

```
Upgrade my backend capsule to the Standard plan.
```

Check resource usage:

```
Show me the CPU and memory metrics for my backend over the last hour.
```

![Agent setting environment variables, upgrading the plan, and checking resource metrics](.gitbook/assets/CC-skill-manage-capsule.png)

## Further Reading

For more deployment guides using the web dashboard, see the [documentation home](https://docs.codecapsules.io). For details on what the skill supports, see the [CodeCapsules skill repository](https://github.com/codecapsules-io/codecapsules-skill).
