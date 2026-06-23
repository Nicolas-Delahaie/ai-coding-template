# Conventions de code

Conventions techniques que les agents (et le dev) doivent suivre. Flutter/Dart par défaut.
Adapter à votre stack si différente.

---

## Style Dart / Flutter

- **Lint** : suivre `flutter_lints` (présent par défaut dans tout projet Flutter récent). Activer aussi `prefer_single_quotes`.
- **Formatage** : `dart format .` avant chaque commit (largeur 80).
- **Nommage** :
  - Fichiers : `snake_case.dart`
  - Classes / enums / typedefs : `PascalCase`
  - Méthodes, variables, paramètres : `camelCase`
  - Constantes : `lowerCamelCase` (pas de `SCREAMING_SNAKE_CASE` en Dart)
  - Privé : préfixe `_` (privé au fichier)
- **Imports** :
  1. `dart:` core
  2. `package:` (Flutter + tiers)
  3. `package:<own_app>/` (interne)
  4. Relatifs (`./`, `../`)
     Séparés par des lignes vides. `dart fix` peut aider.
- **Async** : préférer `async/await` à `.then()`. Toujours typer la valeur de retour (`Future<T>`).
- **Null safety** : pas de `!` sauf si on peut prouver que c'est inévitable (et un commentaire explique pourquoi).
- **Gestion d'état** : voir l'ADR correspondant si décidé. Sinon, demander avant d'introduire un package.
- **Widgets** :
  - Préférer `const` partout où c'est possible.
  - Découper en sous-widgets quand `build` dépasse ~50 lignes ou qu'un bloc est logiquement isolé.
  - Pas de logique métier dans les widgets : déléguer à un controller / notifier / service.

## Architecture du code applicatif

Le template **n'impose rien** sur la structure de `lib/`. L'utilisateur choisit feature-first, layered, ou autre selon le projet. Si un choix est fait, le consigner dans un ADR (`docs/decisions/`).

## Tests

- **Emplacement** : `test/` à la racine, en miroir de `lib/`.
- **Types** :
  - **Unit** : logique pure, services, repositories (mocker les dépendances I/O).
  - **Widget** : un widget isolé avec `WidgetTester`.
  - **Integration** : flux bout-en-bout avec `integration_test/`.
- **Nommage des tests** : `<chose_à_tester>_test.dart`.
- **Convention de description** : `should <comportement attendu> when <condition>`.
- **Couverture** : pas d'objectif numérique strict. Couvrir ce qui est non trivial et pourrait casser silencieusement.
- **Avant de passer un ticket en `review`** : tous les tests doivent passer (`flutter test`).

## Git

- **Branches** : travailler directement sur `main` est accepté en solo. Branche `feature/<slug>` si on isole un workstream non trivial.
- **Commits** : format `<type>(<scope>): <message>` inspiré de Conventional Commits.
  - Types : `feat`, `fix`, `chore`, `refactor`, `test`, `docs`, `adr`
  - Exemples :
    - `feat(auth): add email/password login`
    - `fix(scroll): prevent crash on empty list`
    - `adr: 0003 choose Riverpod over Bloc`
  - Référencer le ticket : `feat(auth): T-042 add login...` (optionnel mais utile).
- **Pas de force-push** sur `main`. Pas de `git reset --hard` sans confirmation.
- **Hooks** : ne pas contourner (`--no-verify`) sauf urgence documentée.

## Workflow agent (rappel rapide)

- Toujours suivre la règle d'or : changement de ticket ⇒ `backlog/ROADMAP.md` à jour.
- Ne pas sur-ingénier : YAGNI. Pas de fonctionnalité, abstraction ou option non demandée.
- Pas de commentaires inutiles : code lisible > commentaires redondants.
- Demander confirmation avant les actions risquées (suppression, grand refactor, installation de package).
