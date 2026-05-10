# Carpool Connect — Technical Architecture

## Vision

A **full-stack Dart monorepo** where mobile, admin, and backend are developed and deployed together. The project uses **Flutter**, **Riverpod 3.0**, **Melos**, and **Reactive Forms**. The architecture follows a **Clean Architecture** layered approach to ensure long-term maintainability and separation of concerns.

## 1. The Monorepo Blueprint

In a monorepo, your "apps" are thin wrappers that orchestrate logic, while your "packages" house the heavy lifting (business logic, models, and UI components).

### Recommended Directory Layout

```text
/
├── melos.yaml                # Monorepo orchestration
├── apps/
│   ├── mobile_app/           # Flutter (iOS/Android)
│   ├── admin_dashboard/      # Flutter Web
│   └── api_handler/          # Dart Backend (Dart Frog or Shelf)
├── packages/
│   ├── core/                 # Shared constants, theme data, utilities
│   ├── api_client/           # Shared Retrofit client & interceptors
│   ├── models/               # Shared Freezed DTOs (Source of Truth)
│   └── ui_kit/               # Shared design system widgets
└── tool/                     # Custom CLI tools or Mason bricks

```

---

## 2. Core Architecture: Feature-First Clean Architecture

For the apps themselves, organize by **Feature** rather than by file type. This prevents the "folder bloat" common in mid-sized projects.

### Inside `apps/mobile_app/lib/src/features/`

Each feature (e.g., `authentication`, `dashboard`) should follow this internal structure:

* **`data/`**: Repositories implementations and data sources (local/remote).
* **`domain/`**: Pure Dart entities and use cases (logic that doesn't care about the UI).
* **`presentation/`**:
* **`providers/`**: Riverpod 3.0 controllers (using `@riverpod`).
* **`widgets/`**: Reusable UI components specific to this feature.
* **`screens/`**: The actual page layouts.



---

## 3. The Recommended Tech Stack

### State Management: Riverpod 3.0

The modern way to use Riverpod is through **Code Generation**. It removes boilerplate and provides compile-time safety that standard Providers lack.

* **`riverpod_generator`**: Automatically creates your providers from simple functions or classes.
* **`riverpod_lint`**: Essential for catching common mistakes and enforcing best practices during development.

### Complex Forms & Validation: `reactive_forms`

Standard Flutter forms are too imperative for complex logic. **Reactive Forms** treats the form as a data model.

* **Async Validation**: Perfect for "username already exists" checks. You define an `AsyncValidator` that calls your `api_client`.
* **Typed Controls**: Ensures you aren't trying to read a String from a boolean checkbox.

### Networking & Data: The "Holy Trinity"

Since you have a Dart backend, your data models should be shared across the entire monorepo.

1. **`freezed`**: For immutable models and union types (great for "Loading/Error/Success" states).
2. **`dio`**: The engine for your network requests, allowing for easy token refreshing and logging interceptors.
3. **`retrofit`**: Generates the implementation of your API client. You just write the interface; it writes the code.

### Testing & Quality Assurance

* **`patrol`**: The gold standard for E2E testing. It handles native permission dialogs (GPS, Camera) which standard Flutter tests cannot.
* **`mocktail`**: For easy, type-safe unit testing of your repositories and providers.

---

## 4. Development Workflow Tools

### Melos (Monorepo Management)

Melos allows you to run commands across all packages. For example, you can define a `build_all` command in `melos.yaml` that runs the code generator for every app and package simultaneously:

```yaml
scripts:
  build:all:
    run: melos exec -- "dart run build_runner build --delete-conflicting-outputs"
    description: Run build_runner for all packages.

```

### Mason (Scaffolding)

Use **Mason** to create "Bricks" for your team. Instead of manually creating the 5+ files needed for a new feature, you can run `mason make feature --name search` to generate the entire folder structure with the Riverpod providers already wired up.

---

## 5. Summary Table

| Category | Package | Why? |
| --- | --- | --- |
| **Monorepo** | `melos` & Dart pub workspaces | Bridges the 3 apps and shared packages. |
| **State** | `flutter_riverpod` | Compile-time safe reactive state. |
| **API Logic** | `retrofit` | Keeps Mobile, Web, and Backend in sync. |
| **Forms** | `reactive_forms` | Handles complex async validation gracefully. |
| **Navigation** | `go_router` | Handles deep-linking and web URL navigation. |
| **E2E Testing** | `patrol` | Interactions with Native OS dialogs. |

This setup ensures that as your project grows, your shared `models` and `api_client` act as the glue, preventing logic drift between your dashboard, mobile app, and backend.