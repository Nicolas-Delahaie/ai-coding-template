---
description: Create a new idea OR refine an existing ticket (invokes the PM agent)
argument-hint: "[optional-id-or-description]"
---

The user invokes `/refine $ARGUMENTS`.

Analyze the argument and delegate to the `pm` sub-agent:

**Case 1 — the argument is empty or doesn't look like an ID (a ticket number `NNN`)**: new idea to create.

Invoke the `pm` sub-agent via the Agent tool with this context:

> Mission: create a new idea from the description "$ARGUMENTS" (may be empty).
>
> 1. Ask the user 3-5 clarification questions BEFORE writing anything (goal, usage scenario, success criterion, out-of-scope, possible dependencies).
> 2. Once answers are received, identify the `type`: feature / fix / chore / spike.
> 3. Find the next free `NNN` number (check `ls backlog/1_ideas/ backlog/2_tasks/ backlog/3_archive/` for the highest).
> 4. `cp backlog/_template.md backlog/1_ideas/<NNN>-<kebab-slug>.md`
> 5. Fill in the ticket: `# title` heading + goal, scenario, initial AC, dependencies if any.
> 6. Add a row in `backlog/ROADMAP.md` (section "To explore") with informations.
> 7. Confirm to the user what was created and the next step (`/refine <NNN>` to refine, or `/dev` later when ready).

**Case 2 — the argument looks like an ID (a ticket number `NNN`)**: existing ticket to refine.

Invoke the `pm` sub-agent via the Agent tool with this context:

> Mission: refine the existing ticket `$ARGUMENTS`.
>
> 1. Read `backlog/1_ideas/$ARGUMENTS-*.md` or `backlog/2_tasks/$ARGUMENTS-*.md`.
> 2. Identify grey areas (vague AC, missing size, unclear scenario).
> 3. Ask the user targeted questions about these areas.
> 4. Edit the ticket to make it actionable.
> 5. If it was an `idea` and is now fully specified (clear AC + size defined), promote to `spec`: `mv backlog/1_ideas/<NNN>-*.md backlog/2_tasks/`, update status to `spec` in ROADMAP.
> 6. Update `backlog/ROADMAP.md`.
> 7. Confirm to the user the new ticket state.

In both cases, **follow the golden rule**: any status change → `backlog/ROADMAP.md` up to date.
