#!/usr/bin/env bash
#
# ai-coding-template — installateur dans un projet existant
#
# Usage :
#   curl -fsSL https://raw.githubusercontent.com/Nicolas-Delahaie/ai-coding-template/main/install.sh | bash

set -euo pipefail

BRANCH="main"

TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

echo "📦 ai-coding-template → $(pwd)"
echo ""

curl -fsSL "https://github.com/Nicolas-Delahaie/ai-coding-template/archive/$BRANCH.tar.gz" | tar xz -C "$TMP"
SRC="$TMP/$(ls "$TMP")"

# Demande une lettre parmi $2 ; défaut "k" ; non-interactif → "k"
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
    printf '  ⚠️  Une lettre parmi : %s\n' "$valid" > /dev/tty
  done
}

# Dossiers top-level
for d in .ai .claude backlog; do
  src="$SRC/$d"
  [[ -d "$src" ]] || continue

  if [[ ! -e "./$d" ]]; then
    cp -R "$src" "./$d"
    echo "  ✓ $d/ (nouveau)"
    continue
  fi

  echo ""
  echo "⚠️  Dossier $d/ existe : [k]eep / [m]erge / [r]eplace / [b]ackup"
  case "$(ask "  Choix" "kmrb")" in
    k) echo "  ⊘ $d/ gardé" ;;
    m)
      echo "  → $d/ merge"
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
    r) rm -rf "./$d"; cp -R "$src" "./$d"; echo "  ✓ $d/ remplacé" ;;
    b)
      ts=$(date +%Y%m%d-%H%M%S)
      mv "./$d" "./$d.bak-$ts"
      cp -R "$src" "./$d"
      echo "  ✓ $d/ (ancien → $d.bak-$ts/)"
      ;;
  esac
done

# Fichiers racine (sauf install.sh + README.md + .gitignore)
echo ""
while IFS= read -r -d '' f; do
  rel="${f#"$SRC"/}"
  [[ "$rel" == */* ]] && continue
  [[ "$rel" == "install.sh" || "$rel" == "README.md" || "$rel" == ".gitignore" ]] && continue

  if [[ ! -e "./$rel" ]]; then
    cp "$f" "./$rel"
    echo "  ✓ $rel (nouveau)"
    continue
  fi

  echo ""
  echo "⚠️  Fichier $rel existe : [k]eep / [r]eplace / [n]ew / [b]ackup"
  case "$(ask "  Choix" "krnb")" in
    k) echo "  ⊘ $rel gardé" ;;
    r) cp "$f" "./$rel"; echo "  ✓ $rel remplacé" ;;
    n) cp "$f" "./$rel.new"; echo "  ✓ $rel.new (à fusionner manuellement)" ;;
    b)
      ts=$(date +%Y%m%d-%H%M%S)
      mv "./$rel" "./$rel.bak-$ts"
      cp "$f" "./$rel"
      echo "  ✓ $rel (ancien → $rel.bak-$ts)"
      ;;
  esac
done < <(find "$SRC" -maxdepth 1 -type f -print0)

echo ""
echo "✅ Installation terminée. Tape /help dans Claude Code."
