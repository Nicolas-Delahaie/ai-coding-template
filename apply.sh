#!/bin/bash
# ai-coding-template installer
# Usage: curl -fsSL https://raw.githubusercontent.com/Nicolas-Delahaie/ai-coding-template/main/apply.sh | bash

set -euo pipefail

BRANCH="main"


TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

echo "📦 ai-coding-template → $(pwd)"

curl -fsSL "https://github.com/Nicolas-Delahaie/ai-coding-template/archive/$BRANCH.tar.gz" | tar xz -C "$TMP"
SRC="$TMP/$(ls "$TMP")/template"
ts=$(date +%Y%m%d-%H%M%S)
backed_up=()
synced=()

# Copy every item shipped in template/ into the project root.
shopt -s dotglob nullglob
for path in "$SRC"/*; do
  item=$(basename "$path")
  [[ "$item" == ".DS_Store" ]] && continue
  if [[ -e "./$item" ]]; then
    mv "./$item" "./$item.bak-$ts"
    echo "  ↩ $item → $item.bak-$ts"
    backed_up+=("$item.bak-$ts")
  fi
  cp -R "$path" "./$item"
  echo "  ✓ $item"
  synced+=("$item")
done

if [[ ${#backed_up[@]} -gt 0 ]]; then
  echo ""
  echo "⚠️  Backed-up items — manually merge them into the new versions:"
  for f in "${backed_up[@]}"; do echo "    $f"; done
fi

printf "\n🌐 Keep the template in English? [Y/n] "
read -r lang_choice < /dev/tty

if [[ "$lang_choice" =~ ^[Nn]$ ]]; then
  printf "🌐 Target language: "
  read -r target_lang < /dev/tty

  echo "📋 Paste this prompt into an AI to translate the template:"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "Translate all content from English to ${target_lang}."
  echo ""
  echo "Folders/files to translate (content only):"
  for item in "${synced[@]}"; do
    echo "  $item"
  done
  cat <<'PROMPT'

Rules — do NOT translate:
  - File and folder names
  - Frontmatter keys: id, title, type, priority, size, status, tags, created, updated
  - Slash commands: /help, /refine, /dev
  - Code blocks, file paths
  - Technical terms: backlog, roadmap, ADR, YAGNI, spec, chore, spike
PROMPT
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
fi

echo "✅ Done. Type /help in Claude Code."
