# ai-coding-template

Squelette de **méthodologie IA** pour vibe coder un projet solo avec Claude Code.
Fournit la structure (méthodo, commands, agents, conventions) — **pas le code applicatif**.

Conçu pour : usage solo, outil quotidien, contexte agent minimal et économe.

> **Tout est en français** : langue native, plus simple à maintenir et à utiliser au quotidien. Facilement forkable / anglicisable avec un simple prompt si besoin.

## Installer dans un projet existant

Depuis la racine du projet cible :

```bash
curl -fsSL https://raw.githubusercontent.com/Nicolas-Delahaie/ai-coding-template/main/install.sh | bash
```

Le script télécharge le tarball, puis pour chaque dossier / fichier en conflit te demande quoi faire : **keep / merge / replace / backup** (et `new` pour les fichiers). Zéro install machine (curl + bash).

## Structure du repo

- `CLAUDE.md` — pivot (règles d'or, routage, workflow, commands, sub-agents)
- `.ai/` — méthodologie (conventions, ADRs + index)
- `backlog/` — tickets (`ideas/` / `tasks/` / `archive/`) + `ROADMAP.md` (source de vérité)
- `.claude/` — slash commands + sub-agents + settings

## Pour aller plus loin

- `CLAUDE.md` : la méthodologie complète (~40 lignes)
- `backlog/README.md` : workflow ticket détaillé
- Dans Claude Code, tape `/help` pour découvrir les commandes

---

## Choix de conception (pour les contributeurs / forks)

> Ces choix sont intentionnellement absents du projet cible — ils ne figurent que dans ce README.

### Besoin fondateur

Avoir un agent avec un **contexte actif faible, très efficient et économe**. L'agent ne charge QUE le contexte nécessaire à la tâche en cours. Le système reste scalable quand le projet grossit.

### Règle d'or

Toute modif de statut d'un ticket → `ROADMAP.md` mis à jour immédiatement. La roadmap est la source de vérité permanente de l'état du backlog.

### Décisions structurantes

| # | Choix | Pourquoi |
|---|-------|---------|
| 1 | Repo séparé `ai-coding-template`, vierge, clonable | Versionné, évolutif, partageable. Pas de script de bootstrap : `git clone` suffit. |
| 2 | 1 seul `CLAUDE.md` root (ultra court, ~40 lignes) | Économie tokens. Pas de hiérarchie de CLAUDE.md (créés ponctuellement si une zone le justifie). |
| 3 | 2 sub-agents : PM + Dev | Les prompts détaillés vivent dans les agents (chargés à la demande), pas dans CLAUDE.md. Le main agent reste léger. |
| 4 | Amélioration framework = pro-activité légère intégrée dans PM/Dev | Pas de fichier `IMPROVEMENTS.md` ni de mécanisme dédié. PM et Dev mentionnent une amélioration uniquement si vraiment pertinent. |
| 5 | 3 slash commands en anglais : `/help` `/refine` `/dev` | Points d'entrée user qui invoquent les bons agents avec le bon contexte préchargé. `/refine` = idéation + raffinement. `/dev` = exécution. `/help` = aide. Le reste se fait en langage naturel. |
| 6 | 1 ticket = 1 fichier markdown qui voyage entre `ideas/` → `tasks/` → `archive/` | Pas de doublon. `mv` à chaque transition. |
| 7 | Schéma ticket : `type` + `priority` + `size` + `status` + `acceptance criteria` | Suffisamment riche pour priorisation Scrum solo, sans sur-engineering. |
| 8 | Workflow ticket : `idea → spec → dev → test → review → done` | 6 statuts. Distingue dev (code), test (tests auto), review (validation humaine). |
| 9 | Roadmap = table markdown compacte dans `backlog/` | Solo + git versionne tout l'historique. Colocalisée avec les tickets. Trello inutile (lecture native par l'agent, zéro friction). |
| 10 | Méthodo dans `.ai/` (distinct de `.claude/` natif) | Sépare clairement : `.claude/` = configs Claude Code natives. `.ai/` = méthodologie projet. |
| 11 | Conventions code : 1 seul fichier `.ai/conventions/code.md` | Économie de fichiers. Un seul fichier à lire pour les conventions techniques. |
| 12 | Glossaire métier : non créé par défaut | Optionnel, le user le crée si vocab complexe. Évite de polluer avec un fichier vide. |
| 13 | Le template ne touche PAS à `lib/` | Le template = méthodologie IA uniquement. Le code (Flutter ou autre) est ajouté par le user après clone, comme il veut. |
| 14 | Méta-fichiers préfixés `_` : `_template.md`, `_index.md` | Distingue visuellement les gabarits/index des vrais fichiers numérotés (`NNNN-*.md`). Le `_` les fait remonter en tête dans un `ls` trié. |
| 15 | Templates physiques de ticket et ADR : `_template.md` à côté de leur dossier | Copiés via `cp` puis renommés/édités. Pas de format inline dans les README (économie de tokens à la lecture). |
| 16 | Index ADR léger : `.ai/decisions/_index.md` | Une ligne par ADR (résumé + statut). Chargé UNIQUEMENT quand l'agent doit retrouver un choix passé. Jamais auto-loadé. |
| 17 | `backlog/ROADMAP.md` (dans `backlog/`, pas à la racine) | Colocalisé avec les tickets qu'il indexe. La racine reste épurée. |
| 18 | Pas d'`INDEX.md` séparé dans `backlog/` | `backlog/ROADMAP.md` joue ce rôle. Pour l'historique exhaustif : `ls backlog/archive/`. `backlog/README.md` = guide d'utilisation, pas un index. |
| 19 | Distribution via `install.sh` bash curlable | Zéro install machine. `degit`/`copier`/`npx` rejetés (écrasent ou requièrent install). Bash = un seul fichier, fusion interactive par prompt. |
| 20 | `README.md` non copié par install.sh | Évite d'écraser le README du projet cible. Les choix de conception du framework y sont conservés sans polluer le projet cible. |
| 21 | `.gitignore` non copié par install.sh | Le projet cible a son propre `.gitignore`. On ne l'écrase pas, on ne le fusionne pas. |
| 22 | README minimaliste, non dupliqué avec CLAUDE.md | Le README est pour humains (présentation + installation + structure). Toute la méthodologie vit dans CLAUDE.md. Évite la dérive (deux sources à maintenir). |
