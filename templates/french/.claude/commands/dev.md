---
description: Exécuter un ticket existant (code, tests, debug — invoque l'agent Dev)
argument-hint: "NNN (numéro de ticket)"
---

L'utilisateur invoque `/dev $ARGUMENTS`.

L'argument doit être un numéro de ticket (`NNN`).

**Étape 1 — Vérification préalable (agent principal, rapide)** :

1. Localiser le ticket : `ls backlog/1_ideas/$ARGUMENTS-* backlog/2_tasks/$ARGUMENTS-* 2>/dev/null`.
2. Si non trouvé : informer l'utilisateur et suggérer `/refine $ARGUMENTS` (s'il s'agit d'une nouvelle idée) ou afficher les tickets disponibles.
3. Si le ticket est dans `1_ideas/` (statut `idea`) : il n'est pas prêt pour le dev. Suggérer à l'utilisateur de lancer `/refine $ARGUMENTS` d'abord pour le promouvoir en `spec`.
4. Si le ticket est dans `2_tasks/` mais statut ≠ `spec` (déjà en `dev`, `test`, `review`) : informer l'utilisateur de l'état actuel. Ne pas demander confirmation — reprendre directement.

**Étape 2 — Passage en `dev`** :

Mettre à jour `backlog/ROADMAP.md` (déplacer la ligne de "Prêt à traiter" vers "En cours", statut → `dev`).

**Étape 3 — Déléguer au sous-agent `dev`** :

Invoquer le sous-agent `dev` via l'outil Agent avec ce contexte :

> Mission : implémenter le ticket `$ARGUMENTS`.
>
> 1. Lire `backlog/2_tasks/$ARGUMENTS-*.md` en entier.
> 2. Lire `.ai/conventions/code.md`.
> 3. Si le ticket cite des ADRs (`.ai/decisions/NNNN-*.md`), les lire spécifiquement (PAS les autres).
> 4. Lire UNIQUEMENT le code applicatif pertinent pour ce ticket.
> 5. Implémenter la fonctionnalité / le correctif / la chore. Suivre strictement les conventions.
> 6. Écrire les tests nécessaires (`flutter test` doit passer). Statut → `test` pendant l'écriture des tests.
> 7. Quand les tests passent : statut → `review`. Mettre à jour `backlog/ROADMAP.md`.
> 8. Demander la validation humaine à l'utilisateur.
> 9. Si l'utilisateur valide : statut → `done`, `mv backlog/2_tasks/<NNN>-*.md backlog/3_archive/`, mettre à jour `backlog/ROADMAP.md`.

Suivre la **règle d'or** à chaque transition de statut.
