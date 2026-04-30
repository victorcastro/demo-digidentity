import SwiftUI

struct CatalogCoordinator {
    private let container: AppContainer

    init(container: AppContainer) {
        self.container = container
    }

    @MainActor
    func start() -> some View {
        CatalogCoordinatorView(container: container)
    }
}

private struct CatalogCoordinatorView: View {
    private let listFactory: CatalogListFactory
    private let destination: CatalogDestination

    @State private var path: [CatalogRoute] = []

    init(container: AppContainer) {
        let repository = container.makeCatalogRepository()

        listFactory = CatalogListFactory(
            repository: repository
        )
        destination = CatalogDestination(
            detailFactory: CatalogDetailFactory()
        )
    }

    var body: some View {
        NavigationStack(path: $path) {
            listFactory.makeView()
                .navigationDestination(for: CatalogRoute.self) { route in
                    destination.view(for: route)
                }
        }
    }
}
