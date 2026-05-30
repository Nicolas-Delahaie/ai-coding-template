# CLAUDE.md — ai-coding-template (repo de développement)

Ce dépôt **produit** un template de méthodologie IA. Il ne l'utilise pas.

## Distinction clé

- **`template/`** — le template distribué. Tout ce qui s'y trouve (`.ai/`, `.claude/`, `backlog/`, `CLAUDE.md`) est copié tel quel dans les projets cibles par `install.sh`. C'est le produit.
- **Racine** — la plomberie du dépôt, qui n'est PAS distribuée : `README.md`, `install.sh`, `.gitignore`, ce `CLAUDE.md`.

## Règle d'or

Quand tu travailles sur le template, modifie **dans `template/`**. Ne confonds jamais le `CLAUDE.md` racine (ce fichier, méta) avec `template/CLAUDE.md` (la méthodologie distribuée).

## Tester l'installeur

`install.sh` télécharge le dépôt depuis GitHub puis copie le contenu de `template/` à la racine du projet courant. Toute modif de la structure de `template/` est prise en compte automatiquement — pas de liste à maintenir.
