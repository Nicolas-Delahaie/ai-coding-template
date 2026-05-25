---
description: Display framework help (commands, sub-agents, ticket workflow)
---

Display a clear and concise summary of the framework to the user. Without reading ROADMAP or tickets — just the static formatting below.

```
🤖 Framework ai-coding-template

COMMANDS
  /help              This help
  /refine <id?>      Create a new idea (no ID) or refine an existing ticket (with ID).
                     Works for feature, fix, chore, spike — regardless of type.
                     Invokes the `pm` sub-agent.
  /dev <id>          Execute an existing ticket (code, tests, debug).
                     Invokes the `dev` sub-agent.

NATURAL LANGUAGE (no command needed)
  "give me a status"     → agent reads ROADMAP.md and summarizes
  "I have an idea: X"    → equivalent to /refine "X"
  "there's a bug: X"     → equivalent to /refine "X" (PM will create a fix ticket)

TICKET WORKFLOW
  idea → spec → dev → test → review → done
  The ticket is ONE markdown file that travels between:
    backlog/ideas/I-NNN-slug.md  (idea)
    backlog/tasks/T-NNN-slug.md  (spec/dev/test/review)
    backlog/archive/T-NNN-slug.md (done)

GOLDEN RULE
  Any status change → ROADMAP.md updated immediately.

SUB-AGENTS (invoked automatically by commands)
  pm   — clarification / prioritization / roadmap / archiving
  dev  — code / test / debug

TO LEARN MORE
  CLAUDE.md           golden rules + routing table
  backlog/README.md   detailed ticket workflow
  .ai/conventions/    code conventions
  .ai/decisions/      ADRs (tech decisions)
  .ai/DESIGN.md       framework design decisions (read on demand only)
```
