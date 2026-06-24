---
description: Afficher l'aide du framework (commandes, sous-agents, workflow des tickets)
---

Afficher un résumé clair et concis du framework à l'utilisateur. Sans lire ROADMAP ni les tickets — juste la mise en forme statique ci-dessous.

```
🤖 Framework ai-coding-template

COMMANDES
  /help              Cette aide
  /refine <id?>      Créer une nouvelle idée (sans ID) ou affiner un ticket existant (avec ID).
                     Fonctionne pour feature, fix, chore, spike — quel que soit le type.
                     Invoque le sous-agent `pm`.
  /dev <id>          Exécuter un ticket existant (code, tests, debug).
                     Invoque le sous-agent `dev`.

LANGAGE NATUREL (aucune commande nécessaire)
  "donne-moi un statut"     → l'agent lit backlog/ROADMAP.md et résume
  "j'ai une idée : X"       → équivalent à /refine "X"
  "il y a un bug : X"       → équivalent à /refine "X" (le PM créera un ticket fix)

WORKFLOW DES TICKETS
  idea → spec → dev → test → review → done
  Le ticket est UN fichier markdown qui voyage entre :
    backlog/1_ideas/NNN-slug.md    (idea)
    backlog/2_tasks/NNN-slug.md    (spec/dev/test/review)
    backlog/3_archive/NNN-slug.md  (done)

RÈGLE D'OR
  Tout changement de statut → backlog/ROADMAP.md mis à jour immédiatement.

SOUS-AGENTS (invoqués automatiquement par les commandes)
  pm   — clarification / priorisation / roadmap / archivage
  dev  — code / test / debug

POUR EN SAVOIR PLUS
  CLAUDE.md           règles d'or + table de routage
  backlog/README.md   workflow détaillé des tickets
  docs/conventions/   conventions de code
  docs/decisions/     ADRs (décisions tech)
```
