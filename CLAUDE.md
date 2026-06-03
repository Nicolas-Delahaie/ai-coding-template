# CLAUDE.md — ai-coding-template (dev repo)

This repo **produces** an AI methodology template. It does not use it.

## Key distinction

- **`templates/`** — the distributed templates. One subfolder per language (`english/`, `french/`…). The content of the chosen language folder is copied as-is into target projects by `apply.sh`. This is the product.
- **Root** — the repo plumbing, NOT distributed: `README.md`, `apply.sh`, `.gitignore`, this `CLAUDE.md`.
- **`.claude/`** at root — Claude Code commands for this dev repo only (e.g. `/sync-langs`). NOT distributed — unrelated to `templates/{lang}/.claude/` which is.

## Golden rule

When working on the template, edit **inside `templates/{lang}/`**. Never confuse the root `CLAUDE.md` (this file, meta) with `templates/{lang}/CLAUDE.md` (the distributed methodology).

## Managing translations

Translations live in `templates/` and are versioned. They are never regenerated on the fly — this prevents non-deterministic drift when the template evolves.

**Editing an existing language**

1. Edit files in `templates/{lang}/`
2. Run `/sync-langs` — Claude detects the source language from the git diff and propagates changes (diff-only) to all other existing languages
3. Commit everything

**Adding a new language**

Run `/sync-langs {language}` (e.g. `/sync-langs spanish`). Claude bootstraps `templates/spanish/` from English following the rules in `TRANSLATION_RULES.md`, then reminds you to commit to lock the translation.

## Commit conventions

`<type>(<scope>): <summary>`

Types: `feat` · `fix` · `refactor` · `docs` · `chore`
Scope (optional): `install` · `template` · `apply` · `sync` · `readme`

Examples:
- `feat(sync): add --from flag to force source language`
- `refactor(apply): simplify language selection logic`
- `docs(readme): update install instructions`

**Never** add `Co-Authored-By` trailers to commits in this repo.

## Testing apply.sh

`apply.sh` downloads the repo from GitHub, asks which language you want from the available folders in `templates/`, and copies the content to the target project root. If the requested language does not exist, it outputs a translation prompt.
