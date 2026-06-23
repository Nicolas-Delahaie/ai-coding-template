---
description: Execute an existing ticket (code, tests, debug — invokes the Dev agent)
argument-hint: "NNN (ticket number)"
---

The user invokes `/dev $ARGUMENTS`.

The argument must be a ticket number (`NNN`).

**Step 1 — Pre-flight check (main agent, quick)**:

1. Locate the ticket: `ls backlog/1_ideas/$ARGUMENTS-* backlog/2_tasks/$ARGUMENTS-* 2>/dev/null`.
2. If not found: inform the user and suggest `/refine $ARGUMENTS` (if it's a new idea) or display available tickets.
3. If the ticket is in `ideas/` (status `idea`): it's not ready for dev. Suggest the user run `/refine $ARGUMENTS` first to promote it to `spec`.

**Step 2 — Switch to `dev`**:

Update `backlog/ROADMAP.md`: move the row from "Ready to tackle" to "In progress", set status to `dev`.

**Step 3 — Delegate to the `dev` sub-agent**:

Invoke the `dev` sub-agent via the Agent tool with this context:

> Mission: implement ticket `$ARGUMENTS`.
>
> 1. Read `backlog/2_tasks/$ARGUMENTS-*.md` in full.
> 2. Read `docs/conventions/code.md`.
> 3. If the ticket cites ADRs (`docs/decisions/NNNN-*.md`), read those specifically (NOT the others).
> 4. Read ONLY the application code relevant to this ticket.
> 5. Implement the feature / fix / chore. Strictly follow conventions.
> 6. Write the necessary tests (`flutter test` must pass). Status → `test` while writing tests.
> 7. When tests pass: status → `review`. Update `backlog/ROADMAP.md`.
> 8. Ask for human validation from the user.
> 9. If the user validates: status → `done`, `mv backlog/2_tasks/<NNN>-*.md backlog/3_archive/`, update `backlog/ROADMAP.md`.

Follow the **golden rule** at every status transition.
