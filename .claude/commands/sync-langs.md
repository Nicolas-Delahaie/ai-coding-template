---
description: Sync template translations. No arg = propagate current diff to all languages. Arg = bootstrap a new language.
---

Structure: `templates/{language}/` — one folder per language (full names: `english`, `french`, `spanish`…).

Read `TRANSLATION_RULES.md` at the repo root and follow it strictly for all translations.

## Without argument — diff sync

Detect which language changed and propagate to all others.

1. Run `git diff --name-only HEAD -- 'templates/'` (and `--cached` for staged files). If nothing, tell the user and stop.
2. Extract the source language from the changed paths (e.g. `templates/french/CLAUDE.md` → `french`). If multiple languages changed, ask the user which is canonical.
3. List all other directories in `templates/` — these are the targets.
4. For each target language and each changed file:
   1. Get the exact diff: `git diff HEAD -- templates/<source>/<path>`
   2. Read the current translation: `templates/<target>/<path>`
   3. Apply only the changed lines/paragraphs — translated into the target language. Do not touch lines outside the diff.
      - **Small change (a few lines):** use `sed -i` or a targeted bash command. 
      - **Larger change:** use the Edit tool on the specific old→new string. Never rewrite the whole file.
5. Report every file written per target language.

## With argument — bootstrap new language

`/sync-langs <language>`

1. Check if `templates/<language>/` already exists → if yes, error: "**<language> already exists** — run `/sync-langs` without argument to sync it."
2. Determine the source language (default: `english`).
3. Copy the full source folder to `templates/<language>/`.
4. Translate every file entirely into the target language, following `TRANSLATION_RULES.md`.
5. Report the created files and remind the user to commit to lock the translation.
