# Backlog — Référence

> **Ce fichier N'est PAS un index.** L'index global est `backlog/ROADMAP.md`.
> Pour l'historique complet : `ls archive/`.

## Structure

```
backlog/
├── _template.md   # Modèle de ticket (cp pour créer un ticket, ne jamais modifier en place)
├── README.md      # Ce fichier — référence des conventions
├── ROADMAP.md     # Index global + toutes les métadonnées des tickets
├── ideas/         # statut : idea
├── tasks/         # statut : spec | dev | test | review
└── archive/       # statut : done
```

## Convention de nommage

- Les fichiers tickets sont nommés **`NNN-slug.md`** — ex. `042-auth-email-password.md`.
- `NNN` est un **compteur global monotoniquement croissant** (jamais réutilisé), partagé entre tous les dossiers.
- `slug` est un résumé court en kebab-case du titre. Pas de préfixe `I`/`T`.
- Les tickets n'ont **pas de frontmatter YAML**. Le titre est le `# H1` du fichier.
- Toutes les métadonnées (titre, type, size, statut) vivent uniquement dans `ROADMAP.md`.
- Un ticket **conserve son nom toute sa vie** — il ne fait que voyager entre dossiers. Renommer uniquement si le titre change substantiellement.

## Workflow des tickets

```
idea → spec → dev → test → review → done
```

| Statut   | Signification                                   | Dossier    |
| -------- | ----------------------------------------------- | ---------- |
| `idea`   | Brouillon, pas encore spécifié                  | `ideas/`   |
| `spec`   | AC définis + size fixée, prêt à traiter         | `tasks/`   |
| `dev`    | En cours d'implémentation                       | `tasks/`   |
| `test`   | Code terminé, tests en cours d'écriture/exéc.   | `tasks/`   |
| `review` | Tests au vert, en attente de validation humaine | `tasks/`   |
| `done`   | Validé et archivé                               | `archive/` |

Tout changement de statut doit être reflété dans **à la fois** le dossier et le ROADMAP — ils sont toujours synchronisés.

## Métadonnées des tickets

Définies une seule fois dans ROADMAP.md, jamais dans le fichier ticket.

- **type** : `feature` (nouvelle capacité) · `fix` (bug) · `chore` (maintenance/refacto) · `spike` (exploration timboxée)
- **size** : estimation temporelle — `10min` · `1h` · `3h` · `3h+` (tout `3h+` → envisager de découper)

## Critères d'acceptation (AC)

Cases à cocher vérifiables. Doit répondre à : "comment je sais que c'est fait ?".

- ✅ `[ ] L'utilisateur peut se connecter avec un email + mot de passe valides`
- ❌ `[ ] L'authentification fonctionne` (trop vague)
