# ai-coding-template

**AI methodology** skeleton for solo vibe coding with Claude Code.
Provides the structure (methodology, commands, agents, conventions) — **not the application code**.

Designed for: solo use, daily tool, minimal and lean agent context.

## Install in an existing project

From the root of your target project:

```bash
curl -fsSL https://raw.githubusercontent.com/Nicolas-Delahaie/ai-coding-template/main/install.sh | bash
```

The script downloads the tarball, then for each conflicting folder / file asks what to do: **keep / merge / replace / backup** (and `new` for files). Zero machine install (curl + bash).

## Repository structure

- `CLAUDE.md` — pivot (golden rules, routing, workflow, commands, sub-agents)
- `.ai/` — methodology (conventions, ADRs + index)
- `backlog/` — tickets (`ideas/` / `tasks/` / `archive/`) + `ROADMAP.md` (source of truth)
- `.claude/` — slash commands + sub-agents + settings

## Going further

- `CLAUDE.md`: the full methodology (~40 lines)
- `backlog/README.md`: detailed ticket workflow
- In Claude Code, type `/help` to discover commands

---

## Design decisions (for contributors / forks)

> These decisions are intentionally absent from the target project — they only appear in this README.

### Core need

An agent with a **low active context, very efficient and lean**. The agent loads ONLY the context needed for the current task. The system stays scalable as the project grows.

### Golden rule

Any ticket status change → `ROADMAP.md` updated immediately. The roadmap is the permanent source of truth for the backlog state.

### Key decisions

| # | Choice | Why |
|---|--------|-----|
| 1 | Separate `ai-coding-template` repo, blank, cloneable | Versioned, evolvable, shareable. No bootstrap script: `git clone` is enough. |
| 2 | 1 root `CLAUDE.md` (ultra short, ~40 lines) | Token economy. No CLAUDE.md hierarchy (created occasionally if a zone justifies it). |
| 3 | 2 sub-agents: PM + Dev | Detailed prompts live in agents (loaded on demand), not in CLAUDE.md. The main agent stays lean. |
| 4 | Framework improvement = light proactivity built into PM/Dev | No `IMPROVEMENTS.md` file or dedicated mechanism. PM and Dev mention an improvement only if truly relevant. |
| 5 | 3 slash commands: `/help` `/refine` `/dev` | User entry points that invoke the right agents with the right preloaded context. `/refine` = ideation + refinement. `/dev` = execution. `/help` = help. The rest in natural language. |
| 6 | 1 ticket = 1 markdown file that travels between `ideas/` → `tasks/` → `archive/` | No duplication. `mv` at each transition. |
| 7 | Ticket schema: `type` + `priority` + `size` + `status` + `acceptance criteria` | Rich enough for solo Scrum prioritization, without over-engineering. |
| 8 | Ticket workflow: `idea → spec → dev → test → review → done` | 6 statuses. Distinguishes dev (code), test (automated tests), review (human validation). |
| 9 | Roadmap = compact markdown table in `backlog/` | Solo + git versions all history. Co-located with tickets. Trello unnecessary (native agent reading, zero friction). |
| 10 | Methodology in `.ai/` (distinct from native `.claude/`) | Clear separation: `.claude/` = native Claude Code configs. `.ai/` = project methodology. |
| 11 | Code conventions: 1 single file `.ai/conventions/code.md` | File economy. One file to read for technical conventions. |
| 12 | Business glossary: not created by default | Optional, user creates it if vocabulary is complex. Avoids polluting with an empty file. |
| 13 | Template does NOT touch `lib/` | Template = AI methodology only. Code (Flutter or other) is added by user after clone, as they wish. |
| 14 | Meta-files prefixed with `_`: `_template.md`, `_index.md` | Visually distinguishes templates/indexes from real numbered files (`NNNN-*.md`). `_` brings them to the top in a sorted `ls`. |
| 15 | Physical ticket and ADR templates: `_template.md` next to their folder | Copied via `cp` then renamed/edited. No inline format in READMEs (token economy when reading). |
| 16 | Lightweight ADR index: `.ai/decisions/_index.md` | One line per ADR (summary + status). Loaded ONLY when the agent needs to find a past decision. Never auto-loaded. |
| 17 | `backlog/ROADMAP.md` (in `backlog/`, not at root) | Co-located with the tickets it indexes. The root stays clean. |
| 18 | No separate `INDEX.md` in `backlog/` | `backlog/ROADMAP.md` plays that role. For full history: `ls backlog/archive/`. `backlog/README.md` = usage guide, not an index. |
| 19 | Distribution via curlable bash `install.sh` | Zero machine install. `degit`/`copier`/`npx` rejected (overwrite or require install). Bash = single file, interactive merge by prompt. |
| 20 | `README.md` not copied by install.sh | Avoids overwriting the target project's README. Framework design decisions are preserved without polluting the target project. |
| 21 | `.gitignore` not copied by install.sh | The target project has its own `.gitignore`. We don't overwrite or merge it. |
| 22 | Minimalist README, not duplicated with CLAUDE.md | README is for humans (presentation + install + structure). All methodology lives in CLAUDE.md. Avoids drift (two sources to maintain). |
