# ai-coding-template

Squelette de **méthodologie IA** pour vibe coder un projet solo avec Claude Code.
Fournit la structure (méthodo, commands, agents, conventions) — **pas le code applicatif**.

Conçu pour : usage solo, outil quotidien, contexte agent minimal et économe.

## Démarrer un nouveau projet

```bash
git clone https://github.com/<votre-user>/ai-coding-template mon-projet
cd mon-projet
rm -rf .git && git init
```

Ouvrir Claude Code dans le dossier, puis :

> "On démarre. Lis `README.md` et propose la première étape."

L'initialisation du code applicatif (Flutter, autre stack) est **hors scope** : ajoutez-le après le clone, comme vous voulez.

## Ce qui est dans le template

- `CLAUDE.md` — pivot des règles d'or et table de routage (toujours chargé)
- `ROADMAP.md` — source de vérité de l'état du backlog
- `.ai/` — méthodologie (conventions code, ADRs, choix de conception du framework)
- `backlog/` — tickets qui voyagent entre `ideas/`, `tasks/`, `archive/`
- `.claude/` — slash commands et sub-agents

Voir `.ai/DESIGN.md` (jamais lu automatiquement) pour comprendre **pourquoi** chaque choix de conception a été fait.

## Workflow ticket

`idea → spec → dev → test → review → done`

Un ticket = **un fichier markdown qui voyage** entre `backlog/ideas/`, `backlog/tasks/`, `backlog/archive/`. Pas de duplication.

## Commandes principales

| Commande | Rôle |
|---|---|
| `/help` | Aide |
| `/refine <id?>` | Créer une nouvelle idée OU affiner un ticket existant |
| `/dev <id>` | Exécuter un ticket existant (code, tests, debug) |

Le reste se fait en langage naturel (ex: "fais-moi le point" → l'agent lit `ROADMAP.md` et résume).

## Sub-agents

- `pm` — clarification / priorisation / roadmap / archivage
- `dev` — code / test / debug

Invoqués automatiquement par les commandes. Tu n'as jamais à les lancer à la main.
