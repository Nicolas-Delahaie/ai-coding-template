#!/bin/bash
# ai-coding-template installer
# Usage (remote): curl -fsSL https://raw.githubusercontent.com/Nicolas-Delahaie/ai-coding-template/main/apply.sh | bash
# Usage (local):  ./apply.sh

set -euo pipefail

BRANCH="main"
REPO="Nicolas-Delahaie/ai-coding-template"

echo "📦 ai-coding-template → $(pwd)"

if [[ -n "$(git status --porcelain 2>/dev/null)" ]]; then
  printf "⚠️  Uncommitted changes detected — the install adds many files. Continue? [y/N] "
  read -r confirm < /dev/tty
  [[ "$confirm" =~ ^[Yy]$ ]] || { echo "Aborted."; exit 1; }
fi

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

if [[ -d "$SCRIPT_DIR/templates" ]]; then
  # Local mode: tdemplates directory exists next to the script
  REPO_ROOT="$SCRIPT_DIR"
  TEMPLATE_ROOT="$SCRIPT_DIR/templates"
  COMMIT="local"
else
  # Remote mode: download from GitHub
  TMP=$(mktemp -d)
  trap 'rm -rf "$TMP"' EXIT

  COMMIT=$(curl -fsSL "https://api.github.com/repos/$REPO/git/ref/heads/$BRANCH" \
    | grep '"sha"' | head -1 | sed 's/.*"sha": "\([^"]*\)".*/\1/')
  [[ -z "$COMMIT" ]] && { echo "❌ Could not resolve template commit hash."; exit 1; }

  curl -fsSL "https://github.com/$REPO/archive/$BRANCH.tar.gz" | tar xz -C "$TMP"
  REPO_ROOT="$TMP/$(ls "$TMP")"
  TEMPLATE_ROOT="$REPO_ROOT/templates"
fi

# Detect available languages (subfolders of templates/)
available_langs=()
for d in "$TEMPLATE_ROOT"/*/; do
  [[ -d "$d" ]] && available_langs+=("$(basename "$d")")
done

printf "\n🌐 Language (available: %s) [%s]: " "${available_langs[*]}" "${available_langs[0]}"
read -r chosen < /dev/tty
chosen="${chosen:-${available_langs[0]}}"

if [[ -d "$TEMPLATE_ROOT/$chosen" ]]; then
  SRC="$TEMPLATE_ROOT/$chosen"
  translation_required=false
else
  SRC="$TEMPLATE_ROOT/english"
  translation_required=true
fi

ts=$(date +%Y%m%d-%H%M%S)
backed_up=()
synced=()

# Copy every item shipped in templates/{lang}/ into the project root.
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

if $translation_required; then
  echo ""
  echo "📋 Paste this prompt into an AI to translate the template to ${chosen}:"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "Translate all content from english to ${chosen}."
  echo ""
  echo "Folders/files to translate (content only):"
  for item in "${synced[@]}"; do
    echo "  $item"
  done
  echo ""
  cat "$REPO_ROOT/TRANSLATION_RULES.md"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
fi

if [[ -n "$COMMIT" ]]; then
  echo "💡 Suggested commit:"
  echo "   git commit -m \"chore: apply ai-coding-template@${COMMIT:0:7}\""
  echo ""
fi

echo "✅ Done. Type /help in Claude Code."
