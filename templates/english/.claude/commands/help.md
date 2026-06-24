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
  "give me a status"     → agent reads backlog/ROADMAP.md and summarizes
  "I have an idea: X"    → equivalent to /refine "X"
  "there's a bug: X"     → equivalent to /refine "X" (PM will create a fix ticket)

TICKET WORKFLOW
  idea → spec → dev → test → review → done
  The ticket is ONE markdown file that travels between:
    backlog/1_ideas/NNN-slug.md    (idea)
    backlog/2_tasks/NNN-slug.md    (spec/dev/test/review)
    backlog/3_archive/NNN-slug.md  (done)

GOLDEN RULE
  Any status change → backlog/ROADMAP.md updated immediately.

SUB-AGENTS (invoked automatically by commands)
  pm   — clarification / backlog management / archiving
  dev  — code / test / debug

TO LEARN MORE
  CLAUDE.md           golden rules + routing table
  backlog/README.md   detailed ticket workflow
  docs/conventions/   code conventions
  docs/decisions/     ADRs (tech decisions)
```
