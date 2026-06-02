---
description: Execute an existing ticket (code, tests, debug — invokes the Dev agent)
argument-hint: "T-NNN or I-NNN"
---

The user invokes `/dev $ARGUMENTS`.

The argument must be a ticket ID (`T-NNN` or exceptionally `I-NNN`).

**Step 1 — Pre-flight check (main agent, quick)**:

1. Locate the ticket: `ls backlog/ideas/$ARGUMENTS-* backlog/tasks/$ARGUMENTS-* 2>/dev/null`.
2. If not found: inform the user and suggest `/refine $ARGUMENTS` (if it's a new idea) or display available tickets.
3. If the ticket is in `ideas/` (status `idea`): it's not ready for dev. Suggest the user run `/refine $ARGUMENTS` first to promote it to `spec`.
4. If the ticket is in `tasks/` but status ≠ `spec` (already in `dev`, `test`, `review`): inform the user of the current state and ask for confirmation before resuming.

**Step 2 — Switch to `dev`**:

Edit the ticket frontmatter: `status: dev`, update `updated:` to today's date, add a line in `## History`.
Update `backlog/ROADMAP.md` (move the line from "Ready to tackle" to "In progress").

**Step 3 — Delegate to the `dev` sub-agent**:

Invoke the `dev` sub-agent via the Agent tool with this context:

> Mission: implement ticket `$ARGUMENTS`.
>
> 1. Read `backlog/tasks/$ARGUMENTS-*.md` in full.
> 2. Read `.ai/conventions/code.md`.
> 3. If the ticket cites ADRs (`.ai/decisions/NNNN-*.md`), read those specifically (NOT the others).
> 4. Read ONLY the application code relevant to this ticket.
> 5. Implement the feature / fix / chore. Strictly follow conventions.
> 6. Write the necessary tests (`flutter test` must pass). Status → `test` while writing tests.
> 7. When tests pass: status → `review`. Update `backlog/ROADMAP.md`.
> 8. Ask for human validation from the user.
> 9. If the user validates: status → `done`, `mv backlog/tasks/T-NNN-*.md backlog/archive/`, update `backlog/ROADMAP.md`.

Follow the **golden rule** at every status transition.
