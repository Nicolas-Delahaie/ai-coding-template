# ai-coding-template

Squelette de **méthodologie IA** pour vibe coder un projet solo avec Claude Code.
Fournit la structure (méthodo, commands, agents, conventions) — **pas le code applicatif**.

Conçu pour : usage solo, outil quotidien, contexte agent minimal et économe.

## Installer dans un projet **existant** (fusion non destructive)

Depuis la racine du projet :

```bash
curl -fsSL https://raw.githubusercontent.com/Nicolas-Delahaie/ai-coding-template/main/install.sh | bash
```

Le script télécharge le tarball, puis pour chaque dossier / fichier en conflit te demande quoi faire : **keep / merge / replace / backup** (et `new` pour les fichiers, `merge` spécial pour `.gitignore`). Zéro install machine (curl + bash).

## Démarrer un **nouveau projet** (clone)

```bash
git clone https://github.com/Nicolas-Delahaie/ai-coding-template mon-projet
cd mon-projet
rm -rf .git && git init
```

L'initialisation du code applicatif (Flutter, autre stack) est **hors scope** : ajoutez-le après le clone.

## Structure du repo

- `CLAUDE.md` — pivot (règles d'or, routage, workflow, commands, sub-agents)
- `ROADMAP.md` — source de vérité du backlog
- `.ai/` — méthodologie (conventions, ADRs, choix de conception)
- `backlog/` — tickets qui voyagent entre `ideas/` / `tasks/` / `archive/`
- `.claude/` — slash commands + sub-agents + settings

## Pour aller plus loin

- `CLAUDE.md` : la méthodologie complète (40 lignes)
- `backlog/README.md` : workflow ticket détaillé
- `.ai/DESIGN.md` : les choix de conception du framework et leur justification
- Dans Claude Code, tape `/help` pour découvrir les commandes
