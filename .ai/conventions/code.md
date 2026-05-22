# Conventions de code

Conventions techniques que les agents (et le dev) doivent respecter. Flutter/Dart par défaut.
Adapter à votre stack si différent.

---

## Style Dart / Flutter

- **Lint** : respecter `flutter_lints` (présent par défaut dans tout projet Flutter récent). Activer aussi `prefer_single_quotes`.
- **Formatage** : `dart format .` avant chaque commit (largeur 80).
- **Naming** :
  - Fichiers : `snake_case.dart`
  - Classes / enums / typedefs : `PascalCase`
  - Méthodes, variables, paramètres : `camelCase`
  - Constantes : `lowerCamelCase` (pas `SCREAMING_SNAKE_CASE` en Dart)
  - Private : préfixe `_` (privé au fichier)
- **Imports** :
  1. `dart:` core
  2. `package:` (Flutter + tiers)
  3. `package:<own_app>/` (interne)
  4. Relatifs (`./`, `../`)
  Bloc vides séparés. `dart fix` peut aider.
- **Async** : préférer `async/await` à `.then()`. Toujours typer le retour (`Future<T>`).
- **Null safety** : pas de `!` sauf si on prouve qu'on ne peut pas l'éviter (et un commentaire dit pourquoi).
- **State management** : voir l'ADR correspondant si décidé. Sinon, demander avant d'introduire un package.
- **Widgets** :
  - Préférer `const` partout où possible.
  - Découper en sous-widgets dès que `build` dépasse ~50 lignes ou qu'un bloc est logiquement isolé.
  - Pas de logique métier dans les widgets : déléguer à un controller / notifier / service.

## Architecture du code applicatif

Le template **n'impose rien** sur la structure de `lib/`. Le user choisit feature-first, layered, ou autre selon le projet. Si un choix est fait, le consigner dans un ADR (`.ai/decisions/`).

## Tests

- **Localisation** : `test/` à la racine, miroir de `lib/`.
- **Types** :
  - **Unit** : logique pure, services, repositories (mockent les dépendances I/O).
  - **Widget** : un widget isolé avec `WidgetTester`.
  - **Integration** : flux end-to-end avec `integration_test/`.
- **Nommage des tests** : `<thing_to_test>_test.dart`.
- **Convention de description** : `should <expected behavior> when <condition>`.
- **Couverture** : pas d'objectif chiffré strict. Couvrir ce qui est non-trivial et qui casserait silencieusement.
- **Avant de passer un ticket en `review`** : tous les tests doivent passer (`flutter test`).

## Git

- **Branches** : travail direct sur `main` accepté en solo. Branche `feature/<slug>` si on veut isoler un chantier non-trivial.
- **Commits** : format `<type>(<scope>): <message>` inspiré de Conventional Commits.
  - Types : `feat`, `fix`, `chore`, `refactor`, `test`, `docs`, `adr`
  - Exemples :
    - `feat(auth): ajout login email/password`
    - `fix(scroll): éviter le crash sur liste vide`
    - `adr: 0003 choix Riverpod plutôt que Bloc`
  - Référencer le ticket : `feat(auth): T-042 ajout login...` (optionnel mais pratique).
- **Pas de force-push** sur `main`. Pas de `git reset --hard` sans confirmation.
- **Hooks** : ne pas bypasser (`--no-verify`) sauf urgence documentée.

## Workflow agent (rappel rapide)

- Toujours respecter la règle d'or : modif d'un ticket ⇒ `ROADMAP.md` à jour.
- Ne pas sur-engineer : YAGNI. Pas de feature, abstraction ou option de config non demandée.
- Pas de commentaires inutiles : code lisible > commentaires redondants.
- Demander confirmation avant les actions risquées (suppression, refactor large, install d'un package).
