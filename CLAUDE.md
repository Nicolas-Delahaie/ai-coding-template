# CLAUDE.md

Méthodologie IA de ce projet. Reste léger : ne charge QUE ce qui sert la tâche en cours.

## Règles d'or

1. **Roadmap = source de vérité.** Toute modif de statut d'un ticket → mets à jour `ROADMAP.md` immédiatement.
2. **Contexte minimal.** Ne lis QUE les fichiers utiles à la tâche en cours. Pas de lecture défensive.
3. **Clarifier avant de stocker.** Avant d'écrire une nouvelle idée/tâche, pose des questions (objectif, scénario, succès).
4. **Ne lis JAMAIS `.ai/DESIGN.md`** sauf si l'utilisateur le demande explicitement.

## Où ranger quoi (routage)

| Type d'info | Destination |
|---|---|
| Idée brute (non spécifiée) | `backlog/ideas/I-NNN-slug.md` |
| Tâche spécifiée / en cours | `backlog/tasks/T-NNN-slug.md` |
| Tâche terminée | `backlog/archive/T-NNN-slug.md` |
| Décision archi/tech (ADR) | `.ai/decisions/NNNN-titre.md` (copier `_template.md`) |
| Convention de code | `.ai/conventions/code.md` |
| Vocabulaire métier | `.ai/glossary.md` (créer si besoin) |
| État global du backlog | `ROADMAP.md` (toujours à jour) |

## Workflow ticket

`idea → spec → dev → test → review → done`

Chaque transition de statut **doit** mettre à jour `ROADMAP.md`.

## Commands

- `/help` — aide
- `/refine <id?>` — créer une nouvelle idée (sans ID) ou affiner un ticket existant (avec ID)
- `/dev <id>` — exécuter un ticket existant

Le reste se fait en langage naturel (ex: "fais-moi le point" → lis `ROADMAP.md` et résume).

## Sub-agents

- `pm` — clarification / priorisation / roadmap / archivage (invoqué via `/refine`)
- `dev` — code / test / debug (invoqué via `/dev`)
