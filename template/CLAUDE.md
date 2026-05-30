# CLAUDE.md

AI methodology for this project. Stay lean: only load what the current task needs.

## Golden rules

1. **Roadmap = source of truth.** Any ticket status change → update `ROADMAP.md` immediately.
2. **Minimal context.** Only read files useful for the current task. No defensive reading.
3. **Clarify before storing.** Before writing a new idea/task, ask questions (goal, scenario, success criteria).
4. **NEVER read `.ai/DESIGN.md`** unless the user explicitly asks.

## Where to store what (routing)

| Type of info | Destination |
|---|---|
| Raw idea (unspecified) | `backlog/ideas/I-NNN-slug.md` |
| Specified / active task | `backlog/tasks/T-NNN-slug.md` |
| Completed task | `backlog/archive/T-NNN-slug.md` |
| Arch/tech decision (ADR) | `.ai/decisions/NNNN-title.md` (copy `_template.md`) |
| Code convention | `.ai/conventions/code.md` |
| Business vocabulary | `.ai/glossary.md` (create if needed) |
| Global backlog state | `ROADMAP.md` (always up to date) |

## Ticket workflow

`idea → spec → dev → test → review → done`

Every status transition **must** update `ROADMAP.md`.

## Commands

- `/help` — help
- `/refine <id?>` — create a new idea (no ID) or refine an existing ticket (with ID)
- `/dev <id>` — execute an existing ticket

Everything else in natural language (e.g. "give me a status" → read `ROADMAP.md` and summarize).

## Sub-agents

- `pm` — clarification / prioritization / roadmap / archiving (invoked via `/refine`)
- `dev` — code / test / debug (invoked via `/dev`)
