# CarpoolConnect — Technical Architecture

This document describes the architectural decisions and patterns used in the CarpoolConnect project.

## 1. The Monorepo Structure

CarpoolConnect is organized as a monorepo using **Melos**. This allows us to share code between different layers of the application while maintaining clear boundaries.

### Directory Layout

*   **apps/mobile_app**: The primary Flutter application. It contains the feature logic and UI screens.
*   **packages/ui_kit**: Houses the design system, including themes, custom fonts (Satoshi and Noto Serif Ethiopic), and shared widgets like `BrandText`.
*   **packages/core**: Contains low level utilities, the application logger, and the `MockBackend` used for simulating journey data.
*   **packages/models**: Defines the core data entities (User, Ride, etc.) used across the entire system.

## 2. Feature-First Architecture

The mobile application follows a feature-first organization. Each folder in `lib/src/features/` represents a specific domain of the app (e.g., `authentication`, `commuter`, `driver`, `settings`).

### Internal Feature Structure

*   **presentation/screens**: The UI layouts for the feature.
*   **presentation/widgets**: Components specific to the feature.
*   **providers**: State management logic using **Riverpod**.

## 3. Technology Stack

### State Management: Riverpod

We use Riverpod for reactive state management. It provides a robust way to handle asynchronous data and dependency injection.

### Navigation: GoRouter

The app uses GoRouter for declarative navigation. This simplifies handling deep links and complex routing logic like auth redirects.

### Localization: Intl

The application supports English and Amharic. We use the standard Flutter `intl` package with generated `AppLocalizations` for type-safe string access.

## 4. Journey Simulation Engine

For demonstration purposes, the app includes a sophisticated simulation engine in the `CommuterDashboard`.

*   **GPX Data**: Realistic coordinates are used to simulate paths through Addis Ababa (e.g., Piassa to 4 Kilo).
*   **Smooth Interpolation**: Car movement is interpolated using an `AnimationController` for a high fidelity feel.
*   **Breadcrumb Polylines**: The app draws a history of visited points on the map as the simulation progresses.

## 5. Design Principles

*   **Map First UI**: Floating cards and interactive elements are layered over a full screen map background.
*   **Branding Consistency**: The `BrandText` widget ensures the "CarpoolConnect" trademark is always rendered with the correct typography and tracking.
*   **Volunteer Focused UX**: The interface prioritizes community value over monetary transactions, using a "Tokens" system for rewards.