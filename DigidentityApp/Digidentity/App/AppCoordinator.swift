import SwiftUI

struct AppCoordinator {
    private let container: AppContainer

    init(container: AppContainer) {
        self.container = container
    }

    @MainActor
    func start() -> some View {
        CatalogCoordinator(container: container).start()
    }
}
