---
description: Exécuter un ticket existant (code, tests, debug — invoque le Dev agent)
argument-hint: "T-NNN ou I-NNN"
---

L'utilisateur invoque `/dev $ARGUMENTS`.

L'argument doit être un ID de ticket (`T-NNN` ou exceptionnellement `I-NNN`).

**Étape 1 — Pré-vol (main agent, rapide)** :

1. Localise le ticket : `ls backlog/ideas/$ARGUMENTS-* backlog/tasks/$ARGUMENTS-* 2>/dev/null`.
2. Si introuvable : informe l'utilisateur et propose `/refine $ARGUMENTS` (s'il s'agit d'une nouvelle idée) ou affiche les tickets disponibles.
3. Si le ticket est en `ideas/` (statut `idea`) : il n'est pas prêt à dev. Propose à l'utilisateur de lancer `/refine $ARGUMENTS` d'abord pour le promouvoir en `spec`.
4. Si le ticket est en `tasks/` mais statut ≠ `spec` (déjà en `dev`, `test`, `review`) : informe l'utilisateur de l'état actuel et demande confirmation avant de reprendre.

**Étape 2 — Bascule en `dev`** :

Édite le frontmatter du ticket : `status: dev`, met à jour `updated:` à la date du jour, ajoute une ligne dans `## Historique`.
Met à jour `backlog/ROADMAP.md` (déplace la ligne de "Prête à attaquer" vers "En cours").

**Étape 3 — Délégation au sub-agent `dev`** :

Invoque le sub-agent `dev` via le Agent tool avec ce contexte :
> Mission : implémenter le ticket `$ARGUMENTS`.
>
> 1. Lis intégralement `backlog/tasks/$ARGUMENTS-*.md`.
> 2. Lis `.ai/conventions/code.md`.
> 3. Si le ticket cite des ADRs (`.ai/decisions/NNNN-*.md`), lis ceux-là spécifiquement (PAS les autres).
> 4. Lis UNIQUEMENT le code applicatif pertinent pour ce ticket.
> 5. Implémente la feature / fix / chore. Respecte strictement les conventions.
> 6. Écris les tests nécessaires (`flutter test` doit passer). Statut → `test` pendant l'écriture des tests.
> 7. Quand les tests passent : statut → `review`. Mets à jour `backlog/ROADMAP.md`.
> 8. Demande validation humaine à l'utilisateur.
> 9. Si l'utilisateur valide : statut → `done`, `mv backlog/tasks/T-NNN-*.md backlog/archive/`, update `backlog/ROADMAP.md`.

Respecte la **règle d'or** à chaque transition de statut.
