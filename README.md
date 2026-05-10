# CarpoolConnect

CarpoolConnect is a community driven platform designed to match drivers with commuters. It helps everyday vehicle owners share their cars with people seeking affordable and reliable rides along similar routes. The project uses real time GPS tracking and a volunteer based token reward system to transform extra seat capacity into shared value.


## Features

*   **Map Centric UI**: A modern interface where the map is the primary background for all journey activities.
*   **Real Time Journey Simulation**: Includes a full simulation flow from finding a ride to active tracking and rating.
*   **Token System**: A volunteer based economy where drivers earn tokens for sharing rides.
*   **Safety First**: Built in SOS emergency features and driver ratings.
*   **Localization**: Support for both English and Amharic languages.

## Project Structure

This project is managed as a Melos monorepo:

*   **apps/mobile_app**: The main Flutter application.
*   **packages/ui_kit**: Shared design system and branding components.
*   **packages/core**: Shared logic, loggers, and mock backend services.
*   **packages/models**: Shared data structures and entities.

## Getting Started

### Prerequisites

*   Flutter SDK
*   Dart SDK
*   Melos (can be run via `dart pub global activate melos`)

### Setup

1.  Clone the repository.
2.  Run `melos bootstrap` from the root directory to initialize the workspace and link packages.

### Running the App

You can run the mobile app using one of the following Melos scripts:

*   **Linux**: `melos run run_mobile_linux`
*   **Windows**: `melos run run_mobile_windows`
*   **Chrome**: `melos run run_mobile_chrome`

Or manually:

```bash
cd apps/mobile_app
flutter run
```

### Running Tests

To run all tests across the entire workspace:

```bash
melos run test_all
```

### Building for Production

To build the Android APK:

```bash
melos run build_apk
```

## Architecture

For a detailed look at the technical implementation and design patterns used in this project, please refer to the [project requirements](./docs/project-phase-i.new.pdf) PDF.
