# Backlog — Reference

> **This file is NOT an index.** The global index is `backlog/ROADMAP.md`.
> For full history: `ls archive/`.

## Structure

```
backlog/
├── _template.md   # Ticket template (cp to create a ticket, never edit in place)
├── README.md      # This file — conventions reference
├── ROADMAP.md     # Global index + all ticket metadata
├── ideas/         # status: idea
├── tasks/         # status: spec | dev | test | review
└── archive/       # status: done
```

## Naming convention

- Ticket files are named **`NNN-slug.md`** — e.g. `042-email-password-auth.md`.
- `NNN` is a **monotonically increasing global counter** (never reused), shared across all folders.
- `slug` is a short kebab-case recap of the title. No `I`/`T` prefix.
- Tickets have **no YAML frontmatter**. The title is the `# H1` of the file.
- All metadata (title, type, size, status) lives only in `ROADMAP.md`.
- A ticket **keeps its name for its whole life** — it only moves between folders. Rename only if the title changes substantially.

## Ticket workflow

```
idea → spec → dev → test → review → done
```

| Status   | Meaning                                | Folder    |
| -------- | -------------------------------------- | --------- |
| `idea`   | Draft, not yet specified               | `ideas/`  |
| `spec`   | AC defined + size set, ready to tackle | `tasks/`  |
| `dev`    | Being implemented                      | `tasks/`  |
| `test`   | Code done, tests being written/run     | `tasks/`  |
| `review` | Tests green, awaiting human validation | `tasks/`  |
| `done`   | Validated and archived                 | `archive/`|

Any status change must be reflected in **both** the folder and the ROADMAP — they are always in sync.

## Ticket metadata

Defined once in ROADMAP.md, never in the ticket file.

- **type**: `feature` (new capability) · `fix` (bug) · `chore` (maintenance/refacto) · `spike` (timeboxed exploration)
- **size**: rough time bucket — `10min` · `1h` · `3h` · `3h+` (anything `3h+` → consider splitting)

## Acceptance criteria (AC)

Verifiable checkboxes. Must answer: "how do I know this is done?".

- ✅ `[ ] User can log in with a valid email + password`
- ❌ `[ ] Authentication works` (too vague)