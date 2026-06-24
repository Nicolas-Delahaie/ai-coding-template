# CLAUDE.md

Méthodologie IA pour ce projet. Rester léger : ne charger que ce dont la tâche courante a besoin.

## Règles d'or

1. **Roadmap = source de vérité.** Tout changement de statut d'un ticket → mettre à jour `backlog/ROADMAP.md` immédiatement.
2. **Contexte minimal.** Ne lire que les fichiers utiles à la tâche en cours. Pas de lecture défensive.
3. **Clarifier avant de stocker.** Avant d'écrire une nouvelle idée/tâche, poser des questions (objectif, scénario, critères de succès).
4. **S'auto-améliorer.** Si une instruction semble incorrecte ou manquante pour la situation, le dire et proposer un correctif directement dans ce fichier.

## Où stocker quoi (routage)

| Type d'info                      | Destination                                                    |
| -------------------------------- | -------------------------------------------------------------- |
| Idée brute (non spécifiée)       | `backlog/1_ideas/NNN-slug.md`                                  |
| Tâche spécifiée / active         | `backlog/2_tasks/NNN-slug.md`                                  |
| Tâche complétée                  | `backlog/3_archive/NNN-slug.md`                                |
| Décision arch/tech globale (ADR) | `docs/decisions/NNNN-title.md` (copier `_template.md`)         |
| Détail tech propre à une feature | message de commit (`<type>(<scope>): ...`), pas dans le ticket |
| Convention de code               | `docs/conventions/code.md`                                     |
| Vocabulaire métier               | `docs/glossary.md` (créer si besoin)                           |
| État global du backlog           | `backlog/ROADMAP.md` (toujours à jour)                         |

## Workflow des tickets

`idea → spec → dev → test → review → done`

Chaque transition de statut **doit** mettre à jour `backlog/ROADMAP.md`.

## Commandes

- `/help` — aide
- `/refine <id?>` — créer une nouvelle idée (sans ID) ou affiner un ticket existant (avec ID)
- `/dev <id>` — exécuter un ticket existant

Tout le reste en langage naturel (ex. "donne-moi un statut" → lire `backlog/ROADMAP.md` et résumer).

## Sous-agents

- `pm` — clarification / priorisation / roadmap / archivage (invoqué via `/refine`)
- `dev` — code / test / debug (invoqué via `/dev`)
