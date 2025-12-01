# Agent API (Sample)

The following specifications describe a standard API used by the Code Capsules chat window to communicate with the agent.

{% openapi-operation spec="code-capsules-api" path="/api/chat/message" method="post" %}
[OpenAPI code-capsules-api](https://cc-agent-fork-setx.ovh-test.ccdns.co/swagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="code-capsules-api" path="/api/chat/message/stream" method="post" %}
[OpenAPI code-capsules-api](https://cc-agent-fork-setx.ovh-test.ccdns.co/swagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="code-capsules-api" path="/api/chat/history" method="get" %}
[OpenAPI code-capsules-api](https://cc-agent-fork-setx.ovh-test.ccdns.co/swagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="code-capsules-api" path="/api/context/text" method="post" %}
[OpenAPI code-capsules-api](https://cc-agent-fork-setx.ovh-test.ccdns.co/swagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="code-capsules-api" path="/api/context/url" method="post" %}
[OpenAPI code-capsules-api](https://cc-agent-fork-setx.ovh-test.ccdns.co/swagger.json)
{% endopenapi-operation %}

## Schemas

{% openapi-schemas spec="code-capsules-api" schemas="ApiResponse,Error,ChatPrompt,ChatPromptContentText,ChatPromptContentImage,ChatPromptContentFile,SendMessageResponse,AgentMessage,AgentMessageContentText,AgentMessageContentImage,AgentMessageContentFile,GetChatHistoryResponse,ContextText,AddContextTextResponse,ContextUrl,AddContextFromUrlResponse" grouped="true" %}
[OpenAPI code-capsules-api](https://cc-agent-fork-setx.ovh-test.ccdns.co/swagger.json)
{% endopenapi-schemas %}
