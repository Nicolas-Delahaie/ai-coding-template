# CLAUDE.md — ai-coding-template (repo de développement)

Ce dépôt **produit** un template de méthodologie IA. Il ne l'utilise pas.

## Distinction clé

- **`templates/`** — les templates distribués. Un sous-dossier par langue (`english/`, `french/`…). Le contenu du dossier langue choisi est copié tel quel dans les projets cibles par `apply.sh`. C'est le produit.
- **Racine** — la plomberie du dépôt, qui n'est PAS distribuée : `README.md`, `apply.sh`, `.gitignore`, ce `CLAUDE.md`.
- **`.claude/`** à la racine — commandes Claude Code pour ce dépôt de dev uniquement (ex. `/sync-langs`). Ce dossier n'est PAS distribué et n'a rien à voir avec `templates/{lang}/.claude/` qui, lui, est distribué.

## Règle d'or

Quand tu travailles sur le template, modifie **dans `templates/{lang}/`**. Ne confonds jamais le `CLAUDE.md` racine (ce fichier, méta) avec `templates/{lang}/CLAUDE.md` (la méthodologie distribuée).

## Gérer les traductions

Les traductions vivent dans `templates/` et sont versionnées. On ne les régénère pas à la volée — cela évite la divergence non-déterministe lors des mises à jour.

**Modifier une langue existante**

1. Modifie les fichiers dans `templates/{lang}/`
2. Lance `/sync-langs` — Claude détecte la langue source depuis le diff git et propage les changements (diff-only) vers toutes les autres langues existantes
3. Commite le tout

**Ajouter une nouvelle langue**

Lance `/sync-langs {language}` (ex. `/sync-langs spanish`). Claude bootstrap `templates/spanish/` depuis l'anglais en suivant les règles de `TRANSLATION_RULES.md`, puis rappelle de commiter pour figer la traduction.

## Tester apply.sh

`apply.sh` télécharge le dépôt depuis GitHub, demande la langue souhaitée parmi les dossiers disponibles dans `templates/`, et copie le contenu à la racine du projet cible. Si la langue demandée n'existe pas, il affiche un prompt de traduction.
