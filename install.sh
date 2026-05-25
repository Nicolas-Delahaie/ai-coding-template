#!/usr/bin/env bash
#
# ai-coding-template — installer for an existing project
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/Nicolas-Delahaie/ai-coding-template/main/install.sh | bash

set -euo pipefail

BRANCH="main"

# Directories to sync from the template
SYNC_DIRS=(.ai .claude backlog)

# Root files to sync (install.sh and README.md excluded)
SYNC_FILES=(CLAUDE.md)

# ──────────────────────────────────────────────

TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

echo "📦 ai-coding-template → $(pwd)"
echo ""

curl -fsSL "https://github.com/Nicolas-Delahaie/ai-coding-template/archive/$BRANCH.tar.gz" | tar xz -C "$TMP"
SRC="$TMP/$(ls "$TMP")"

ts=$(date +%Y%m%d-%H%M%S)

for d in "${SYNC_DIRS[@]}"; do
  src="$SRC/$d"
  [[ -d "$src" ]] || continue

  if [[ -e "./$d" ]]; then
    mv "./$d" "./$d.bak-$ts"
    echo "  ↩ $d/ backed up → $d.bak-$ts/"
  fi

  cp -R "$src" "./$d"
  echo "  ✓ $d/ installed"
done

echo ""

for f in "${SYNC_FILES[@]}"; do
  src="$SRC/$f"
  [[ -f "$src" ]] || continue

  if [[ -e "./$f" ]]; then
    mv "./$f" "./$f.bak-$ts"
    echo "  ↩ $f backed up → $f.bak-$ts"
  fi

  cp "$src" "./$f"
  echo "  ✓ $f installed"
done

# ─── Language preference ───────────────────────────────────────────────────────
echo ""
printf "🌐 The template is in English. Keep it in English? [Y/n] " > /dev/tty 2>/dev/null
IFS= read -r lang_choice < /dev/tty 2>/dev/null || lang_choice="Y"
lang_choice="${lang_choice:-Y}"

if [[ "$lang_choice" =~ ^[Nn]$ ]]; then
  echo ""
  echo "📋 Copy-paste this prompt to an AI (Claude, GPT…) to translate the template:"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  cat <<'PROMPT'
I just installed ai-coding-template. Translate all its content from English to [YOUR LANGUAGE].

Translate these files (content only):

  CLAUDE.md
  backlog/ROADMAP.md
  backlog/README.md
  backlog/_template.md
  .ai/conventions/code.md
  .ai/decisions/_template.md
  .ai/decisions/_index.md
  .claude/agents/dev.md
  .claude/agents/pm.md
  install.sh  ← comments and echo strings only

Rules — do NOT translate:
  - File and folder names
  - Frontmatter keys: id, title, type, priority, size, status, tags, created, updated
  - Slash commands: /help, /refine, /dev
  - Code blocks, file paths
  - Technical terms: backlog, roadmap, ADR, YAGNI, spec, chore, spike
PROMPT
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
fi

echo ""
echo "✅ Installation complete. Type /help in Claude Code."
