---
layout:
  width: default
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

# Chat

Code Capsules provides an integrated chat window for Agent Capsules. In order for this to be fully functional, there are a few endpoints which the API needs to expose.

## API Requirements

The deployed codebase needs to expose a few endpoints, each with their own pre-described payload. Data is always returned in the `ApiResponse` format. Errors are returned in the `Error` format.

{% openapi-schemas spec="code-capsules-api" schemas="ApiResponse,Error" grouped="true" %}
[OpenAPI code-capsules-api](https://cc-agent-fork-setx.ovh-test.ccdns.co/swagger.json)
{% endopenapi-schemas %}

### Endpoints

Below describes the endpoints required to use the integrated chat window:

<table data-full-width="true"><thead><tr><th>Endpoint</th><th>Purpose</th><th>Mandatory</th><th data-type="content-ref">Sample Docs</th></tr></thead><tbody><tr><td><p><mark style="color:$warning;"><code>POST</code></mark> </p><p>/api/chat/message</p></td><td>Send a message to the agent with an instant response.</td><td>Yes*</td><td><a href="agent-api-sample.md#post-api-chat-message">#post-api-chat-message</a></td></tr><tr><td><p><mark style="color:$warning;"><code>POST</code></mark> </p><p>/api/chat/message/stream</p></td><td>Send a message to the agent, streaming back the response.</td><td>Yes*</td><td><a href="agent-api-sample.md#post-api-chat-message-stream">#post-api-chat-message-stream</a></td></tr><tr><td><p><mark style="color:$success;"><code>GET</code></mark> </p><p>/api/chat/history</p></td><td>Get the chat history for the user.</td><td>Yes</td><td><a href="agent-api-sample.md#get-api-chat-history">#get-api-chat-history</a></td></tr><tr><td><p><mark style="color:$warning;"><code>POST</code></mark> </p><p>/api/context/text</p></td><td>Submit context to the agent using text.</td><td>No</td><td><a href="agent-api-sample.md#post-api-context-text">#post-api-context-text</a></td></tr><tr><td><p><mark style="color:$warning;"><code>POST</code></mark> </p><p>/api/context/url</p></td><td>Submit context to the agent using a URL.</td><td>No</td><td><a href="agent-api-sample.md#post-api-context-url">#post-api-context-url</a></td></tr></tbody></table>

\*Only one of these are required

### Request Headers from Code Capsules

All of the above endpoints will also be passed the following headers. This allows for some simple security when testing the agent using the integrated chat window:

<table><thead><tr><th width="159.1341552734375">Header</th><th width="451.2705078125">Description</th><th>Mandatory</th></tr></thead><tbody><tr><td>X-CC-API-KEY</td><td>This value will be the value as generated in the INTERNAL_API_KEY environment variable on creation of the Agent capsule.</td><td>No</td></tr><tr><td>X-CC-EMAIL</td><td>This value will be the email of the user who has logged into Code Capsules, allowing for testing with unique chat sessions and chat history.</td><td>No</td></tr></tbody></table>

