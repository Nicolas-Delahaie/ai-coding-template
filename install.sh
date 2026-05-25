#!/usr/bin/env bash
#
# ai-coding-template — installer for an existing project
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/Nicolas-Delahaie/ai-coding-template/main/install.sh | bash

set -euo pipefail

BRANCH="main"

TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

echo "📦 ai-coding-template → $(pwd)"
echo ""

curl -fsSL "https://github.com/Nicolas-Delahaie/ai-coding-template/archive/$BRANCH.tar.gz" | tar xz -C "$TMP"
SRC="$TMP/$(ls "$TMP")"

# Ask for one letter among $2; default "k"; non-interactive → "k"
ask() {
  local prompt="$1" valid="$2" choice
  while true; do
    printf '%s [k]: ' "$prompt" > /dev/tty 2>/dev/null || { printf 'k'; return; }
    IFS= read -r choice < /dev/tty || { printf 'k'; return; }
    choice="${choice:-k}"
    if [[ ${#choice} -eq 1 && "$valid" == *"$choice"* ]]; then
      printf '%s' "$choice"
      return
    fi
    printf '  ⚠️  One letter among: %s\n' "$valid" > /dev/tty
  done
}

# Top-level folders
for d in .ai .claude backlog; do
  src="$SRC/$d"
  [[ -d "$src" ]] || continue

  if [[ ! -e "./$d" ]]; then
    cp -R "$src" "./$d"
    echo "  ✓ $d/ (new)"
    continue
  fi

  echo ""
  echo "⚠️  Folder $d/ exists: [k]eep / [m]erge / [r]eplace / [b]ackup"
  case "$(ask "  Choice" "kmrb")" in
    k) echo "  ⊘ $d/ kept" ;;
    m)
      echo "  → $d/ merging"
      while IFS= read -r -d '' f; do
        t="./$d/${f#"$src"/}"
        if [[ -e "$t" ]]; then
          echo "    ⊘ ${t#./}"
        else
          mkdir -p "$(dirname "$t")"
          cp "$f" "$t"
          echo "    ✓ ${t#./}"
        fi
      done < <(find "$src" -type f -print0)
      ;;
    r) rm -rf "./$d"; cp -R "$src" "./$d"; echo "  ✓ $d/ replaced" ;;
    b)
      ts=$(date +%Y%m%d-%H%M%S)
      mv "./$d" "./$d.bak-$ts"
      cp -R "$src" "./$d"
      echo "  ✓ $d/ (old → $d.bak-$ts/)"
      ;;
  esac
done

# Root files (except install.sh + README.md + .gitignore)
echo ""
while IFS= read -r -d '' f; do
  rel="${f#"$SRC"/}"
  [[ "$rel" == */* ]] && continue
  [[ "$rel" == "install.sh" || "$rel" == "README.md" || "$rel" == ".gitignore" ]] && continue

  if [[ ! -e "./$rel" ]]; then
    cp "$f" "./$rel"
    echo "  ✓ $rel (new)"
    continue
  fi

  echo ""
  echo "⚠️  File $rel exists: [k]eep / [r]eplace / [n]ew / [b]ackup"
  case "$(ask "  Choice" "krnb")" in
    k) echo "  ⊘ $rel kept" ;;
    r) cp "$f" "./$rel"; echo "  ✓ $rel replaced" ;;
    n) cp "$f" "./$rel.new"; echo "  ✓ $rel.new (merge manually)" ;;
    b)
      ts=$(date +%Y%m%d-%H%M%S)
      mv "./$rel" "./$rel.bak-$ts"
      cp "$f" "./$rel"
      echo "  ✓ $rel (old → $rel.bak-$ts)"
      ;;
  esac
done < <(find "$SRC" -maxdepth 1 -type f -print0)

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
