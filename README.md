# ai-coding-template

**A lean AI methodology skeleton for solo projects with Claude Code.**

Most AI setups work fine at first — then the codebase grows, the agent drowns in context, and every response gets slower and noisier. This template is built around one constraint: **the agent only loads what the current task needs, nothing more.**

Not application code. Not opinions on your stack. Just the structure that keeps Claude focused and useful as your project scales.

---

## Approach — feature-based, agile-inspired

The methodology is **feature-based**: the unit of work is the *feature*, not a technical layer or a project phase. Each ticket is a lightweight user story — a *usage scenario* plus *acceptance criteria* — that delivers one increment of value (`feature | fix | chore | spike`).

It draws on **agile principles** without the ceremony: work flows continuously through `idea → spec → dev → test → review → done`, `backlog/ROADMAP.md` acts as the board, and you ship in small increments instead of planning everything upfront. It's Kanban in spirit — scaled down for a solo developer working with an AI agent.

Tickets **live in the git repo**, as plain markdown files alongside the code. A ticket travels through `ideas/ → tasks/ → archive/` and is committed with the changes it drives: spec and implementation evolve in the same history. The ticket lives with its modifications — you can always trace *why* a piece of code exists back to the feature that produced it.

Why it fits AI-assisted solo work: one feature in flight means the agent reasons about one well-scoped problem at a time (its acceptance criteria), and the ticket file *is* the shared context — no heavy upfront plan to keep in the agent's head.

---

## What's inside

Everything that ships lives under [`template/`](template/) — copied as-is into your project root by `apply.sh`:

```
template/
  CLAUDE.md        ← ~40 lines. The only always-loaded context.
  .ai/             ← ADRs, conventions, glossary (loaded on demand)
  backlog/         ← ideas/ tasks/ archive/ + ROADMAP.md (source of truth)
  .claude/         ← slash commands + sub-agents (PM & Dev)
```

Three slash commands cover the full workflow:

| Command | What it does |
|---|---|
| `/refine` | Clarify and spec a new idea (invokes PM agent) |
| `/dev <id>` | Implement a ticket (invokes Dev agent) |
| `/help` | Discover available commands |

Everything else in plain language — the agent reads `backlog/ROADMAP.md` and knows where things stand.

## Ticket lifecycle

```
idea → spec → dev → test → review → done
```

Each ticket is a single markdown file that travels between `ideas/` → `tasks/` → `archive/`. One `mv`, no duplication. `backlog/ROADMAP.md` stays in sync at every transition.

---

## Install in an existing project

From the root of your target project:

```bash
curl -fsSL https://raw.githubusercontent.com/Nicolas-Delahaie/ai-coding-template/main/apply.sh | bash
```

The script downloads the template and copies everything under `template/` into your project root. Existing items are automatically backed up as `item.bak-TIMESTAMP` — **manually merge** any backed-up files into the new versions afterward. Then it asks once whether to keep the template in English or get a translation prompt. No machine install required — just curl and bash.

> **Unix only** (macOS / Linux). On Windows or if you prefer: manually copy the contents of [`template/`](template/) from this repo into your project root.

---

## Going further

- [`template/CLAUDE.md`](template/CLAUDE.md) — the full methodology (~40 lines)
- [`template/backlog/README.md`](template/backlog/README.md) — ticket workflow details
- In Claude Code, type `/help`

---

## Design decisions

> These are intentionally absent from the target project — they live here for contributors and forks.

### Core principle

A **feature-based, agile-inspired** workflow (see [Approach](#approach--feature-based-agile-inspired)) running on an agent with **minimal active context**. `CLAUDE.md` stays ~40 lines. Sub-agents (PM, Dev) carry their own detailed prompts and are only loaded when explicitly invoked. The methodology scales with the project without the agent getting heavier.

### Key choices

| # | Choice | Why |
|---|--------|-----|
| 1 | Separate repo, blank, installable | Versioned, evolvable, shareable across projects |
| 2 | 1 root `CLAUDE.md` (~40 lines) | Token economy — no `CLAUDE.md` hierarchy |
| 3 | 2 sub-agents: PM + Dev | Detailed prompts stay in agents, out of the main context |
| 4 | 3 slash commands | Clear entry points that invoke the right agent with the right context |
| 5 | 1 ticket = 1 file, travels between folders | No duplication — `mv` at each transition |
| 6 | Ticket workflow: 6 statuses (`idea → spec → dev → test → review → done`) | Distinguishes dev (code), test (automated tests), review (human validation) |
| 7 | Ticket schema: `type` + `priority` + `size` + `status` + AC | Rich enough for solo prioritization, without over-engineering |
| 8 | `backlog/ROADMAP.md` in `backlog/`, not at root | Co-located with the tickets it indexes. Root stays clean. Git versions all history. |
| 9 | No separate `INDEX.md` in `backlog/` | `ROADMAP.md` plays that role. Full history via `ls backlog/archive/`. |
| 10 | Methodology in `.ai/` (separate from `.claude/`) | `.claude/` = native Claude Code configs. `.ai/` = project methodology |
| 11 | Code conventions: 1 file `.ai/conventions/code.md` | One file to read, no scatter |
| 12 | Business glossary: not created by default | Optional — avoids polluting with an empty file |
| 13 | Template does NOT touch `lib/` or application code | Template = AI methodology only. Code is added by the user, as they wish. |
| 14 | Meta-files prefixed `_` (`_template.md`, `_index.md`) | Visually distinct from real numbered files, sort to top in `ls` |
| 15 | Physical ticket and ADR templates: `_template.md` next to their folder | Copied via `cp` then renamed/edited. No inline format in READMEs (token economy). |
| 16 | ADR index: `.ai/decisions/_index.md` | One line per ADR. Loaded only when the agent needs to find a past decision. |
| 17 | Distribution via curlable `apply.sh` | Zero machine install. `degit`/`copier`/`npx` rejected (require install or blindly overwrite) |
| 18 | `README.md` and `.gitignore` not copied by `apply.sh` | The target project owns both. We don't overwrite them. |
| 19 | Minimalist README, no overlap with `CLAUDE.md` | README = human presentation. Methodology = `CLAUDE.md`. Two sources means drift. |
