# Digidentity iOS

Digidentity is a SwiftUI iOS app built around a layered architecture with clear separation between presentation, domain, data, and core infrastructure.

## Requirements

- iOS Minimum: 18.5
- Swift 6

## Setup

Before running the project, update `Config/Secrets.xcconfig` with the correct `AUTH_TOKEN` value.

```
AUTH_TOKEN = xxxxxxxx
```

## Architecture

The app base follows Clean Architecture.

Third-party integrations follow a Ports & Adapters approach.

The codebase is organized into these layers:

- `Presentation`: SwiftUI views, view models, coordinators, and screen factories.
- `Domain`: use cases, entities, repository protocols, and business rules.
- `Data`: repository implementations plus remote and local data sources.
- `Core`: shared utilities, networking, persistence, and third-party adapters.
- `App`: application bootstrap and dependency composition.

## Patterns Used

- `MVVM`: each screen owns a `ViewModel` that exposes state to the SwiftUI view.
- `Coordinators`: navigation is handled outside the views and composed in dedicated coordinator types.
- `Factory`: screens are created through factories that assemble their dependencies.
- `Repository`: domain code depends on repository protocols, not concrete data sources.
- `Use Case`: application behavior is encapsulated in small use case types.
- `Dependency Injection`: dependencies are created in `AppContainer` and passed downward.
- `Adapter`: third-party libraries are wrapped behind app-specific protocols.
- `Facade`: `RemoteImage` exposes a simple static API over the concrete image loader.

## Features

- SVG image support
- Pull-to-refresh and infinite scrolling
- Cached offline fallback

## Notes

- The project uses SwiftUI and async/await.
- Secrets should not be committed to source control.
- Configuration values should live outside the app target when possible.
