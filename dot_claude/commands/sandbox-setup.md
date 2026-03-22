---
description: Set up sandbox config and MCP deny-list in the current repo for safe use with ccyolo (claude --dangerously-skip-permissions)
---

Write a `.claude/settings.json` file at the git root of the current working directory.

**Steps:**

1. Run `git rev-parse --show-toplevel` to find the git root.
2. Set the target path to `<git-root>/.claude/settings.json`.
3. **Safety check:** If the resolved path is `~/.claude/settings.json` (i.e. `$HOME/.claude/settings.json`), stop immediately and print: "Refusing to overwrite global ~/.claude/settings.json. Navigate to a project repo first." Do not proceed.
4. If the file already exists, read it and merge: replace the `sandbox` key with the new value, and merge the `permissions.deny` array (union, no duplicates). Preserve all other existing keys.
5. If the file does not exist, create it with the content below.

The `sandbox` and `permissions.deny` content to write:

```json
{
  "sandbox": {
    "enabled": true,
    "autoAllowBashIfSandboxed": true,
    "network": {
      "allowedDomains": ["localhost", "127.0.0.1"]
    }
  },
  "permissions": {
    "deny": [
      "mcp__jira__createJiraIssue",
      "mcp__jira__editJiraIssue",
      "mcp__jira__addCommentToJiraIssue",
      "mcp__jira__addWorklogToJiraIssue",
      "mcp__jira__createIssueLink",
      "mcp__jira__transitionJiraIssue",
      "mcp__jira__fetchAtlassian",
      "mcp__confluence__createConfluencePage",
      "mcp__confluence__updateConfluencePage",
      "mcp__confluence__createConfluenceFooterComment",
      "mcp__confluence__createConfluenceInlineComment",
      "mcp__confluence__fetchAtlassian",
      "mcp__plugin_slack_slack__slack_send_message",
      "mcp__plugin_slack_slack__slack_send_message_draft",
      "mcp__plugin_slack_slack__slack_schedule_message",
      "mcp__plugin_slack_slack__slack_create_canvas",
      "mcp__plugin_slack_slack__slack_update_canvas",
      "mcp__GitLab__create_issue",
      "mcp__GitLab__create_workitem_note"
    ]
  }
}
```

After writing, print: "Sandbox config written to `<path>/.claude/settings.json`. You're good to run `ccyolo`."
