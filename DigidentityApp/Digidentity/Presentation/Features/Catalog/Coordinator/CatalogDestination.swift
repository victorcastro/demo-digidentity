import SwiftUI

struct CatalogDestination {
    private let detailFactory: CatalogDetailFactory

    init(detailFactory: CatalogDetailFactory) {
        self.detailFactory = detailFactory
    }

    @MainActor
    @ViewBuilder
    func view(for route: CatalogRoute) -> some View {
        switch route {
        case let .detail(item):
            detailFactory.makeView(item: item)
        }
    }
}
