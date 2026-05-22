# Backlog — Guide d'utilisation

> **Ce fichier n'est PAS un index.** L'index global est `ROADMAP.md` (racine).
> Pour l'historique complet : `ls archive/`.

## Structure

```
backlog/
├── _template.md   # Gabarit ticket. À copier via `cp`, pas à éditer en place.
├── README.md      # Ce fichier.
├── ideas/         # Tickets statut: idea (brouillons non spécifiés)
├── tasks/         # Tickets statut: spec | dev | test | review (actifs)
└── archive/       # Tickets statut: done
```

## Conventions de nommage

- **Idée brute** : `I-NNN-slug-court.md` (préfixe `I` = idea)
- **Tâche spécifiée** : `T-NNN-slug-court.md` (préfixe `T` = task)
- Le numéro `NNN` est **monotone** (jamais réutilisé), peu importe si I ou T.
- Le slug est en kebab-case, court, descriptif.

Exemples : `I-007-mode-collaboratif.md`, `T-042-auth-email-password.md`.

## Workflow ticket (6 statuts)

```
idea → spec → dev → test → review → done
```

| Statut | Sens | Localisation |
|---|---|---|
| `idea` | Brouillon, pas encore exploré | `ideas/I-NNN-*.md` |
| `spec` | Exploré, AC définis, prêt à attaquer | `tasks/T-NNN-*.md` |
| `dev` | En cours d'implémentation | `tasks/T-NNN-*.md` |
| `test` | Code écrit, tests en écriture/exécution | `tasks/T-NNN-*.md` |
| `review` | Tests verts, attente validation humaine | `tasks/T-NNN-*.md` |
| `done` | Validé et archivé | `archive/T-NNN-*.md` |

## Transitions (le fichier voyage)

```
ideas/I-NNN-slug.md     ─(promotion)─►   tasks/T-NNN-slug.md   ─(archivage)─►   archive/T-NNN-slug.md
       (idea)                              (spec → dev → test → review)              (done)
```

- **Promotion `idea → spec`** : `mv` + renommage (`I-` → `T-`).
- **Transitions internes (`spec → dev → test → review`)** : édition du frontmatter `status:` uniquement.
- **Archivage `review → done`** : `mv` vers `archive/`.

**Règle d'or** : chaque transition de statut → **update immédiat** de `ROADMAP.md`.

## Créer un nouveau ticket

```bash
cp backlog/_template.md backlog/ideas/I-<NNN>-<slug>.md
# Puis éditer le fichier copié : id, title, type, priority, size, dates, contenu.
# Puis update ROADMAP.md.
```

En pratique, utiliser `/refine` (le PM agent fait tout ça).

## Acceptance criteria (AC)

Une liste de checkboxes vérifiables. Doivent répondre à : "comment je sais que c'est terminé ?".

Exemples :
- ✅ `[ ] L'utilisateur peut se connecter avec un email + mot de passe valide`
- ❌ `[ ] Authentification fonctionne` (trop vague)
