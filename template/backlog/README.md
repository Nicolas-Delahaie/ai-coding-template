# Backlog — Usage Guide

> **This file is NOT an index.** The global index is `backlog/ROADMAP.md` (root).
> For full history: `ls archive/`.

## Structure

```
backlog/
├── _template.md   # Ticket template. Copy via `cp`, don't edit in place.
├── README.md      # This file.
├── ideas/         # Tickets status: idea (unspecified drafts)
├── tasks/         # Tickets status: spec | dev | test | review (active)
└── archive/       # Tickets status: done
```

## Naming conventions

- **Raw idea**: `I-NNN-short-slug.md` (prefix `I` = idea)
- **Specified task**: `T-NNN-short-slug.md` (prefix `T` = task)
- The `NNN` number is **monotonically increasing** (never reused), regardless of I or T.
- Slug is kebab-case, short, descriptive.

Examples: `I-007-collaborative-mode.md`, `T-042-email-password-auth.md`.

## Ticket workflow (6 statuses)

```
idea → spec → dev → test → review → done
```

| Status   | Meaning                                | Location             |
| -------- | -------------------------------------- | -------------------- |
| `idea`   | Draft, not yet explored                | `ideas/I-NNN-*.md`   |
| `spec`   | Explored, AC defined, ready to tackle  | `tasks/T-NNN-*.md`   |
| `dev`    | Being implemented                      | `tasks/T-NNN-*.md`   |
| `test`   | Code written, tests being written/run  | `tasks/T-NNN-*.md`   |
| `review` | Tests green, awaiting human validation | `tasks/T-NNN-*.md`   |
| `done`   | Validated and archived                 | `archive/T-NNN-*.md` |

## Transitions (the file travels)

```
ideas/I-NNN-slug.md     ─(promotion)─►   tasks/T-NNN-slug.md   ─(archiving)─►   archive/T-NNN-slug.md
       (idea)                              (spec → dev → test → review)              (done)
```

- **Promotion `idea → spec`**: `mv` + rename (`I-` → `T-`).
- **Internal transitions (`spec → dev → test → review`)**: edit `status:` frontmatter only.
- **Archiving `review → done`**: `mv` to `archive/`.

**Golden rule**: every status transition → **immediate update** of `backlog/ROADMAP.md`.

## Creating a new ticket

```bash
cp backlog/_template.md backlog/ideas/I-<NNN>-<slug>.md
# Then edit the copied file: id, title, type, priority, size, dates, content.
# Then update backlog/ROADMAP.md.
```

In practice, use `/refine` (the PM agent handles all of this).

## Acceptance criteria (AC)

A list of verifiable checkboxes. Must answer: "how do I know this is done?".

Examples:

- ✅ `[ ] User can log in with a valid email + password`
- ❌ `[ ] Authentication works` (too vague)
