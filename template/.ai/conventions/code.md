# Code conventions

Technical conventions that agents (and the dev) must follow. Flutter/Dart by default.
Adapt to your stack if different.

---

## Dart / Flutter style

- **Lint**: follow `flutter_lints` (present by default in any recent Flutter project). Also enable `prefer_single_quotes`.
- **Formatting**: `dart format .` before each commit (width 80).
- **Naming**:
  - Files: `snake_case.dart`
  - Classes / enums / typedefs: `PascalCase`
  - Methods, variables, parameters: `camelCase`
  - Constants: `lowerCamelCase` (not `SCREAMING_SNAKE_CASE` in Dart)
  - Private: `_` prefix (file-private)
- **Imports**:
  1. `dart:` core
  2. `package:` (Flutter + third-party)
  3. `package:<own_app>/` (internal)
  4. Relative (`./`, `../`)
  Separated by blank lines. `dart fix` can help.
- **Async**: prefer `async/await` over `.then()`. Always type the return value (`Future<T>`).
- **Null safety**: no `!` unless we can prove it can't be avoided (and a comment explains why).
- **State management**: see the corresponding ADR if decided. Otherwise, ask before introducing a package.
- **Widgets**:
  - Prefer `const` everywhere possible.
  - Split into sub-widgets when `build` exceeds ~50 lines or a block is logically isolated.
  - No business logic in widgets: delegate to a controller / notifier / service.

## Application code architecture

The template **imposes nothing** on the `lib/` structure. The user chooses feature-first, layered, or other based on the project. If a choice is made, record it in an ADR (`.ai/decisions/`).

## Tests

- **Location**: `test/` at root, mirroring `lib/`.
- **Types**:
  - **Unit**: pure logic, services, repositories (mock I/O dependencies).
  - **Widget**: an isolated widget with `WidgetTester`.
  - **Integration**: end-to-end flow with `integration_test/`.
- **Test naming**: `<thing_to_test>_test.dart`.
- **Description convention**: `should <expected behavior> when <condition>`.
- **Coverage**: no strict numeric goal. Cover what is non-trivial and would break silently.
- **Before moving a ticket to `review`**: all tests must pass (`flutter test`).

## Git

- **Branches**: working directly on `main` is accepted in solo. `feature/<slug>` branch if isolating a non-trivial workstream.
- **Commits**: format `<type>(<scope>): <message>` inspired by Conventional Commits.
  - Types: `feat`, `fix`, `chore`, `refactor`, `test`, `docs`, `adr`
  - Examples:
    - `feat(auth): add email/password login`
    - `fix(scroll): prevent crash on empty list`
    - `adr: 0003 choose Riverpod over Bloc`
  - Reference the ticket: `feat(auth): T-042 add login...` (optional but useful).
- **No force-push** on `main`. No `git reset --hard` without confirmation.
- **Hooks**: don't bypass (`--no-verify`) except in documented emergencies.

## Agent workflow (quick reminder)

- Always follow the golden rule: ticket change ⇒ `backlog/ROADMAP.md` up to date.
- Don't over-engineer: YAGNI. No unrequested feature, abstraction, or config option.
- No unnecessary comments: readable code > redundant comments.
- Ask for confirmation before risky actions (deletion, large refactor, package install).
