# DESIGN — Choix de conception du framework

> ⚠️ **Ce fichier n'est JAMAIS auto-loadé.** Lis-le UNIQUEMENT si l'utilisateur le demande explicitement, ou s'il pose une question sur le "pourquoi" d'un choix de conception du framework.
>
> Toutes les décisions de conception du framework lui-même sont consignées ici. Il sert de mémoire pour ne pas redébattre, pas de référence active.

---

## Besoin fondateur

Avoir un agent IA avec un **contexte actif faible, très efficient et économe**. L'agent ne charge QUE le contexte nécessaire à la tâche en cours. Le système reste scalable quand le projet grossit.

## Règle d'or

Toute modif de statut d'un ticket → `ROADMAP.md` mis à jour immédiatement. La roadmap est la source de vérité permanente de l'état du backlog.

## Cible

Usage solo, outil quotidien, conventions Flutter par défaut (mais structure méthodo agnostique).

---

## Choix de conception (figés)

### 1. Repo séparé `ai-coding-template`, vierge, clonable
**Pourquoi.** Versionné, évolutif, partageable. Pas de script de bootstrap : `git clone` suffit.

### 2. 1 seul CLAUDE.md root (ultra court, ~40 lignes)
**Pourquoi.** Économie tokens. Pas de hiérarchie de CLAUDE.md (créés ponctuellement par le user si une zone justifie).

### 3. 2 sub-agents : PM + Dev
**Pourquoi.** Les prompts détaillés vivent dans les agents (chargés à la demande), pas dans CLAUDE.md. Le main agent reste léger.

### 4. Amélioration framework = pro-activité légère intégrée dans PM/Dev
**Pourquoi.** Pas de fichier `IMPROVEMENTS.md` ni de mécanisme dédié. PM et Dev mentionnent une amélioration uniquement si vraiment pertinent.

### 5. 3 slash commands en anglais : `/help` `/refine` `/dev`
**Pourquoi.** Points d'entrée user qui invoquent les bons agents avec le bon contexte préchargé.
- `/refine` = idéation + raffinement (création/affinage d'un ticket, peu importe le type : feature, fix, chore, spike).
- `/dev` = exécution sur ticket existant.
- `/help` = aide.
- Le reste se fait en langage naturel.

**Rejetés** : `/summary` (absorbé par "fais-moi le point" en langage naturel), `/debug` (un bug = un ticket type fix créé via `/refine`), `/feat` / `/brainstorm` / `/start` / `/checkpoint` (redondants).

### 6. 1 ticket = 1 fichier markdown qui voyage entre `ideas/` → `tasks/` → `archive/`
**Pourquoi.** Pas de doublon. `mv` à chaque transition. Le fichier est la trace unique.

### 7. Schéma ticket : `type` + `priority` + `size` + `status` + `acceptance criteria`
**Pourquoi.** Suffisamment riche pour priorisation Scrum solo, sans sur-engineering.
- `type` : feature / fix / chore / spike
- `priority` : now / next / later
- `size` : XS / S / M / L
- `status` : 6 statuts (voir #8)

### 8. Workflow ticket : `idea → spec → dev → test → review → done`
**Pourquoi.** 6 statuts demandés par user. Distingue dev (code), test (tests auto), review (validation humaine).

### 9. Roadmap = table markdown compacte à la racine
**Pourquoi.** Solo + git versionne tout l'historique. Trello inutile (lecture native par l'agent, zéro friction, pas de switch d'app).

### 10. Méthodo dans `.ai/` (distinct de `.claude/` natif)
**Pourquoi.** Sépare clairement : `.claude/` = configs Claude Code natives (commands, agents, settings). `.ai/` = méthodologie projet (conventions, décisions, design).

### 11. `.ai/DESIGN.md` isolé par instruction explicite dans CLAUDE.md root
**Pourquoi.** Conserve les choix de conception du framework SANS les charger en permanence. Ce fichier (celui que tu lis) reste froid.

### 12. Règle d'or roadmap : soft + hook non-bloquant
**Pourquoi.** Instruction dans CLAUDE.md root et PM agent + hook PostToolUse qui détecte modif `backlog/**` et rappelle (n'empêche pas) de mettre à jour ROADMAP. Pas de blocage : friction minimale.

### 13. Conventions code : 1 seul fichier `.ai/conventions/code.md` (fusionne style, git, tests)
**Pourquoi.** Économie de fichiers. Un seul fichier à lire pour les conventions techniques.

### 14. Glossary métier : non créé par défaut
**Pourquoi.** Optionnel, le user le crée si vocab complexe. Évite de polluer avec un fichier vide.

### 15. Le template ne touche PAS à `lib/`
**Pourquoi.** Le template ne fournit QUE la structure de méthodologie IA. Le code (Flutter ou autre) est ajouté par le user après clone, comme il veut. Pas de structure feature-first imposée.

### 16. Templates physiques de ticket et ADR : fichiers `_template.md` à côté de leur dossier
**Pourquoi.** `backlog/_template.md` et `.ai/decisions/_template.md`. Copiés via `cp` puis renommés/édités. Pas de format inline dans les README (économie de tokens à la lecture).

### 17. Pas d'index `README.md` dans `.ai/decisions/`
**Pourquoi.** On s'appuie sur `ls .ai/decisions/` (le numérotage rend la liste lisible). Les ADRs se référencent entre eux dans leur contenu si besoin. Économie.

### 18. Pas d'`INDEX.md` séparé dans `backlog/`
**Pourquoi.** `ROADMAP.md` à la racine joue ce rôle (tickets actifs + 5 derniers `done`). Pour l'historique exhaustif : `ls backlog/archive/`. `backlog/README.md` n'est PAS un index — c'est un guide d'utilisation.

---

## Sources d'inspiration éprouvées

- **ADRs (Architecture Decision Records)** — Michael Nygard / ThoughtWorks. Format `Contexte → Options → Décision → Conséquences`.
- **Kanban simple** — statuts comme colonnes, pas de sprints datés (pas d'engagement temporel pour un solo).
- **Single source of truth** — `ROADMAP.md` est la vérité unique du backlog. Pas de duplication entre Trello/Notion/fichiers.
- **YAGNI (You Aren't Gonna Need It)** — pas de feature, abstraction ou catégorie tant qu'elle n'est pas nécessaire.
- **GTD-inspired** — capture rapide (idée brute) puis traitement (clarification + spec).
