---
description: Créer une nouvelle idée OU affiner un ticket existant (invoque l'agent PM)
argument-hint: "[id-optionnel-ou-description]"
---

L'utilisateur invoque `/refine $ARGUMENTS`.

Analyser l'argument et déléguer au sous-agent `pm` :

**Cas 1 — l'argument est vide ou ne ressemble pas à un numéro (`NNN`)** : nouvelle idée à créer.

Invoquer le sous-agent `pm` via l'outil Agent avec ce contexte :

> Mission : créer une nouvelle idée à partir de la description "$ARGUMENTS" (peut être vide).
>
> 1. Poser à l'utilisateur 3-5 questions de clarification AVANT d'écrire quoi que ce soit (objectif, scénario d'usage, critère de succès, hors périmètre, dépendances possibles).
> 2. Une fois les réponses reçues, identifier le `type` : feature / fix / chore / spike.
> 3. Trouver le prochain numéro `NNN` libre (vérifier `ls backlog/1_ideas/ backlog/2_tasks/ backlog/3_archive/` pour le plus élevé).
> 4. `cp backlog/_template.md backlog/1_ideas/<NNN>-<kebab-slug>.md`
> 5. Éditer le fichier copié : remplir le titre `# H1` + objectif, scénario, AC initial, dépendances éventuelles.
> 6. Mettre à jour `backlog/ROADMAP.md` (ajouter la ligne dans "À explorer").
> 7. Confirmer à l'utilisateur ce qui a été créé et la prochaine étape (`/refine <NNN>` pour affiner, ou `/dev` plus tard quand c'est prêt).

**Cas 2 — l'argument ressemble à un numéro (`NNN`)** : ticket existant à affiner.

Invoquer le sous-agent `pm` via l'outil Agent avec ce contexte :

> Mission : affiner le ticket existant `$ARGUMENTS`.
>
> 1. Lire `backlog/1_ideas/$ARGUMENTS-*.md` ou `backlog/2_tasks/$ARGUMENTS-*.md`.
> 2. Identifier les zones grises (AC vagues, priorité indéfinie, size manquante, scénario peu clair).
> 3. Poser à l'utilisateur des questions ciblées sur ces zones.
> 4. Éditer le ticket pour le rendre actionnable.
> 5. S'il était une `idea` et est maintenant pleinement spécifié (AC clairs + size définie), le promouvoir en `spec` : `mv backlog/1_ideas/<NNN>-*.md backlog/2_tasks/`, mettre à jour `backlog/ROADMAP.md` (statut → `spec`).
> 6. Mettre à jour `backlog/ROADMAP.md`.
> 7. Confirmer à l'utilisateur le nouvel état du ticket.

Dans les deux cas, **suivre la règle d'or** : tout changement de statut → `backlog/ROADMAP.md` à jour.
