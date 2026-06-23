# CLAUDE.md

AI methodology for this project. Stay lean: only load what the current task needs.

## Golden rules

1. **Roadmap = source of truth.** Any ticket status change → update `backlog/ROADMAP.md` immediately.
2. **Minimal context.** Only read files useful for the current task. No defensive reading.
3. **Clarify before storing.** Before writing a new idea/task, ask questions (goal, scenario, success criteria).
4. **NEVER read `docs/DESIGN.md`** unless the user explicitly asks.
5. **Self-improve.** If an instruction feels wrong or missing for the situation, say so and propose a fix directly in this file.

## Where to store what (routing)

| Type of info                    | Destination                                             |
| ------------------------------- | ------------------------------------------------------- |
| Raw idea (unspecified)          | `backlog/1_ideas/NNN-slug.md`                             |
| Specified / active task         | `backlog/2_tasks/NNN-slug.md`                             |
| Completed task                  | `backlog/3_archive/NNN-slug.md`                           |
| Global arch/tech decision (ADR) | `docs/decisions/NNNN-title.md` (copy `_template.md`)    |
| Feature-specific tech detail    | commit message (`<type>(<scope>): ...`), not the ticket |
| Code convention                 | `docs/conventions/code.md`                              |
| Business vocabulary             | `docs/glossary.md` (create if needed)                   |
| Global backlog state            | `backlog/ROADMAP.md` (always up to date)                |

## Ticket workflow

`idea → spec → dev → test → review → done`

Every status transition **must** update `backlog/ROADMAP.md`.

## Commands

- `/help` — help
- `/refine <id?>` — create a new idea (no ID) or refine an existing ticket (with ID)
- `/dev <id>` — execute an existing ticket

Everything else in natural language (e.g. "give me a status" → read `backlog/ROADMAP.md` and summarize).

## Sub-agents

- `pm` — clarification / prioritization / roadmap / archiving (invoked via `/refine`)
- `dev` — code / test / debug (invoked via `/dev`)
