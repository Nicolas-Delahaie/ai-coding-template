---
description: Affiche l'aide du framework (commandes, sub-agents, workflow ticket)
---

Affiche à l'utilisateur un récapitulatif clair et concis du framework. Sans lire ROADMAP ni les tickets — juste le formatage statique ci-dessous.

```
🤖 Framework ai-coding-template

COMMANDES
  /help              Cette aide
  /refine <id?>      Créer une nouvelle idée (sans ID) ou affiner un ticket existant (avec ID).
                     Marche pour feature, fix, chore, spike — peu importe le type.
                     Invoque le sub-agent `pm`.
  /dev <id>          Exécuter un ticket existant (code, tests, debug).
                     Invoque le sub-agent `dev`.

LANGAGE NATUREL (pas besoin de commande)
  "fais-moi le point"    → l'agent lit ROADMAP.md et résume
  "j'ai une idée: X"     → équivalent à /refine "X"
  "il y a un bug: X"     → équivalent à /refine "X" (le PM créera un ticket type fix)

WORKFLOW TICKET
  idea → spec → dev → test → review → done
  Le ticket est UN fichier markdown qui voyage entre :
    backlog/ideas/I-NNN-slug.md  (idea)
    backlog/tasks/T-NNN-slug.md  (spec/dev/test/review)
    backlog/archive/T-NNN-slug.md (done)

RÈGLE D'OR
  Toute modif de statut → ROADMAP.md mis à jour immédiatement.

SUB-AGENTS (invoqués automatiquement par les commandes)
  pm   — clarification / priorisation / roadmap / archivage
  dev  — code / test / debug

POUR EN SAVOIR PLUS
  CLAUDE.md           règles d'or + table de routage
  backlog/README.md   workflow ticket détaillé
  .ai/conventions/    conventions de code
  .ai/decisions/      ADRs (décisions tech)
  .ai/DESIGN.md       choix de conception du framework (lu sur demande uniquement)
```
