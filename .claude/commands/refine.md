---
description: Créer une nouvelle idée OU affiner un ticket existant (invoque le PM agent)
argument-hint: "[id-optionnel-ou-description]"
---

L'utilisateur invoque `/refine $ARGUMENTS`.

Analyse l'argument et délègue au sub-agent `pm` :

**Cas 1 — l'argument est vide ou ne ressemble pas à un ID (`I-NNN` ou `T-NNN`)** : nouvelle idée à créer.

Invoque le sub-agent `pm` via le Agent tool avec ce contexte :
> Mission : créer une nouvelle idée à partir de la description "$ARGUMENTS" (peut être vide).
>
> 1. Pose 3-5 questions de clarification à l'utilisateur AVANT d'écrire quoi que ce soit (objectif, scénario d'usage, critère de succès, hors-scope, dépendances éventuelles).
> 2. Une fois les réponses obtenues, identifie le `type` : feature / fix / chore / spike.
> 3. Trouve le prochain numéro `NNN` libre (vérifier `ls backlog/ideas/ backlog/tasks/ backlog/archive/` pour le plus grand).
> 4. `cp backlog/_template.md backlog/ideas/I-<NNN>-<slug-kebab>.md`
> 5. Édite le fichier copié : remplit `id`, `title`, `type`, `priority`, `size`, `created`, `updated`, `status: idea`, objectif, scénario, AC initiaux.
> 6. Mets à jour `backlog/ROADMAP.md` (ajoute la ligne dans "À explorer").
> 7. Confirme à l'utilisateur ce qui a été créé et la prochaine étape (`/refine I-<NNN>` pour affiner, ou `/dev` plus tard quand prêt).

**Cas 2 — l'argument ressemble à un ID (`I-NNN` ou `T-NNN`)** : ticket existant à affiner.

Invoque le sub-agent `pm` via le Agent tool avec ce contexte :
> Mission : affiner le ticket existant `$ARGUMENTS`.
>
> 1. Lis `backlog/ideas/$ARGUMENTS-*.md` ou `backlog/tasks/$ARGUMENTS-*.md`.
> 2. Identifie les zones d'ombre (AC vagues, prio non définie, taille manquante, scénario flou).
> 3. Pose des questions ciblées à l'utilisateur sur ces zones.
> 4. Édite le ticket pour le rendre actionnable.
> 5. Si c'était une `idea` et qu'elle est maintenant pleinement spécifiée (AC clairs, prio + taille), promeut en `spec` : `mv backlog/ideas/I-NNN-*.md backlog/tasks/T-NNN-*.md`, change `status: spec` dans le frontmatter, update `updated:`.
> 6. Mets à jour `backlog/ROADMAP.md`.
> 7. Confirme à l'utilisateur le nouvel état du ticket.

Dans les deux cas, **respecte la règle d'or** : toute modif de statut → `backlog/ROADMAP.md` à jour.
